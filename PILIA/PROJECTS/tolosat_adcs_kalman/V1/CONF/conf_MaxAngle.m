function max_angle = conf_MaxAngle()

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

max_angle.Obj = 50*pi/180; %output in radians
max_angle.ES = max_angle.Obj*0.9;
end
