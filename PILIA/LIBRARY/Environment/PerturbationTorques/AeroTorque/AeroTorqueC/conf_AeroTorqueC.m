function confAeroTorqueC = conf_AeroTorqueC()

% conf_AeroTorqueC - Configuration function of the AeroTorqueC block of the
% PILIA library
% 
%   This function allows you to enter a mean value of the drag coefficient
%   of the satellite and the lever arm from the satellite's geometric
%   center to its center of gravity.
% 
%   Outputs:
%       - confAeroTorqueC: Matlab structure containing the mean drag
%       coefficient of the satellite, the data necessary for the
%       calculation of the atmospheric density and the lever arm from the
%       satellite's geometric center to its center of gravity.

% Mean value of the drag coefficient of the satellite [-]
confAeroTorqueC.Cd=2.3;
% confAeroTorque.Cd=0;

% Atmospheric density [kg/m^3] at an altitude equal to h0
confAeroTorqueC.rho0=1e-10;

% Altitude [m] at which tou evaluate rho0
confAeroTorqueC.h0=200e3;

% Multiplication factor [1/m] of the exponential model of the atmospheric
% density
confAeroTorqueC.alpha=0.016e-3;

% Coordinates of the geometric center of the satellite, in the satellite
% body frame translated to its gravity center [m]
geomCenter=[-0.03; -0.03; -0.03];

% Coordinates of the satellite's center of gravity, in the satellite body
% frame translated to its gravity center [m]
gravCenter=[0; 0; 0];

% Lever arm from the satellite's geometric center to its center of gravity
confAeroTorqueC.LeverArm=geomCenter-gravCenter;
end