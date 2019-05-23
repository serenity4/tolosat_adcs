"""Main simulation module, that launches a hand-made prompt interfaced with MATLAB.
"""


import numpy as np
import matlab.engine
import os
import argparse
import json
import colorama
colorama.init()
from . import plot
# ref = matlab.engine.find_matlab()
# print("Session ID found: {}".format(ref[0]))
# eng = matlab.engine.start_matlab(ref[0])


def argparse():
    parser = argparse.ArgumentParser()
    parser.add_argument('model', default='V1',
                        help='Model to load. Choices are: V1 - Detumbling - Control - RW_1')
    parser.add_argument('-end', type=int, default=1000,
                        help="End simulation time")
    parser.add_argument('--run', dest='run', action='store_true', help="Call with this option to automatically run the Simulink model when loaded.")
    parser.add_argument('--desktop', dest='desktop', action='store_true', help="Call with this option to run MATLAB in desktop mode.")
    parser.add_argument('-b, --basename', type=str, default='simres.json', help="Basename used for the simulation output.")
    args = parser.parse_args()
    return args

def set_paths(output_basename, model):
    """Sets various paths necessary for the simulation processing.

    Note:
        Works only for Windows computers.

    Args:
        output_basename (str): Basename used for the simulation output.

    Returns:
        path (str): Unix-formatted path.
        path_simres (str): Path for the simulation data folder (used for post-processing).
        model_path (str): Path of the Simulink model.
        workspace_path (str): Path of the workspace CONF folder.
        pilia_path (str): Path of the PILIA folder.
    """

    path = os.getcwd().replace('\\', '/')
    path_simres = 'pythondev/simres_data'
    workspace_path = "PILIA/PROJECTS/tolosat_adcs_kalman/V1/CONF"
    pilia_path = "PILIA"
    assert path.split(
        '/')[-1] == 'tolosat_adcs', "You must launch from the pythondev root folder"
    if model == 'V1' or model == 'Detumbling' or model == 'Control' or 'RW_1':
        model = model + '.slx'
        model_path = 'PILIA/PROJECTS/tolosat_adcs_kalman/V1/' + model
    else:
        print("Unknown model. Process aborted.")
        exit()

    return path, path_simres, model_path, workspace_path, pilia_path

def start_matlab(path, sim_param):
    """Launches the MATLAB/Simulink engine and opens the model specified by model_path.

    Args:
        model_path (str): Path for the Simulink model we want to open.
        pilia_path (str): PILIA folder path. Default is ./PILIA.
        sim_param (dict): Dictionary containing a set of parameters for the Simulink configuration.

    """

    if sim_param['desktop']:
        eng = matlab.engine.start_matlab("-desktop")
    else:
        eng = matlab.engine.start_matlab()
    print("MATLAB opened. Adding PILIA libraries to path...")
    # starts the engine and opens it
    eng.eval('addpath(genpath(' + path['pilia'] + '))')
    # add PILIA to path as it tends to slip away from MATLAB's path
    eng.eval('cd ' + path['workspace'], nargout=0)
    print("Setting configuration parameters...")
    ConfParam = eng.eval('Main_ConfLaunch()')
    eng.workspace['ConfParam'] = ConfParam
    # builds configuration parameters
    print("Opening model " + sim_param['model'] + "...")
    eng.open_system(path['model'], 'window', nargout=0)
    print("Model opened.")
    # opens the Simulink model
    model_name = eng.eval('gcs')
    # gets current simulink model name
    eng.set_param(model_name, 'StartTime', '0', nargout=0)
    eng.set_param(model_name, 'StopTime', str(end), nargout=0)
    eng.set_param(model_name, 'Solver', 'ode4', nargout=0)
    eng.set_param(model_name, 'FixedStep', 'ConfParam.confOrbit.dt', nargout=0)
    eng.set_param(model_name, 'SaveTime', 'off', nargout=0)
    eng.set_param(model_name, 'LibraryLinkDisplay', 'all', nargout=0)
    eng.set_param(model_name, 'MultiTaskRateTransMsg', 'warning', nargout=0)
    if sim_param['run']:
        eng.eval("sim(\'" + model_name + "\');")
    return eng


def main():

    args = argparse()
    end = args.end
    model = args.model
    run = args.run
    desktop = args.desktop
    output_basename = args.basename
    path, path_simres, model_path, workspace_path, pilia_path = set_paths(output_basename, model)
    path = dict(path=path, simres=path_simres, model=model_path, workspace=workspace_path, pilia=pilia_path)
    sim_param = dict(end=end, run=run, desktop=desktop, model=model)
    print("Launching MATLAB...")
    eng = start_matlab(model_path, pilia_path, workspace_path, sim_param, desktop)
    print("\n\033[32;1;4mWelcome to the PILIA python interfacer! Available commands are:")
    print("{:<7} - displays help\n{:<7} - update workspace with new configuration variables\n{:<7} - post-processes data\n{:<7} - exits the prompt\033[30;0;4m\n".format("help", "update", "pp", "exit"))



    while 1:
        command = input().split(sep=" ")
        if command[0] == 'help':
            print("You may configure the parameters in your CONF folder, then update the model to take the changes into account.")
        elif command[0] == 'update':
            eng.eval('clear', nargout=0)
            ConfParam = eng.eval('Main_ConfLaunch()')
            eng.workspace['ConfParam'] = ConfParam
            print('----- Configuration parameters successfully updated.')
        elif command[0] == 'pp':
            print("Post-processing started...")
            simres = {}
            simres['results'] = {
            'rw1_omega': eng.workspace['rw1_omega'],
            'rw2_omega': eng.workspace['rw2_omega'],
            'rw3_omega': eng.workspace['rw3_omega'],
            'rw4_omega': eng.workspace['rw4_omega'],
            'in_range': eng.workspace['in_range'],
            }
            simres['conf'] = {
            'maxAngle_Obj': eng.workspace['ConfParam']['confMaxAngle']['Obj'],
            'maxAngle_ES': eng.workspace['ConfParam']['confMaxAngle']['ES'],
            'inertial_pointing_com': eng.workspace['ConfParam']['confInerPoint']['Qcom'],
            'ES_freq': eng.workspace['ConfParam']['confES']['frequency'],
            'time_step': eng.workspace['ConfParam']['confOrbit']['dt'],
            }
            simres['properties'] = {
            'mass': eng.workspace['ConfParam']['confSatFeatures']['mass'],
            'inertia': eng.workspace['ConfParam']['confSatFeatures']['I_sat'],
            }
            print("Sending simulation results structure to MATLAB.")
            print("JSON file creation...")
            eng.workspace['simres'] = simres
            eng.workspace['json_simres'] = eng.eval("jsonencode(simres);")
            # change directory to the location where you want to drop the file
            eng.eval("cd(\'" + path + "/" + path_simres + "\')")
            eng.workspace['output'] = eng.eval(
                "fopen(\'" + output_basename + "\', 'w');")
            eng.eval("fwrite(output, json_simres, 'char')")
            eng.eval("fclose(output);")
            eng.eval(
            "cd(\'" + path + "/PILIA/PROJECTS/tolosat_adcs_kalman/V1/CONF\')")
            print("JSON file succesfully created at " +
                  path_simres + "/" + simres_output)
            if len(command) > 1 and (command[1] == '-plot' or command[1] == '-p'):
                print("Plotting simulation results...")
                if len(command) > 2 and command[2] == 'plotly' or command[1] == '-p':
                    plot.plotly_json(path_simres + '/' + simres_output)
                else:
                    plot.plot_json(path_simres + '/' + simres_output)
                print("End of post-processing.")
        elif command[0] == 'exec':
            eng.eval(command[1:])
        elif command[0] == 'exit':
            # os.system(r'del -Force -Recurse .\PILIA\PROJECTS\tolosat_adcs_kalman\V1\CONF\slprj')
            exit()


if __name__ == "__main__":
    main()
