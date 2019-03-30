import numpy as np
import matlab.engine

# ref = matlab.engine.find_matlab()
# print("Session ID found: {}".format(ref[0]))
# eng = matlab.engine.start_matlab(ref[0])

model_path = 'PILIA/PROJECTS/tolosat_adcs_kalman/V1/V1.slx'
end = 5000

eng = matlab.engine.start_matlab("-desktop")
### starts the engine and opens it
eng.eval('addpath(genpath("PILIA"))')
### add PILIA to path as it tends to slip away from MATLAB's path
ConfParam = eng.eval('Main_ConfLaunch()')
eng.workspace['ConfParam'] = ConfParam
### builds configuration parameters
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

while 1:
    pass
