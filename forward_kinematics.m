function [xtcp, ytcp, theta3, theta4R, Vtcp, omega3, omega4, atcp, alpha3, alpha4] = forward_kinematics(thetaL, thetaR, omegaL, omegaR, alphaL, alphaR)
    [L,P,D] = get_params();

    xA = -L/2 + P * cos(thetaL);
    yA = P * sin(thetaL);
    xB = L/2 + P * cos(thetaR);
    yB = P * sin(thetaR);

    A = (xB - xA) / D;
    B = (yB - yA) / D;
    C = (A*A + B*B) / 2;
    A1 = (xA - xB) / D;
    B1 = (yA - yB) / D;

    theta4R = 2*atan2(-B-sqrt(A*A+B*B-C*C), C-A);
    theta3 = 2*atan2(-B1+sqrt(A1*A1+B1*B1-C*C), C-A1);
    xtcp = xA + D*cos(theta3);
    ytcp = yA + D*sin(theta3);

    % Velocities
    A_v = [ -1, 0, - D*sin(theta3), 0;
            -1, 0, 0, - D*sin(theta4R);
            0, 1, - D*cos(theta3), 0;
            0, 1, 0, - D*cos(theta4R)
            ];
    B_v = [ omegaL*P*sin(thetaL);
            omegaR*P*sin(thetaR);
            omegaL*P*cos(thetaL);
            omegaR*P*cos(thetaR)
          ];
    V = A_v \ B_v;
    Vxtcp = V(1);
    Vytcp = V(2);
    omega3 = V(3);
    omega4 = V(4);
    Vtcp = sqrt(Vxtcp^2+Vytcp^2);

    % Accelerations
    A_a = [ 1, 0, D*sin(theta3), 0;
            1, 0, 0, D*sin(theta4R);
            0, 1, -D*cos(theta3), 0;
            0, 1, 0, -D*cos(theta4R)
            ];
    B_a = [ -P*sin(thetaL)*alphaL - P*cos(thetaL)*omegaL^2 - D*cos(theta3)*omega3^2;
            -P*sin(thetaR)*alphaR - P*cos(thetaR)*omegaR^2 - D*cos(theta4R)*omega4^2;
            P*cos(thetaL)*alphaL - P*sin(thetaL)*omegaL^2 - D*sin(theta3)*omega3^2;
            P*cos(thetaR)*alphaR - P*sin(thetaR)*omegaR^2 - D*sin(theta4R)*omega4^2
          ];
    A = A_a \ B_a;
    axtcp = A(1);
    aytcp = A(2);
    alpha3 = A(3);
    alpha4 = A(4);
    atcp = sqrt(axtcp^2+aytcp^2);
end