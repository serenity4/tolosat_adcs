function confRWS = conf_RWS()

% conf_RWS - Configuration function of the Reaction Wheels
% 
%   This function allows you to configure the Reaction Wheels. You can
%   define the position of the wheels in the satellite reference frame, the
%   wheels' momentum of inertia, their initial angular velocity, their
%   saturation torque and velocity and their level of noise.
%   
%   Outputs:
%       - confRWS: Matlab structure containing the parameters of the the
%       Reaction Wheels (their position in the satellite frame, their
%       saturation and noise levels and their initial condition)

% N_RWS is the matrix to pass from the Reaction Wheels reference frame to
% the satellite body frame. The columns of this matrix are the unitary
% vectors defining the directions of the rotation axis of each wheel in the
% satellite body frame.
% This is a 3x4 matrix, if your satellite has only three Reaction Wheels,
% the last column of this matrix must be the null vector. Please, do not
% change the dimensions of this matrix.
% confRWS.N_RWS=sqrt(3)/3*[1 -1 -1  1;
%                          1  1 -1 -1;
%                          1  1  1  1];
confRWS.N_RWS=[1 0 0 0;
               0 1 0 0;
               0 0 1 0];

% Matrix to pass from the satellite body frame to the Reaction Wheels
% reference framee 
confRWS.N_bf=confRWS.N_RWS'/(confRWS.N_RWS*confRWS.N_RWS');

% Momentum of inertia of the single wheel around its rotation axis [kg*m^2]
confRWS.I_RWS=5e-6;

% Maximum torque applicable to the single wheel [N*m]
confRWS.Tmax=6e-4;

% Maximum angular velocity of the single wheel [rad/s]
confRWS.OmegaMax=3200*pi/30;

% IntitOmegaRWS defines the initial angular velocity [rad/s] of each
% Reaction Wheel. This is a 4x1 vector whose components define the initial
% angular velocity of each of the four Reaction Wheels. If your satellite
% has only three Reactions wheels, the last component of this vector will
% not be taken into account. Please, do not change the dimensions of this
% vector.
confRWS.IntitOmegaRWS=[0; 0; 0; 0];

% White noise power of the Reaction Wheels [-]
confRWS.NoisePower=1e-14;

end