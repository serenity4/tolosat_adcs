function Ep = DifferentialEq(E, thetaVec_J2000, theta, rVec_J2000, r, mu, J2, J3, J4, EarthEquatorialR, m, F)
    % Calculates the first derivative of the state vector E with respect to time
    
    P2=(3*cos(theta)^2-1)/2;
    P3=(5*cos(theta)^3-3*cos(theta))/2;
    P4=(35*cos(theta)^4-30*cos(theta)^2+3)/8;
    
    dUdr = mu/r^2-J2*mu*EarthEquatorialR^2*P2*3/r^4-J3*mu*EarthEquatorialR^3*1/r^5*4*P3...
        -J4*mu*EarthEquatorialR^4*P4*5/r^6;
    
    dP2 = -3/2*sin(2*theta);
    dP3 = (-15*cos(theta)^2*sin(theta)+3*sin(theta))/2;
    dP4 = -35/2*cos(theta)^3*sin(theta)+15/4*sin(2*theta);
    
    dUdtheta = J2*mu*EarthEquatorialR^2*1/r^3*dP2+J3*mu*EarthEquatorialR^3*1/r^4*dP3...
        +J4*mu*EarthEquatorialR^4*1/r^5*dP4;
    
    % Satellite speed
    v=E(4:6);
    
    % Satellite acceleration (Newton equation)
    acc=-dUdr*rVec_J2000-1/r*dUdtheta*thetaVec_J2000+1/m*F;
    
    Ep=[v;acc];
end

