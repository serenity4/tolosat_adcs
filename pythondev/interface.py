import numpy as np
import matlab.engine
import os

# ref = matlab.engine.find_matlab()
# print("Session ID found: {}".format(ref[0]))
# eng = matlab.engine.start_matlab(ref[0])

def main():

    model = 'Detumbling.slx'
    model_path = 'PILIA/PROJECTS/tolosat_adcs_kalman/V1/' + model
    end = 5000

    eng = matlab.engine.start_matlab("-desktop")
    ### starts the engine and opens it
    eng.eval('addpath(genpath("PILIA"))')
    ### add PILIA to path as it tends to slip away from MATLAB's path
    eng.eval('cd PILIA/PROJECTS/tolosat_adcs_kalman/V1/CONF', nargout=0)
    ConfParam = eng.eval('Main_ConfLaunch()')
    eng.workspace['ConfParam'] = ConfParam
    ## builds configuration parameters
    eng.open_system(model_path, 'window', nargout=0)
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
    print("Welcome to the PILIA python interfacer! Available commands are:")
    print("{:<7} - displays help\n{:<7} - update workspace with new configuration variables\n{:<7} - exits the prompt".format("help", "update", "exit"))

    while 1:
        command = input().split(sep=" ")
        if command[0] == 'help':
            print("not implemented yet")
        elif command[0] == 'update':
            eng.eval('clear', nargout=0)
            ConfParam = eng.eval('Main_ConfLaunch()')
            eng.workspace['ConfParam'] = ConfParam
        elif command[0] == 'exec':
            eng.eval(command[1:])
        elif command[0] == 'exit':
            # os.system(r'del -Force -Recurse .\PILIA\PROJECTS\tolosat_adcs_kalman\V1\CONF\slprj')
            exit()

if __name__ == "__main__":
    main()
