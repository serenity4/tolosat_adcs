function confBdotController = conf_BdotController(I_sat)

% conf_BdotController - Configuration function of the B-dot controller
% 
%   This function allows you to set the parameters of the B-dot controller
%   of the magnetorquers.
% 
%   Inputs:
%       - I_sat: inertia matrix of the satellite [kg*m^2]
% 
%   Outputs:
%       - confBdotController: Matlab structure containing the value of the
%       gain of the B-dot controller.

% Time constant [s]
thau=1000;

% Calculation of the gain of the B-dot controller [kg*m^2*rad/s/T]
confBdotController.k = max([I_sat(1,1),I_sat(2,2),I_sat(3,3)])/thau;

end