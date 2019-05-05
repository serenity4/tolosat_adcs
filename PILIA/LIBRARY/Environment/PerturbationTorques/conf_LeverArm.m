function confLeverArm = conf_LeverArm()

% conf_LeverArm - Configuration function of the lever arm of the surface
% forces acting on the satellite
% 
%   This function allows you to define the vectors GO and OA (see below or
%   the user manual for more information) which will be used for the
%   calculation of the lever arm of the surface forces (the Sun force and
%   the aerodynamic force) acting on the satellite.
% 
%   Outputs:
%       - confLeverArm: Matlab structure containing the vectors GO and OA.

% vector (expressed in the satellite frame) going from the centre of
% gravity (G) of the satellite to its geometric centre (O) [m]
confLeverArm.GO=[-0.03; -0.03; -0.03];

% vector (expressed in the satellite frame) going from the satellite's
% geometric centre (O) to the edge (A) with all positive coordinates in the
% satellite reference frame [m]
confLeverArm.OA=[0.15; 0.05; 0.05];

end