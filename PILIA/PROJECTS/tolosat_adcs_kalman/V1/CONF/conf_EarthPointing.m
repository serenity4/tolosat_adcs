function confEarthPointing = conf_EarthPointing()

% conf_EarthPointing - Configuration function of the Earth pointing command
%
%   This function allows you to choose which direction, in the satellite
%   reference frame must be directed to the Earth center and which other
%   must be perpendicular to the orbit. The third axis completes the
%   Cartesian reference frame.
%
%   Outputs:
%       - confEarthPointing: Matlab structure containing the information
%       concerning your choice of the axis for this kind of pointing.

% Choose the vector of the satellite body frame which is towards the Earth
% (the equivalent of the z-axis of the MRF in the figure 20 of the User
% Manual). Please enter a unit vector.
AxisToEarth = [1; 0; 0];

% Choose the vector of the satellite body frame which is perpendicular to
% the orbit (the equivalent of the y-axis of the MRF in the figure 20 of
% the User Manual). Please enter a unit vector normal to the previous one.
AxisNormOrbit = [0; 1; 0];

% Do not modify hereafter.
if abs(AxisToEarth'*AxisNormOrbit) > 1e-12 || norm(AxisToEarth)==0 || norm(AxisNormOrbit)==0
    clear
    evalin('base','clear')
    errordlg(['The choice of the orientation of the satellite is not correct.',...
        ' The axis you chose might not be perpendicular (please, read the comments of the function',...
        ' conf_EarthPointing.m).'],...
        'Earth Pointing Command Error')
    error(['The choice of the orientation of the satellite is not correct.',...
        char(10), 'The axis you chose might not be perpendicular',char(10),'(please, read the comments of the function',...
        ' conf_EarthPointing.m).'])
else
    confEarthPointing.AxisToEarth = 1/norm(AxisToEarth)*AxisToEarth;
    confEarthPointing.AxisNormOrbit = 1/norm(AxisNormOrbit)*AxisNormOrbit;
    AxisToVel = cross_prod(confEarthPointing.AxisNormOrbit, confEarthPointing.AxisToEarth);
    confEarthPointing.M = [confEarthPointing.AxisToEarth AxisToVel confEarthPointing.AxisNormOrbit];

end

end
