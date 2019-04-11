function confInertialAndTargetPointing = conf_InertialAndTargetPointing(StaPosECEF)

% conf_InertialAndTargetPointing - Configuration function of the inertial
% and target pointing command
% 
%   This function allows you to define the minimal vision angle of the
%   ground station (see the user manual for more information)
% 
%   Inputs:
%       - StaPosECEF: ECEF coordinates [m] of the ground station.
% 
%   Outputs:
%       - confInertialAndTargetPointing: Matlab structure containing the
%       distance between the Earth centre and the ground station and the
%       value of the minimal vision angle [°] of the station.

% Calculation of the distance [m] between the Earth centre and the ground
% station
confInertialAndTargetPointing.d = sqrt(StaPosECEF(1)^2+StaPosECEF(2)^2+StaPosECEF(3)^2);

% Minimal vision angle of the ground station [°]
confInertialAndTargetPointing.VisionAngle = 10;

end