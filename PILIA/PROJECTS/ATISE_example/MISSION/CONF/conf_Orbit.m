function confOrbit = conf_Orbit(mu, EarthR, mass)

% conf_Orbit - Configuration function of the orbit blocks of the PILIA
% library
% 
%   This function allows you to define the fixed time step of your
%   simulator and to set the satellite's orbit.
% 
%   Inputs:
%       - mu: Earth gravitational constant [m^3/s^2]
%       - EarthR: mean Earth Radius [m]
%       - mass: satellite's mass [kg]
% 
%   Outputs:
%       - confOrbit: Matlab structure containing the data of the
%       satellite's mass and orbit, and the value of the time step of the
%       simulator. These data will be used in the library blocks Orbit.slx
%       and KepOrbit.slx. The time step will be setted in the Solver
%       options of your SImulink Model.
% 
%       PROCEDURE
%       In your simulink model, press:
%       Simulation > Model Configuration Parameters > Solver options:
%       Type: Fixed-step > Fixed-step size (fundamental sample time) >
%       Enter ConfParam.confOrbit.dt

% Mass of the satellite
confOrbit.mass = mass; %[kg]

% Simulator time step [s]
confOrbit.dt = 1/8;

% INITIALIZATION METHOD
% 1 : keplerian parameters
% 2 : Cartesian parameters (position, velocity)
confOrbit.InitMethod = 1;

%%%%%%%%%%%%%%%%%%%%%%%%%
%  EXAMPLE OF AN ORBIT  %
%%%%%%%%%%%%%%%%%%%%%%%%%

% Orbit perigee radius [m], pr
pr=EarthR+500000;
% pr=EarthR+400000;
    
% Orbit apogee radius [m], ar
% ar=EarthR+4000000;
% ar=EarthR+2000000;
ar=EarthR+2500000;
% ar=EarthR+400000;

% Orbit eccentricity, e
e=(ar-pr)/(pr+ar);

% Orbit semi-major axis, a
a=(ar+pr)/2;

% Orbit inclination [rad], i
i=pi/3;
% i=pi/2;

% Right Ascension of the Ascending Node [rad], W
W=0;
% W=pi;

% Argument of perigee [rad], w
w=0;

% Initial condition on the true anomaly [rad], v
v=0;

if confOrbit.InitMethod == 1

    % Here the code calculates the vector radius and the velocity of the
    % satellite for the corresponding orbital parameters.

    C=sqrt(mu*a*(1-e^2));
    ci=cos(i);si=sin(i);
    cW=cos(W);sW=sin(W);
    cwpv=cos(w+v);swpv=sin(w+v);
    er=[cW*cwpv-ci*sW*swpv ; sW*cwpv+ci*cW*swpv ; si*swpv];
    eteta=[-cW*swpv-ci*sW*cwpv ; -sW*swpv+ci*cW*cwpv ; si*cwpv];

    % Satellite's initial position [m] in the J2000 reference frame
    SatPos_0=a*(1-e^2)/(1+e*cos(v))*er;

    % Satellite's initial velocity [m/s] in the J2000 reference frame
    SatVel_0=e*mu/C*sin(v)*er+C/norm(SatPos_0)*eteta;

    confOrbit.InitOrbit = [SatPos_0; SatVel_0];

elseif confOrbit.InitMethod == 2
        
    % Satellite's initial position [m] in the J2000 reference frame
    SatPos_0 = [6778000; 0; 0];

    % Satellite's initial velocity [m/s] in the J2000 reference frame
    SatVel_0 = [0; 4031.63072970000; 6982.98926135000];
        
    confOrbit.InitOrbit = [SatPos_0; SatVel_0];

end
    
end