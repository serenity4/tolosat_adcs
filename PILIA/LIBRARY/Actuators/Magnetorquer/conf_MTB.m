function confMTB = conf_MTB()

% conf_MTB - Configuration function of the magnetorquers
% (MagneTorquers Bars)
% 
%   This function allows you to set the parameters of the magnetorquers.
%   You can define the position of the magnetorquers in the satellite
%   reference frame as well as the maximum magnetic moment acquired by
%   these actuators.
% 
%   Outputs:
%       - confMTB: Matlab structure containing the matrices which allow to
%       pass from the satellite frame to the MTB frame and vice versa, and
%       the maximum magnetic moment acquirable by the magnetorquers.


% Matrix to pass from the body frame to the MTB frame. The columns of this
% matrix are the unitary vectors defining the three axis of the
% magnetorquers in the satellite reference frame
confMTB.N_bf=[1 0 0;
              0 1 0;
              0 0 1];

% Matrix to pass from the MTB frame to the satellite frame
confMTB.N_MTB=confMTB.N_bf'/(confMTB.N_bf*confMTB.N_bf');

% Maximum magnetic moment acquirable [A*m^2]
confMTB.M_max=0.24;

end