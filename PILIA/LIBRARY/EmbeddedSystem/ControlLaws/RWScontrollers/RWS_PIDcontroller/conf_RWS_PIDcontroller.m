function confRWS_PIDcontroller = conf_RWS_PIDcontroller (I_sat)

% conf_RWS_PIDcontroller - Configuration function of the PID controller of
% the Reaction Wheels
% 
%   This function allows you to define the proportional, derivative and
%   integral gains of the PID controller of the reaction wheels.
% 
%   Inputs:
%       - I_sat: inertia matrix of the satellite [kg*m^2]
% 
%   Outputs:
%       - confRWS_PDcontroller: Matlab structure containing the
%       proportional, derivative and integral matrices of the PD controller
%       of the reaction wheels and the satellite's inertia matrix.

% Inertia matrix of the satellite [kg*m^2], entered as input of the present
% function
confRWS_PIDcontroller.I_sat = I_sat;

% Proportional gain of the controller [1/s^2]
kpCoeff = 9*1e-4;

% Derivative gain of the controller [1/s]
kdCoeff = 0.0424264;

% Integral gain of the controller [1/s^3]
% kiCoeff = 8e-6*kpCoeff;
kiCoeff = 1e-4*kpCoeff;

% Gain matrices of the PID controller
confRWS_PIDcontroller.kp = kpCoeff*confRWS_PIDcontroller.I_sat;
confRWS_PIDcontroller.kd = kdCoeff*confRWS_PIDcontroller.I_sat;
confRWS_PIDcontroller.ki = kiCoeff*confRWS_PIDcontroller.I_sat;

% Saturation of the integrated error [rad]
% confRWS_PIDcontroller.ErrorSaturation = realmax; % No Error saturation
confRWS_PIDcontroller.ErrorSaturation = 0.2;

end