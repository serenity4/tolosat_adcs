function confSatDyn = conf_SatDyn(Isat)

% conf_SatDyn - Configuration function of the dynamics of the satellite
%
%   This function allows you to define the initial attitude of the
%   satellite and its initial angular velocity. Furthermore, this function
%   computes the inverse of the inertia matrix of the satellite
% 
%   Inputs:
%       - Isat: inertia matrix of the satellite [kg*m^2]
% 
%   Outputs:
%       - confSatDyn: Matlab structure containing the initial orientation
%       and angular velocity of the satellite as well as the inverse of its
%       inertia matrix.

% Initial angular velocity of the satellite [rad/s], in the satellite
% reference frame
confSatDyn.InitOmega_sat = [0; 0.03*pi/180; 0];
% confSatDyn.InitOmega_sat = [15*pi/180; 15*pi/180; 15*pi/180];

% Initial attitude of the satellite, in the form of a quaternion of
% rotation
confSatDyn.InitQsat = [0; 1; 0; 0];

% Inverse of the inertia matrix of the satellite
confSatDyn.invI_sat=inv(Isat);

end