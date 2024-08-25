function [xtcp, ytcp, theta3, theta4R, Vxtcp, Vytcp, omega3, omega4, axtcp, aytcp, alpha3, alpha4] = forw_k(thetaL, thetaR, omegaL, omegaR, alphaL, alphaR)
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
    syms Vxtcp Vytcp omega3 omega4

    eqv1 = Vxtcp == -P*sin(thetaL)*omegaL - D*sin(theta3)*omega3;
    eqv2 = Vxtcp == -P*sin(thetaR)*omegaR - D*sin(theta4R)*omega4;
    eqv3 = Vytcp == P*cos(thetaL)*omegaL + D*cos(theta3)*omega3;
    eqv4 = Vytcp == P*cos(thetaR)*omegaR + D*cos(theta4R)*omega4;

    V = solve(eqv1, eqv2, eqv3, eqv4, [Vxtcp, Vytcp, omega3, omega4]);
    Vxtcp = vpa(V.Vxtcp, 4);
    Vytcp = vpa(V.Vytcp,4);
    omega3 = vpa(V.omega3,4);
    omega4 = vpa(V.omega4,4);

    % Accelerations
    syms axtcp aytcp alpha3 alpha4

    eqa1 = axtcp == - P*cos(thetaL)*omegaL^2 - P*sin(thetaL)*alphaL - D*cos(theta3)*omega3^2 - D*sin(theta3)*alpha3;
    eqa2 = axtcp == - P*cos(thetaR)*omegaR^2 - P*sin(thetaR)*alphaR - D*cos(theta4R)*omega4^2 - D*sin(theta4R)*alpha4;
    eqa3 = aytcp == - P*sin(thetaL)*omegaL^2 + P*cos(thetaL)*alphaL - D*sin(theta3)*omega3^2 + D*cos(theta3)*alpha3;
    eqa4 = aytcp == - P*sin(thetaR)*omegaR^2 + P*cos(thetaR)*alphaR - D*sin(theta4R)*omega4^2 + D*cos(theta4R)*alpha4;

    a = solve(eqa1, eqa2, eqa3, eqa4, [axtcp, aytcp, alpha3, alpha4]);
    axtcp = vpa(a.axtcp, 4);
    aytcp = vpa(a.aytcp, 4);
    alpha3 = vpa(a.alpha3, 4);
    alpha4 = vpa(a.alpha4, 4);
end