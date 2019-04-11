function confRWS_PDcontroller = conf_RWS_PDcontroller (I_sat)
    
% conf_RWS_PDcontroller - Configuration function of the PD controller of
% the reaction wheels
% 
%   This function allows you to define the proportional and the derivative
%   gains of the PD controller of the reaction wheels.
% 
%   Inputs:
%       - I_sat: inertia matrix of the satellite [kg*m^2]
% 
%   Outputs:
%       - confRWS_PDcontroller: Matlab structure containing the
%       proportional and derivative matrices of the PD controller of the
%       reaction wheels and the satellite's inertia matrix.

% Inertia matrix of the satellite [kg*m^2], entered as input of the present
% function
confRWS_PDcontroller.I_sat = I_sat;

% Proportional gain of the controller [1/s^2]
kpCoeff = 8*1e-4;

% Derivative gain of the controller [1/s]
kdCoeff = 0.05;

% Gain matrices of the PD controller
confRWS_PDcontroller.kp = kpCoeff*confRWS_PDcontroller.I_sat;
confRWS_PDcontroller.kd = kdCoeff*confRWS_PDcontroller.I_sat;

end