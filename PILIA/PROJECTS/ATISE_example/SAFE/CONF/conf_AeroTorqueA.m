function confAeroTorqueA = conf_AeroTorqueA()

% conf_AeroTorqueA - Configuration function of the AeroTorqueA block of the
% PILIA library
% 
%   This function allows you to enter a mean value of the drag coefficient
%   of the satellite.
% 
%   Outputs:
%       - confAeroTorqueA: Matlab structure containing the mean drag
%       coefficient of the satellite as well as data necessary for the
%       calculation of the atmospheric density.

% Mean value of the drag coefficient of the satellite [-]
confAeroTorqueA.Cd=2.3;
% confAeroTorque.Cd=0;

% Atmospheric density [kg/m^3] at an altitude equal to h0
confAeroTorqueA.rho0=1e-10;

% Altitude [m] at which tou evaluate rho0
confAeroTorqueA.h0=200e3;

% Multiplication factor [1/m] of the exponential model of the atmospheric
% density
confAeroTorqueA.alpha=0.016e-3;
end