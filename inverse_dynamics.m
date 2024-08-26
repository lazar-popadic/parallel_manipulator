function [MmL, MmR] = inverse_dynamics(thetaL, theta3, theta4R, thetaR, omegaL, omega3, omega4, omegaR, alphaL, alpha3, alpha4, alphaR)
    [~, P, D, mP, mD, JsP, JsD] = get_params();
    
    m2 = mP;
    m5 = mP;
    m3 = mD;
    m4 = mD;
    Js2 = JsP;
    Js5 = JsP;
    Js3 = JsD;
    Js4 = JsD;
    
    as2x = - P/2 * omegaL^2 * cos(thetaL) - P/2 * alphaL * sin(thetaL);
    as2y = - P/2 * omegaL^2 * sin(thetaL) + P/2 * alphaL * cos(thetaL);
    as3x = - P * omegaL^2 * cos(thetaL) - P * alphaL * sin(thetaL) - D/2 * omega3^2 * cos(theta3) - D/2 * alpha3 * sin(theta3);
    as3y = - P * omegaL^2 * sin(thetaL) + P * alphaL * cos(thetaL) - D/2 * omega3^2 * sin(theta3) + D/2 * alpha3 * cos(theta3);
    as4x = - P * omegaR^2 * cos(thetaR) - P * alphaR * sin(thetaR) - D/2 * omega4^2 * cos(theta4R) - D/2 * alpha4 * sin(theta4R);
    as4y = - P * omegaR^2 * sin(thetaR) + P * alphaR * cos(thetaR) - D/2 * omega4^2 * sin(theta4R) + D/2 * alpha4 * cos(theta4R);
    as5x = - P/2 * omegaR^2 * cos(thetaR) - P/2 * alphaR * sin(thetaR);
    as5y = - P/2 * omegaR^2 * sin(thetaR) + P/2 * alphaR * cos(thetaR);

    A_d = [ 1, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0;
            0, 1, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0;
            P/2*sin(thetaL), -P/2*cos(thetaL), 1, -P/2*sin(thetaL), P/2*cos(thetaL), 0, 0, 0, 0, 0, 0, 0;
            0, 0, 0, -1, 0, 1, 0, 0, 0, 0, 0, 0;
            0, 0, 0, 0, -1, 0, 1, 0, 0, 0, 0, 0;
            0, 0, 0, -D/2*sin(theta3), D/2*cos(theta3), -D/2*sin(theta3), D/2*cos(theta3), 0, 0, 0, 0, 0;
            0, 0, 0, 0, 0, -1, 0, 1, 0, 0, 0, 0;
            0, 0, 0, 0, 0, 0, -1, 0, 1, 0, 0, 0;
            0, 0, 0, 0, 0, D/2*sin(theta4R), -D/2*cos(theta4R), D/2*sin(theta4R), -D/2*cos(theta4R), 0, 0, 0;
            0, 0, 0, 0, 0, 0, 0, -1, 0, 1, 0, 0;
            0, 0, 0, 0, 0, 0, 0, 0, -1, 0, 1, 0;
            0, 0, 0, 0, 0, 0, 0, -P/2*sin(thetaR), P/2*cos(thetaR), -P/2*sin(thetaR), P/2*cos(thetaR), 1
          ];
    B_d = [ m2 * as2x;
            m2 * as2y;
            Js2 * alphaL;
            m3 * as3x;
            m3 * as3y;
            Js3 * alpha3;
            m4 * as4x;
            m4 * as4y;
            Js4 * alpha4;
            m5 * as5x;
            m5 * as5y;
            Js5 * alphaR
          ];
    D = A_d \ B_d;
    MmL = D(3);
    MmR = D(12);
end