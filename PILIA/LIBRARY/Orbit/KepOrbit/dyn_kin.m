function Ep=dyn_kin(E,mu)
%     global mu;
    % Calculates the first derivative of the state vector E with respect to time
    
    % Satellite speed
    v=E(4:6,end);
    
    % Satellite acceleration (Newton equation)
    acc=-mu*E(1:3,end)./(sqrt(E(1,end)^2+E(2,end)^2+E(3,end)^2))^3;
    
    Ep=[v;acc];

end