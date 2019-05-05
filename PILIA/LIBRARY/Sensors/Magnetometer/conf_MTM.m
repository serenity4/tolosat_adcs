function confMTM = conf_MTM()

% conf_MTM - Configuration function ot the magnetometers
% 
%   This function allows you to set the parameters of the magnetometers,
%   like their working frequency, their position matrix, their scale factor
%   and misalignment matrix as well as their level of noise.
%
%   Outputs:
%       - confMTM: Matlab structure containing the value of the working
%       frequency of the magnetometers, their Position matrix, their scale
%       factor and misalignment matrix as well as their level of noise.

% Working frequency of the magnetometers [Hz]
confMTM.frequency = 4;

% Magnetometers Position Matrix in the satellite reference frame
confMTM.Mp=[1 0 0;
            0 1 0;
            0 0 1];
        
confMTM.invMp = inv(confMTM.Mp);

% Magnetometers Bias [T]
confMTM.Bias=5e-7*ones(3,1);

% Magnetometers white noise power [-]
confMTM.NoisePower = 1e-15;

% Misalignment angles [°] on the x, y and z-axis respectively
tx=0;
ty=0;
tz=2;

% Scale Factors and Misalignment matrix
confMTM.Msf = [             1     sin(tz*pi/180)         sin(ty*pi/180);
               sin(tz*pi/180)               0.95         sin(tx*pi/180);
               sin(ty*pi/180)     sin(tx*pi/180)                      1];

end