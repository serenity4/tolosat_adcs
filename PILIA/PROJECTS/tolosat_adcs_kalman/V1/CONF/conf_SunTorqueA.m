function confSunTorqueA = conf_SunTorqueA()

% conf_SunTorqueA - Configuration file of the SunTorqueA block of the PILIA
% library
% 
%   This function allows you to set the coefficient of reflectivity of the
%   external surface of the satellite and the mean value of the solar
%   pressure acting on it.
% 
%   Outputs:
%       - confSunTorqueC: Matlab structure containing the value of the
%       coefficient of reflectivity of the satellite and the mean value of
%       the solar pressure acting on it.

% Reflectivity coefficient of the external surface of the satellite [-]
% (0 <= k <= 1)
confSunTorqueA.k=0.5;

% Mean value of the solar pressure acting on the satellite [N/m^2]
confSunTorqueA.Ps=4.63e-6;
end