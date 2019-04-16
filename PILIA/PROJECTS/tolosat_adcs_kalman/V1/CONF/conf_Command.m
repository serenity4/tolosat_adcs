function confCommand = conf_Command()

% confCommand - Configuration function of the command to apply to the
% satellite
%
%   This function allows you to choose the command profile, as a function
%   of time, to apply to your satellite. To do that, you have to create a
%   matrix and save it in the variable confCommand.CommandProfile. This
%   matrix is Nx2, where N is the number of sample times in which the
%   Command block of the library evaluates your profile. Therefore, each
%   row of the matrix mentioned above has a time stamp in the first column
%   and, in the second column, it has an integer number corresponding to
%   the numeric value of your command choice (see below).
%   Between two consequent sample times entered in this matrix, the integer
%   number corresponding to your command choice is maintained constant
%   (step profile).
%
%   If the last sample time in the Nx2 matrix is lower than the duration of
%   the simulation, the last numeric value of the command choice is kept
%   until the end of the simulation. On the other hand, if it is higher,
%   all sample times exceeding the duration of the simulation will not be
%   taken into account.
%
%   NOTE:
%   The first sample time in the second column of the matrix must be zero,
%   otherwise Simulink gives an error message.
%
%   Please note that the target pointing is appliable only if the satellite
%   is in sight of the ground station. For this reason, the Target Pointing
%   command is always tied to another kind of pointing, which is applied
%   when the satellite is out of the sight of the station.
%
%   Outputs:
%       - confCommand: Matlab structure containing a matrix corresponding
%       to your command profile.
%
% Correspondence Number - Type of command
%   1.      Inertial Pointing
%   2.      Earth Pointing
%   3.      Inertial and Target Pointing
%   4.      Earth and Target Pointing
%   else.   Simulink Error

confCommand.CommandProfile = [0 2];

end
