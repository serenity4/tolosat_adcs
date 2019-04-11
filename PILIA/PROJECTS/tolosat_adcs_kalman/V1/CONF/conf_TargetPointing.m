function confTargetPointing = conf_TargetPointing()

% conf_TargetPointing - Configuration function of the target pointing
% command
% 
%   This function allows you to set the position (in the form latitude,
%   longitude, altitude) of the ground station that the satellite must
%   point. You can then impose which axis of the satellite body frame must
%   point the station and which other must be normal the satellite's
%   velocity.
% 
%   Outputs:
%       confTargetPointing: Matlab structure containing the position of the
%       ground station in the ECEF (Earth Centered Earth Fixed) frame and
%       your choice of the axis for this kind of pointing.

% Geodetic latitude of the ground station [°]
TargetLatitude = 43.6;

% Geodetic longitude of the ground station [°]
TargetLongitude = 1.4333;

% Ground station's geodetic altitude [m]
TargetAltitude = 142;

% Calculation of the position of the ground station in the ECEF frame
[TargetX_ECEF, TargetY_ECEF, TargetZ_ECEF]...
    = geod2ecef(TargetLatitude, TargetLongitude, TargetAltitude);
confTargetPointing.StaPosECEF = [TargetX_ECEF; TargetY_ECEF; TargetZ_ECEF];

% Choose the axis of the satellite body frame which is towards the ground
% station. Please enter a unit vector.
AxisToStation = [1; 0; 0];

% Choose the axis of the satellite body frame which is normal to the
% satellite's velocity. Please enter a unit vector perpendicular to the
% previous one.
AxisNormVelocity = [0; 0; -1];
    
% Do not modify hereafter
if abs(AxisToStation'*AxisNormVelocity) > 1e-12 || norm(AxisToStation)==0 || norm(AxisNormVelocity)==0
    clear
    evalin('base','clear')
    errordlg(['The choice of the orientation of the satellite is not correct.',...
        ' The axis you chose might not be perpendicular (please, read the comments of the function',...
        ' conf_TargetPointing.m).'],...
        'Target Pointing Command Error')
    error(['The choice of the orientation of the satellite is not correct.',...
        char(10), 'The axis you chose might not be perpendicular',char(10),'(please, read the comments of the function',...
        ' conf_TargetPointing.m).'])
else
    confTargetPointing.AxisToStation = 1/norm(AxisToStation)*AxisToStation;
    confTargetPointing.AxisNormVelocity = 1/norm(AxisNormVelocity)*AxisNormVelocity;
    AxisToVel = cross_prod(confTargetPointing.AxisNormVelocity, confTargetPointing.AxisToStation);
    confTargetPointing.M = [confTargetPointing.AxisToStation AxisToVel confTargetPointing.AxisNormVelocity];
    
end

end