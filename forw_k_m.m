function [xtcp, ytcp, theta3, theta4R, Vxtcp, Vytcp, omega3, omega4, axtcp, aytcp, alpha3, alpha4] = forw_k_m(thetaL, thetaR, omegaL, omegaR, alphaL, alphaR)
    [L,P,D] = get_params();

    xA = -L/2 + P * cos(thetaL);
    yA = P * sin(thetaL);
    xB = L/2 + P * cos(thetaR);
    yB = P * sin(thetaR);

    A = (xB - xA) / D;
    B = (yB - yA) / D;
    C = (A*A + B*B) / 2;

    theta4R = 2*atan2(-B-sqrt(A*A+B*B-C*C), C-A);
    theta3 = asin((yB-yA)/D + sin(theta4R));
    xtcp = xA + D*cos(theta3);
    ytcp = yA + D*sin(theta3);

    % Velocities

    A_v = [ -1/(P*sin(thetaL)), 0, - D*sin(theta3)/(P*sin(thetaL)), 0;
            -1/(P*sin(thetaR)), 0, - D*sin(theta4R)/(P*sin(thetaR)), 0;
            0, 1/(P*cos(thetaL)), - D*cos(theta3)/(P*cos(thetaL)), 0;
            0, 1/(P*cos(thetaR)), 0, - D*cos(theta4R)/(P*cos(thetaR))
            ];
    B_v = [   omegaL;
            omegaR;
            omegaL;
            omegaR
            ];
    V = A_v\B_v;
    Vxtcp = V(1);
    Vytcp = V(2);
    omega3 = V(3);
    omega4 = V(4);

    % Accelerations
    syms axtcp aytcp alpha3 alpha4

    eqa1 = axtcp == - P*cos(thetaL)*omegaL^2 - P*sin(thetaL)*alphaL - D*cos(theta3)*omega3^2 - D*sin(theta3)*alpha3;
    eqa2 = axtcp == - P*cos(thetaR)*omegaR^2 - P*sin(thetaR)*alphaR - D*cos(theta4R)*omega4^2 - D*sin(theta4R)*alpha4;
    eqa3 = aytcp == - P*sin(thetaL)*omegaL^2 + P*cos(thetaL)*alphaL - D*sin(theta3)*omega3^2 + D*cos(theta3)*alpha3;
    eqa4 = aytcp == - P*sin(thetaR)*omegaR^2 + P*cos(thetaR)*alphaR - D*sin(theta4R)*omega4^2 + D*cos(theta4R)*alpha4;

    a = vpasolve(eqa1, eqa2, eqa3, eqa4, [axtcp, aytcp, alpha3, alpha4]);
    axtcp = double(a.axtcp);
    aytcp = double(a.aytcp);
    alpha3 = double(a.alpha3);
    alpha4 = double(a.alpha4);
end