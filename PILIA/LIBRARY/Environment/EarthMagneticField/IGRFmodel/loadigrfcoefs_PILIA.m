function gh = loadigrfcoefs_PILIA(time, years, coefs, slope)

% LOADIGRFCOEFS Load coefficients used in IGRF model.
% 
% Usage: GH = LOADIGRFCOEFS(TIME)
% 
% Loads the coefficients used in the IGRF model at time TIME in MATLAB
% serial date number format and performs the necessary interpolation.
% The proper coefficient vector GH from igrfcoefs.mat is returned.
% 
% Inputs:
%   -TIME: Time to load coefficients in datenum convention.
% 
% Outputs:
%   -GH: g and h coefficient vector formatted as:
%   [g(n=1,m=0) g(n=1,m=1) h(n=1,m=1) g(n=2,m=0) g(n=2,m=1) h(n=2,m=1) ...]
% 
% See also: IGRF.

% Make sure time has only one element.
if numel(time) > 1
    error('loadigrfcoefs:timeInputInvalid', ['The input TIME can only ' ...
        'have one element']);
end

coder.extrinsic('datevec');

% Convert time to fractional years.
timevec = datevec(time);
time = timevec(1) + (time - datenum([timevec(1) 1 1]))./(365 + double(...
    (~mod(timevec(1),4) & mod(timevec(1),100)) | (~mod(timevec(1),400))));

% Check validity on time.
if time < years(1) || time > years(end)
    error('igrf:timeOutOfRange', ['This IGRF is only valid between ' ...
        num2str(years(1)) ' and ' num2str(years(end))]);
end

% Get the nearest epoch that the current time is between.
lastepoch = find(time - mod(time, 5) == years);
if lastepoch == length(years)
    lastepoch = lastepoch - 1;
end
nextepoch = lastepoch + 1;
 
% Get the coefficients based on the epoch.
lastgh = coefs(:,lastepoch);
nextgh = coefs(:,nextepoch);

% Calculate gh using a linear interpolation between the last and next
% epoch.
if slope(nextepoch)
    ghslope = nextgh;
else
    ghslope = (nextgh - lastgh)/5;
end

gh = lastgh + ghslope*(time - years(lastepoch));

end