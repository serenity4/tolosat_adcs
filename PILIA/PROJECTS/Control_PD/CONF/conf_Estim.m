function confEstim = conf_Estim(freq)

% conf_Estim - Configuration function of the estimator of the satellite's
% ADCS
% 
%   This function allows you to set the parameters of the estimator, like
%   the initial estimated attitude and angular velocity of the satellite as
%   well as the cut-off angular frequency and the damping of the second
%   order filter of the estimator.
% 
%   Inputs:
%       - freq: working frequency of the satellite's embedded system [Hz]
% 
%   Outputs:
%       - confEstim: Matlab structure containing the initial estimated
%       angular velocity of the satellite, the cut-off angular frequency
%       and the damping of the second order filter as well as the matrices
%       of the discrete state-space system of this filter.

% Initial estimated attitude of the satellite, in the form of a quaternion
confEstim.InitQsat=[0; 1; 0; 0];

% Initial estimated angular velocity of the satellite [rad/s], in the
% satellite reference frame
confEstim.InitOmegaSat = [0; 0.03*pi/180; 0];

% Cut-off angular frequency [rad/s] of the second order filter of the
% estimator
confEstim.V_OmegaN = 0.2;

% Damping of the second order filter of the estimator [-]
confEstim.V_Damp = 0.8;

% Sampling time of the estimator [s]
dt=1/freq;

% Matrices of the discrete state-space system of the second order filter
confEstim.V_A = dt*[0  1; -confEstim.V_OmegaN^2  -2*confEstim.V_Damp*confEstim.V_OmegaN]+eye(2);
confEstim.V_B = dt*[0; 1];
confEstim.V_C = [confEstim.V_OmegaN^2 0];
confEstim.V_D = 0;

end