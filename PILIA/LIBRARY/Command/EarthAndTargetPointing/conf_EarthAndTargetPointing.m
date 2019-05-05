function confEarthAndTargetPointing = conf_EarthAndTargetPointing(StaPosECEF)

% conf_EarthAndTargetPointing - Configuration function of the Earth and
% target pointing command
% 
%   This function allows you to define the minimal vision angle of the
%   ground station (see the user manual for more information)
% 
%   Inputs:
%       - StaPosECEF: ECEF coordinates [m] of the ground station.
% 
%   Outputs:
%       - confEarthAndTargetPointing: Matlab structure containing the
%       distance between the Earth centre and the ground station and the
%       value of the minimal vision angle [°] of the station.

% Calculation of the distance [m] between the Earth centre and the ground
% station
confEarthAndTargetPointing.d = sqrt(StaPosECEF(1)^2+StaPosECEF(2)^2+StaPosECEF(3)^2);

% Minimal vision angle of the ground station [°]
confEarthAndTargetPointing.VisionAngle = 10;

end