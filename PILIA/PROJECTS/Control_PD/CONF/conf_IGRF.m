function confIGRF = conf_IGRF()

% cong_IGRF - Configuration function of the IGRF model block of the PILIA
% library
% 
%   This function loads the IGRF coefficients of the file igrfcoefs.mat and
%   makes them compatible with the IGRF block of the PILIA library. The
%   user is not advised to modify this function.
% 
%   Outputs:
%       - confIGRF: Matlab structure containing the coefficients of the
%       IGRF model in the correct format for the IGRF block of the library.

% Load the IGRF coefficients of the file igrfcoefs.mat and save them in the
% variable coefs
load igrfcoefs.mat

% Years in which the coefficients are provided
confIGRF.years=cell2mat({coefs.year});

%%%%%%%%%% Save the IGRF coefficients in the structure confIGRF %%%%%%%%%%%
confIGRF.coefs=zeros(195,length(confIGRF.years));

for i=1:length(confIGRF.years)-1
    confIGRF.coefs(:,i)= cell2mat({coefs(i).gh});
end

% The year 2020 has a smaller number of coefficients than the other years.
% The last column of confIGRF.coefs is completed by zeros (thanks to the
% inizialization of confIGRF.coefs)
confIGRF.coefs(1:length(coefs(end).gh),length(confIGRF.years))=...
    cell2mat({coefs(length(confIGRF.years)).gh});
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% For the year 2020, the coefficients are provided in the form of a slope
confIGRF.slope=cell2mat({coefs.slope});

end