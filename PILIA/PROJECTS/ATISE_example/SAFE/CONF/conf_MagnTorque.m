function confMagnTorque = conf_MagnTorque()

% conf_MagnTorque - Configuration function of the magnetic torque
% perturbation
% 
%   This function allows you to enter the residual magnetic moment of the
%   satellite.
% 
%   Outputs:
%   - confMagnTorque: Matlab structure containing the vector defining the
%   residual magnetic moment of the satellite.

% Residual magnetic moment of the satellite [A*m^2]
confMagnTorque.MagnDipole=[0.01; 0.02; 0.03];
% confMagnTorque.MagnDipole=[0.01; 0.02; 0.1];

end