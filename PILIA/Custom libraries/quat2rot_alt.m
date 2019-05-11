function y = quat2rot_alt(quat)

%%% returns rotation matrix from quaternion quat

q0 = quat(1);
q1 = quat(2);
q2 = quat(3);
q3 = quat(4);
vec = quat(4:6);
P = [2*(q0^2 + q1^2)-1 2*(q1*q2 - q0*q3) 2*(q1*q3 + q2*q0);
     2*(q1*q2 + q0*q3) 2*(q0^2 + q2^2)-1 2*(q2*q3 - q1*q0);
     2*(q1*q3 - q2*q0) 2*(q2*q3 + q1*q0) 2*(q0^2 + q3^2)-1];
y = P*vec;
