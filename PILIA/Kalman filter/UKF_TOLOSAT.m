% Example TOLOSAT:
% {
clc;clear; close all
g=9.81;
bx = 0.4;
by = 0.4;
bz = 0.4;
dt = 1;
n=10;      %number of state
m = 9;     %number of measurements
q=0.1;    %std of process 
Q=q^2*eye(n); % covariance of process

R_g=[1e-6, 0, 0;
    0, 1e-6, 0;
    0, 0, 1e-6];        % covariance of the gyro measurement
R_ac=[8.1e-3, 0, 0;
    0, 1.296e-3, 0;
    0, 0, 8.1e-3];      % covariance of the accelerometer measurement

R_mg=[0.0484, 0, 0;
    0, 1.2321, 0;
    0, 0, 0.0784];      % covariance of the magnetometer measurement
R=[R_g, zeros(3,6);
    zeros(3),R_ac,zeros(3);
    zeros(3,6),R_mg];   % Covariance of the measurements

w=@(x)sqrt(x(5)^2+x(6)^2+x(7)^2);
cos=@(x)cos(abs(w(x))*dt/2)/abs(w(x));
sin=@(x)sin(abs(w(x))*dt/2)/abs(w(x));
f=@(x)[x(1)*abs(w(x))*cos(x)-x(2)*x(5)*sin(x)-x(3)*x(6)*sin(x)-x(4)*x(7)*sin(x);
    x(1)*x(5)*sin(x)+x(2)*abs(w(x))*cos(x)+x(3)*x(7)*sin(x)-x(4)*x(6)*sin(x);
    x(1)*x(6)*sin(x)-x(2)*x(7)*sin(x)+x(3)*abs(w(x))*cos(x)+x(4)*x(5)*sin(x);
    x(1)*x(7)*sin(x)+x(2)*x(6)*sin(x)-x(3)*x(5)*sin(x)+x(4)*abs(w(x))*cos(x);
    x(5); x(6);x(7);
    x(8);x(9);x(10)];  % nonlinear state equations

h=@(x)[x(5)+x(8); x(6)+x(9); x(7)+x(10);
    -2*g*(x(1)*x(3)+x(2)*x(4)); -2*g*(x(1)*x(2)+x(3)*x(4)); -g*(-1+2*x(1)^2+2*x(4)^2);
    bx*(-1+2*x(1)^2+2*x(2)^2)+2*by*(x(2)*x(3)+x(1)*x(4))+2*bz*(-x(1)*x(3)+x(2)*x(4));
    by*(-1+2*x(1)^2+2*x(3)^2)+2*bx*(x(2)*x(3)-x(1)*x(4))+2*bz*(x(1)*x(2)+x(3)*x(4));
    bz*(-1+2*x(1)^2+2*x(4)^4)+2*bx*(x(1)*x(3)+x(2)*x(4))+2*by*(-x(1)*x(2)+x(3)*x(4))];
                              % measurement equation
s=[sqrt(2)/2;sqrt(2)/2;0;0;1;1;1;-5e-3;-5e-3;5e-3];                                % initial state
x=s+q*randn(n,1); %initial state          % initial state with noise
P = eye(n);                               % initial state covraiance
N=20;                                     % total dynamic steps
xV = zeros(n,N);          %estmate        % allocate memory
sV = zeros(n,N);          %actual
zV = zeros(m,N);
for k=1:N
  z = h(s) + diag(R*randn);                     % measurments
  sV(:,k)= s;                             % save actual state
  zV(:,k)  = z;                             % save measurment
  [x, P] = ukf(f,x,P,h,z,Q,R);            % ekf 
  xV(:,k) = x;                            % save estimate
  s = f(s) + q*randn(n,1);                % update process 
end
figure()
for k=1:4                                 % plot results
  subplot(4,1,k)
  plot(1:N, sV(k,:), '-', 1:N, xV(k,:), '--')
end
figure()
for k=1:3                                 % plot results
  subplot(3,1,k)
  plot(1:N, sV(4+k,:), '-', 1:N, xV(4+k,:), '--')
end
figure()
for k=1:3                                 % plot results
  subplot(3,1,k)
  plot(1:N, sV(7+k,:), '-', 1:N, xV(7+k,:), '--')
end

for u=1:N
% roll (x-axis rotation)
	sinr_cosp = 2.0 * (sV(1,u) *sV(2,u) + sV(3,u) * sV(4,u));
	cosr_cosp = 1.0 - 2.0 * (sV(1,u) * sV(1,u) + sV(2,u) * sV(2,u));
	roll(u) = atan2(sinr_cosp, cosr_cosp);
    
    sinr_cosp = 2.0 * (xV(1,u) *xV(2,u) + xV(3,u) * xV(4,u));
	cosr_cosp = 1.0 - 2.0 * (xV(1,u) * xV(1,u) + xV(2,u) * xV(2,u));
	roll2(u) = atan2(sinr_cosp, cosr_cosp);
    
% pitch (y-axis rotation)
	sinp = 2.0 * (sV(1,u) * sV(3,u) - sV(4,u) * sV(2,u));
	if (abs(sinp) >= 1)
		pitch(u) = pi/2; % use 90 degrees if out of range
	else
		pitch(u) = asin(sinp);
    end
    sinp = 2.0 * (xV(1,u) * xV(3,u) - xV(4,u) * xV(2,u));
	if (abs(sinp) >= 1)
		pitch2(u) = pi/2; % use 90 degrees if out of range
	else
		pitch2(u) = asin(sinp);
    end
% yaw (z-axis rotation)
	siny_cosp = 2.0 * (sV(1,u) * sV(4,u) + sV(2,u) * sV(3,u));
	cosy_cosp = 1.0 - 2.0 * (sV(3,u) * sV(3,u) + sV(4,u) * sV(4,u));  
	yaw(u) = atan2(siny_cosp, cosy_cosp);
    
    siny_cosp = 2.0 * (xV(1,u) * xV(4,u) + xV(2,u) * xV(3,u));
	cosy_cosp = 1.0 - 2.0 * (xV(3,u) * xV(3,u) + xV(4,u) * xV(4,u));  
	yaw2(u) = atan2(siny_cosp, cosy_cosp);
end

ang = [roll; pitch; yaw];
ang2 = [roll2; pitch2; yaw2];
figure()
for k=1:3                                 % plot results
  subplot(3,1,k)
  plot(1:N, ang(k,:), '-', 1:N, ang2(k,:), '--')
end

% Reference: Julier, SJ. and Uhlmann, J.K., Unscented Filtering and
% Nonlinear Estimation, Proceedings of the IEEE, Vol. 92, No. 3,
% pp.401-422, 2004. 
% 
% By Yi Cao at Cranfield University, 04/01/2008
