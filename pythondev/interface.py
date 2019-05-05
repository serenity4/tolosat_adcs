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


def main():

    parser = argparse.ArgumentParser()
    parser.add_argument('model', default='V1',
                        help='Model to load. Choices are: V1 - Detumbling - Control - RW_1')
    parser.add_argument('-end', type=int, default=1000,
                        help="End simulation time")
    parser.add_argument('--run', dest='run', action='store_true', help="Call with this option to automatically run the Simulink model when loaded.")
    parser.add_argument('--desktop', dest='desktop', action='store_true', help="Call with this option to run MATLAB in desktop mode.")
    args = parser.parse_args()
    end = args.end
    model = args.model
    run = args.run
    desktop = args.desktop
    path = os.getcwd().replace('\\', '/')
    path_simres = 'pythondev/simres_data'
    simres_output = 'simres.json'
    assert path.split(
        '/')[-1] == 'tolosat_adcs', "You must launch from the pythondev root folder"
    if model == 'V1' or model == 'Detumbling' or model == 'Control' or 'RW_1':
        model = model + '.slx'
        model_path = 'PILIA/PROJECTS/tolosat_adcs_kalman/V1/' + model
    # elif model == 'complete':
    #     model = model + '.slx'
    #     model_path = 'PILIA/PROJECTS/tolosat_adcs_kalman/Complete/complete/' + model
    else:
        print("Unknown model. Process aborted.")
        exit()

    print("Launching MATLAB...")
    if desktop:
        eng = matlab.engine.start_matlab("-desktop")
    else:
        eng = matlab.engine.start_matlab()
    print("MATLAB opened. Adding PILIA libraries to path...")
    # starts the engine and opens it
    eng.eval('addpath(genpath("PILIA"))')
    # add PILIA to path as it tends to slip away from MATLAB's path
    eng.eval('cd PILIA/PROJECTS/tolosat_adcs_kalman/V1/CONF', nargout=0)
    print("Setting configuration parameters...")
    ConfParam = eng.eval('Main_ConfLaunch()')
    eng.workspace['ConfParam'] = ConfParam
    # builds configuration parameters
    print("Opening model " + model + "...")
    eng.open_system(model_path, 'window', nargout=0)
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
    if run:
        eng.eval("sim(\'" + model_name + "\');")
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
            # change directory
            simres = {}
            simres['rw1_omega'] = eng.workspace['rw1_omega']
            simres['rw2_omega'] = eng.workspace['rw2_omega']
            simres['rw3_omega'] = eng.workspace['rw3_omega']
            simres['rw4_omega'] = eng.workspace['rw4_omega']
            simres['in_range'] = eng.workspace['in_range']
            print("Sending simulation results structure to MATLAB.")
            print("JSON file creation...")
            eng.workspace['simres'] = simres
            # eng.workspace['simres']['rw1_omega'] = eng.workspace['RW1_omega']
            # eng.workspace['simres']['rw2_omega'] = eng.workspace['RW2_omega']
            # eng.workspace['simres']['rw3_omega'] = eng.workspace['RW3_omega']
            # eng.workspace['simres']['rw4_omega'] = eng.workspace['RW4_omega']
            # eng.eval("save('simres.mat', 'simres')")
            eng.workspace['json_simres'] = eng.eval("jsonencode(simres);")
            eng.eval("cd(\'" + path + "/" + path_simres + "\')")
            eng.workspace['output'] = eng.eval(
                "fopen(\'" + simres_output + "\', 'w');")
            eng.eval("fwrite(output, json_simres, 'char')")
            eng.eval("fclose(output);")
            eng.eval(
            "cd(\'" + path + "/PILIA/PROJECTS/tolosat_adcs_kalman/V1/CONF\')")
            print("JSON file succesfully created at " +
                  path_simres + "/" + simres_output)
            if len(command) > 1 and command[1] == '-plot':
                print("Plotting simulation results...")
                if len(command) > 2 and command[2] == 'plotly':
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
