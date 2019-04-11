function confDate = conf_Date()

% conf_Date - Configuration function of the Date block of the PILIA library
% 
%   This function allows you to define the initial date and time of your
%   simulation.
% 
%       Outputs:
%           - confDate: Matlab structure containing the number of days, in
%           the decimal format, passed since 1/1/2000 at 00:00

% Initial date of the simulation. The input format for the
% confDate.InitialDate is [YYYY, MM, DD]
InitialDate=[2019, 01, 01];

% Initial time of the simulation. The input format for the
% confDate.InitialDate is [hour (24h-format), min, seconds]
InitialTime=[00, 00, 00];

% CSUT Julian Day of reference
ReferenceDate=[2000, 1, 1, 0, 0, 0];

% Calculating the initial CSUT Julian Date from the input
confDate.InitialJD=juliandate(datetime([InitialDate, InitialTime]))...
    -juliandate(datetime(ReferenceDate));

end