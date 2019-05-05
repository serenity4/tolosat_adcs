function confMTBcontroller = conf_MTBcontroller(I_sat,freq)

% conf_MTBcontroller - Configuration function of the proportional
% controller of the magnetorquers
% 
%   This function allows you to set the proportional gain of the MTB
%   controller, the reaction wheels' angular momentum of reference as well
%   as the cut-off angular frequency and the damping of the second order
%   filter of the commanded magnetic moment.
% 
%   Inputs:
%       - I_sat: inertia matrix of the satellite [kg*m^2]
%       - freq: working frequency of the satellite's embedded system [Hz]
% 
%   Outputs:
%       - confMTBcontroller: Matlab structure containing the proportional
%       gain of the MTB controller,the reaction wheels' angular momentum of
%       reference the discrete state-space system of the second order
%       filter present in this controller, and the inertia  matrix of the
%       satellite.

% Inertia matrix of the satellite [kg*m^2], entered as input of the present
% function
confMTBcontroller.I_sat = I_sat;

% Proportional gain of the MTB controller [-]
confMTBcontroller.km = 1/40;

% Reaction wheels' angular momentum of reference, in the satellite
% reference frame [kg*m^2/s]
confMTBcontroller.H_RWSref = [0; 0; 0];

% Cut-off angular frequency of the second order filter [rad/s]
omega = 0.1;

% Damping of the secnd order filter [-]
damp = 1;

% Sampling time of the MTB controller [s]
dt=1/freq;

% Matrices of the discrete state-space system of the second order filter
confMTBcontroller.A = dt*[0 1; -omega^2 -2*damp*omega]+eye(2);
confMTBcontroller.B = dt*[0; 1];
confMTBcontroller.C = [omega^2 0];
confMTBcontroller.D = 0;

end