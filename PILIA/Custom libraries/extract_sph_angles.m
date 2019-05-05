function y = extract_sph_angles(quat)

%%% extracts theta and phi from quaternion qsat
%%% here we consider the angles for the z-axis (0 0 1)
%%% but it can be changed to any other axis if necessary.

q0 = quat(1);
q1 = quat(2);
q2 = quat(3);
q3 = quat(4);
P = [2*(q0^2 + q1^2)-1 2*(q1*q2 - q0*q3) 2*(q1*q3 + q2*q0);
     2*(q1*q2 + q0*q3) 2*(q0^2 + q2^2)-1 2*(q2*q3 - q1*q0);
     2*(q1*q3 - q2*q0) 2*(q2*q3 + q1*q0) 2*(q0^2 + q3^2)-1];
prod = P*[0; 0; 1];
x = prod(1);
y = prod(2);
z = prod(3);
[phi, theta, r] = cart2sph(x, y, z);

y = [theta; phi];