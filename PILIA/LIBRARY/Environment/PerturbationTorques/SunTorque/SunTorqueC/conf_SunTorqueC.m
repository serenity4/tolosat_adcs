function confSunTorqueC = conf_SunTorqueC()

% conf_SunTorqueC - Configuration file of the SunTorqueC block of the PILIA
% library
% 
%   This function allows you to set the coefficient of reflectivity of the
%   external surface of the satellite, the mean value of the solar pressure
%   acting on it, and the lever arm from the satellite's geometric center
%   to its center of gravity.
% 
%   Outputs:
%       - confSunTorqueC: Matlab structure containing the value of the
%       coefficient of reflectivity of the satellite, the mean value of the
%       solar pressure acting on it and the lever arm vector from the
%       satellite's geometric center to its center of gravity.

% Reflectivity coefficient of the external surface of the satellite [-]
% (0 <= k <= 1)
confSunTorqueC.k=0.5;

% Mean value of the solar pressure acting on the satellite [N/m^2]
confSunTorqueC.Ps=4.63e-6;

% Coordinates of the geometric center of the satellite, in the satellite
% body frame translated to its gravity center [m]
geomCenter=[0.02; 0.02; 0.1];

% Coordinates of the satellite's center of gravity, in the satellite body
% frame translated to its gravity center [m]
gravCenter=[0; 0; 0];

% Lever arm from the satellite's geometric center to its center of gravity
confSunTorqueC.LeverArm=geomCenter-gravCenter;
end