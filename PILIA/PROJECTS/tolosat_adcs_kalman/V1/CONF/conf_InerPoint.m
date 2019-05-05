function confInerPoint = conf_InerPoint ()

% conf_InerPoint - Configuration function of the inertial pointing command
%
%   This function allows you to set the direction that the satellite should
%   poist, in the form of a commanded quaternion.
%
%   Outputs:
%       - conf_InerPoint: Matlab structure containing the quaternion that
%       defines the direction that the satellite shuold point to

% Commanded quaternion of the inertial pointing (its norm must be unitary)
% confInerPoint.Qcom=[0; 1; 0; 0];
confInerPoint.Qcom=0.25*[sqrt(4); sqrt(4); sqrt(4); sqrt(4)];

end
