function confConst= conf_Const()

% conf_Const - Configuration function of the main physical constants used
% in the PILIA library blocks.
% 
%   This function defines all the main physical constants used in the PILIA
%   libray blocks. It is advised against modifying this function.
% 
%   Outputs:
%       - confConst: Matlab structure containing all the main physical
%       constants used in the blocks of the PILIA library.

% Earth's mean radius [m]
confConst.EarthR=6371.2*1e3;

% Earth's equatorial radius [m]
confConst.EarthEquatorialR=6378*1e3;

% Earth's gravitational constant [m^3/s^2]
confConst.mu=398600e9;

% Duration of the sideral day [s]
confConst.SideralDay=86164.09;

% Duration of the solar day [s]
confConst.SolarDay=86400;

% Angular velocity of the Earth in the J2000 reference frame [rad/s]
confConst.OmegaEarth=[0;0; 2*pi/confConst.SideralDay];

% Astronomic Unit [m]
confConst.AstrUnit=1.495978707e11;

% Zonal term J2 of the gravitational potential of the Earth [-]
confConst.J2 = 1.0826*1e-3;

% Zonal term J3 of the gravitational potential of the Earth [-]
confConst.J3 = -2.5327*1e-6;

% Zonal term J4 of the gravitational potential of the Earth [-]
confConst.J4 = -1.6196*1e-6;

end

