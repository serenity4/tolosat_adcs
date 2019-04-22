import numpy as np
import matlab.engine
import os
import argparse
import json
from . import plot
# ref = matlab.engine.find_matlab()
# print("Session ID found: {}".format(ref[0]))
# eng = matlab.engine.start_matlab(ref[0])

def main():

    parser = argparse.ArgumentParser()
    parser.add_argument('model', default='V1', help='Model to load. Choices are: V1 - Detumbling - Control - RW_1')
    parser.add_argument('-end', type=int, default=5000, help="End simulation time")
    args = parser.parse_args()
    end = args.end
    model = args.model
    path = os.getcwd().replace('\\', '/')
    path_simres = 'pythondev/simres_data'
    simres_output = 'simres.json'
    assert path.split('/')[-1] == 'tolosat_adcs', "You must launch from the pythondev root folder"
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
    eng = matlab.engine.start_matlab("-desktop")
    print("MATLAB opened. Adding PILIA libraries to path...")
    ### starts the engine and opens it
    eng.eval('addpath(genpath("PILIA"))')
    ### add PILIA to path as it tends to slip away from MATLAB's path
    eng.eval('cd PILIA/PROJECTS/tolosat_adcs_kalman/V1/CONF', nargout=0)
    print("Setting configuration parameters...")
    ConfParam = eng.eval('Main_ConfLaunch()')
    eng.workspace['ConfParam'] = ConfParam
    ## builds configuration parameters
    print("Opening model " + model + "...")
    eng.open_system(model_path, 'window', nargout=0)
    print("Model opened.")
    ### opens the Simulink model
    model_name = eng.eval('gcs')
    ### gets current simulink model name
    eng.set_param(model_name,'StartTime','0', nargout=0);
    eng.set_param(model_name,'StopTime', str(end), nargout=0);
    eng.set_param(model_name,'Solver','ode4', nargout=0);
    eng.set_param(model_name,'FixedStep','ConfParam.confOrbit.dt', nargout=0);
    eng.set_param(model_name,'SaveTime','off', nargout=0);
    eng.set_param(model_name,'LibraryLinkDisplay','all', nargout=0);
    eng.set_param(model_name,'MultiTaskRateTransMsg','warning', nargout=0)
    # eng.eval("sim(\'" + model_name + "\');")
    print("Welcome to the PILIA python interfacer! Available commands are:")
    print("{:<7} - displays help\n{:<7} - update workspace with new configuration variables\n{:<7} - post-processes data\n{:<7} - exits the prompt".format("help", "update", "pp", "exit"))

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
            eng.eval("cd(\'" + path + "/" + path_simres + "\')")
            simres = {}
            simres['rw1_omega'] = eng.workspace['RW1_omega']
            simres['rw2_omega'] = eng.workspace['RW2_omega']
            simres['rw3_omega'] = eng.workspace['RW3_omega']
            simres['rw4_omega'] = eng.workspace['RW4_omega']
            print("Sending simulation results structure to MATLAB.")
            print("JSON file creation...")
            eng.workspace['simres'] = simres
            # eng.workspace['simres']['rw1_omega'] = eng.workspace['RW1_omega']
            # eng.workspace['simres']['rw2_omega'] = eng.workspace['RW2_omega']
            # eng.workspace['simres']['rw3_omega'] = eng.workspace['RW3_omega']
            # eng.workspace['simres']['rw4_omega'] = eng.workspace['RW4_omega']
            # eng.eval("save('simres.mat', 'simres')")
            eng.workspace['json_simres'] = eng.eval("jsonencode(simres);")
            eng.workspace['output'] = eng.eval("fopen(\'" + simres_output + "\', 'w');")
            eng.eval("fwrite(output, json_simres, 'char')")
            eng.eval("fclose(output);")
            print("JSON file succesfully created at " + path_simres + "/" + simres_output)
            if len(command) > 1 and command[1] == '-plot':
                print("Plotting simulation results...")
                plot.plot_json(path_simres + '/' + simres_output)
                print("End of post-processing.")
            eng.eval("cd(\'" + path + "/PILIA/PROJECTS/tolosat_adcs_kalman/V1/CONF\')")
        elif command[0] == 'exec':
            eng.eval(command[1:])
        elif command[0] == 'exit':
            # os.system(r'del -Force -Recurse .\PILIA\PROJECTS\tolosat_adcs_kalman\V1\CONF\slprj')
            exit()

if __name__ == "__main__":
    main()
