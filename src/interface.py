"""Main simulation module, that launches a handmade prompt interfaced with MATLAB.
"""


import numpy as np
import matlab.engine
import os
import json
import colorama
colorama.init()
from . import plot
# ref = matlab.engine.find_matlab()
# print("Session ID found: {}".format(ref[0]))
# eng = matlab.engine.start_matlab(ref[0])


def argparse():
    """Parses arguments (including the model for example).
    More information is given when calling the program with the -h flag.

    Returns:
        args (namespace): namespace containing the parsed arguments.
    """
    import argparse
    parser = argparse.ArgumentParser()
    parser.add_argument('model', default='V1',
                        help='Model to load. Choices are: V1 - Detumbling - Control - RW_1')
    parser.add_argument('-end', type=int, default=1000,
                        help="End simulation time")
    parser.add_argument('--run', dest='run', action='store_true', help="Call with this option to automatically run the Simulink model when loaded.")
    parser.add_argument('--desktop', dest='desktop', action='store_true', help="Call with this option to run MATLAB in desktop mode.")
    parser.add_argument('-basename', type=str, default='simres', help="Basename used for the simulation output.")
    parser.add_argument('--load-only', dest='load', action='store_true', help="Use this flag to load the model without opening it.")
    args = parser.parse_args()
    return args

def set_paths(output_basename, model):
    """Sets various paths necessary for the simulation processing.

    Note:
        Works only for Windows computers.

    Args:
        output_basename (str): Basename used for the simulation output.

    Returns:
        path_dict (dict): Dicitonary containing the following keys/values:
            path (str): Unix-formatted path of the current working directory
            simres (str): Path of the simulation data folder (used for post-processing).
            simres_file (str): Name of the simulation data file (used for post-processing)
            model (str): Path of the Simulink model.
            workspace (str): Path of the workspace CONF folder.
            pilia (str): Path of the PILIA folder.
    """

    path = os.getcwd().replace('\\', '/')
    path_simres = 'src/simres_data'
    workspace_path = "PILIA/PROJECTS/tolosat_adcs_kalman/V1/CONF"
    pilia_path = "PILIA"
    assert path.split(
        '/')[-1] == 'tolosat_adcs', "You must launch from the src root folder"
    if model == 'V1' or model == 'Detumbling' or model == 'Control' or 'RW_1':
        model = model + '.slx'
        model_path = 'PILIA/PROJECTS/tolosat_adcs_kalman/V1/' + model
    else:
        print("Unknown model. Process aborted.")
        exit()

    path_dict = dict(path=path, simres=path_simres, model=model_path, workspace=workspace_path, pilia=pilia_path, simres_file=output_basename + ".json")
    return path_dict

def start_matlab(path, sim_param, command):
    """Launches the MATLAB/Simulink engine and opens the model specified by model_path.

    Args:
        model_path (str): Path for the Simulink model we want to open.
        pilia_path (str): PILIA folder path. Default is ./PILIA.
        sim_param (dict): Dictionary containing a set of parameters for the Simulink configuration.

    """

    print("Launching MATLAB...")

    if sim_param['desktop']:
        eng = matlab.engine.start_matlab("-desktop")
    else:
        eng = matlab.engine.start_matlab()
    print("MATLAB opened. Adding PILIA libraries to path...")
    # starts the engine and opens it
    eng.eval("addpath(genpath(\'" + path['pilia'] + "\'))")
    # add PILIA to path as it tends to slip away from MATLAB's path
    eng.eval('cd ' + path['workspace'], nargout=0)
    print("Setting configuration parameters...")
    ConfParam = eng.eval('Main_ConfLaunch()')
    eng.workspace['ConfParam'] = ConfParam
    # builds configuration parameters
    if sim_param['load']:
        print("Loading model " + sim_param['model'] + "...")
        eng.load_system(path['model'], nargout=0)
        print("Model lodaded.")
    else:
        print("Opening model " + sim_param['model'] + "...")
        eng.open_system(path['model'], 'window', nargout=0)
        print("Model opened.")
    # opens the Simulink model
    model_name = eng.eval('gcs')
    # gets current simulink model name
    eng.set_param(model_name, 'StartTime', '0', nargout=0)
    eng.set_param(model_name, 'StopTime', str(sim_param['end']), nargout=0)
    eng.set_param(model_name, 'Solver', 'ode4', nargout=0)
    eng.set_param(model_name, 'FixedStep', 'ConfParam.confOrbit.dt', nargout=0)
    eng.set_param(model_name, 'SaveTime', 'off', nargout=0)
    eng.set_param(model_name, 'LibraryLinkDisplay', 'all', nargout=0)
    eng.set_param(model_name, 'MultiTaskRateTransMsg', 'warning', nargout=0)
    if sim_param['run']:
        run(sim_param, model_name, eng, command)
    return eng, model_name

def update(eng):
    eng.eval('clear', nargout=0)
    ConfParam = eng.eval('Main_ConfLaunch()')
    eng.workspace['ConfParam'] = ConfParam
    print('----- Configuration parameters successfully updated.')

def run(sim_param, model_name, eng, command):
    if command is not None and len(command) > 1:
        if len(command) == 3 and command[1] == '-end':
            eng.set_param(model_name, 'StopTime', command[2], nargout=0)
            sim_param['end'] = command[2]
    print("Running the simulation (end = " + str(sim_param['end']) + ")...")
    eng.eval("sim(\'" + model_name + "\');")
    print("End of simulation.")


def postprocess(eng, path, output_basename, command, sim_param):
    print("Post-processing started...")
    simres = {}
    simres['results'] = {
    'rw1_omega': eng.workspace['rw1_omega'],
    'in_range': eng.workspace['in_range'],
    'satpos_j2000': eng.workspace['SatPos_J2000'],

    }
    simres['conf'] = {
    'maxAngle_Obj': eng.workspace['ConfParam']['confMaxAngle']['Obj'],
    'maxAngle_ES': eng.workspace['ConfParam']['confMaxAngle']['ES'],
    'inertial_pointing_com': eng.workspace['ConfParam']['confInerPoint']['Qcom'],
    'ES_freq': eng.workspace['ConfParam']['confES']['frequency'],
    'time_step': eng.workspace['ConfParam']['confOrbit']['dt'],
    'end': sim_param['end'],
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
    eng.eval("cd(\'" + path['path'] + "/" + path['simres'] + "\')")
    eng.workspace['output'] = eng.eval(
        "fopen(\'" + path['simres_file'] + "\', 'w');")
    eng.eval("fwrite(output, json_simres, 'char')")
    eng.eval("fclose(output);")
    eng.eval(
    "cd(\'" + path['path'] + "/PILIA/PROJECTS/tolosat_adcs_kalman/V1/CONF\')")
    print("JSON file succesfully created at " +
          path['simres'] + "/" + path['simres_file'])
    if len(command) > 1:
        if command[1] == '-plot' or command[1] == '-p':
            save_name = None
        if len(command) == 3:
            save_name = command[2]
        print("Plotting simulation results...")
        plot.plotly_json(path['simres'] + '/' + path['simres_file'], save_name = save_name)
        print("End of post-processing.")


def main():

    args = argparse()
    model = args.model
    output_basename = args.basename
    path = set_paths(output_basename, model)

    sim_param = dict(end=args.end, run=args.run, desktop=args.desktop, model=model, load=args.load)
    eng, model_name = start_matlab(path, sim_param, command=None)

    print("\n\033[32;1;4mWelcome to the PILIA python interfacer! Available commands are:")
    print("{:<7} - displays help\n{:<7} - update workspace with new configuration variables\n{:<7} - post-processes data\n{:<7} - exits the prompt\033[30;0;4m\n".format("help", "update", "pp", "exit"))

    while 1:
        print(">>>  ", end="", flush=True)
        command = input().split(sep=" ")
        if command[0] == 'help':
            print("You may configure the parameters in your CONF folder, then update the model to take the changes into account.")
        elif command[0] == 'run': run(sim_param, model_name, eng, command)
        elif command[0] == 'update': update(eng)
        elif command[0] == 'pp': postprocess(eng, path, output_basename, command, sim_param)
        elif command[0] == 'exec': eng.eval(command[1:])
        elif command[0] == 'exit':
            # os.system(r'del -Force -Recurse .\PILIA\PROJECTS\tolosat_adcs_kalman\V1\CONF\slprj')
            exit()


if __name__ == "__main__":
    main()
