function confStarTracker = conf_StarTracker()

% conf_StarTracker - Configuration function of the Star Tracker
% 
%   This function allows you to set the parameters of the Star Tracker. You
%   can define the working frequency of the Star Tracker, its initial
%   measurement, its bias, and its white noise.
% 
%   Outputs:
%       - confStarTracker: Matlab structure containing the working
%       frequency of the Star Tracker, the initial measurement of the
%       satellite's orientation, the value and the direction of the bias of
%       this sensor as well as its white the noise power.

% Working frequency of the Star Trackers [Hz]
confStarTracker.frequency = 4;

% Star Tracker bias [°]
confStarTracker.Bias = 2;

% Direction of the Star Tracker Bias in the satellite reference frame
dir = [1;1;1];
confStarTracker.direction=dir/norm(dir);

% White noise power of the Star Tracker [-]
confStarTracker.NoisePower = 1e-6;

% Initial measurement of the satellite's attitude provided by the Star
% Tracker
confStarTracker.InitQsat = [0; 1; 0; 0];

end