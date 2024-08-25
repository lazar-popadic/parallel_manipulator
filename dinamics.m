function [MmL, MmR] = dinamics(thetaL, theta3, theta4R, thetaR, omegaL, omega3, omega4, omegaR, alphaL, alpha3, alpha4, alphaR)
    syms ML MR F12x F12y F32x F32y F43x F43y F54x F54y F15x F15y
    % syms thetaL theta3 theta4R thetaR omegaL omega3 omega4 omegaR alphaL alpha3 alpha4 alphaR
    
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
    
    eq1 = m2 * as2x == F12x + F32x;
    eq2 = m2 * as2y == F12y + F32y;
    eq3 = Js2 * alphaL == ML + P/2 * F32y * cos(thetaL) - P/2 * F32x * sin(thetaL) - P/2 * F12y * cos(thetaL) + P/2 * F12x * sin(thetaL);
    eq4 = m3 * as3x == - F32x + F43x;
    eq5 = m3 * as3y == - F32y + F43y;
    eq6 = Js3 * alpha3 == D/2 * F43y * cos(theta3) - D/2 * F43x * sin(theta3) + D/2 * F32y * cos(theta3) - D/2 * F32x * sin(theta3);
    eq7 = m4 * as4x == - F43x + F54x;
    eq8 = m4 * as4y == - F43y + F54y;
    eq9 = Js4 * alpha4 == - D/2 * F43y * cos(theta4R) + D/2 * F43x * sin(theta4R) - D/2 * F54y * cos(theta4R) + D/2 * F54x * sin(theta4R);
    eq10 = m5 * as5x == - F54x + F15x;
    eq11 = m5 * as5y == - F54y + F15y;
    eq12 = Js5 * alphaR == MR + P/2 * F54y * cos(thetaR) - P/2 * F54x * sin(thetaR) + P/2 * F15y * cos(thetaR) - P/2 * F15x * sin(thetaR);
    
    S = solve(eq1, eq2, eq3, eq4, eq5, eq6, eq7, eq8, eq9, eq10, eq11, eq12, [ML, MR, F12x, F12y, F32x, F32y, F43x, F43y, F54x, F54y, F15x, F15y]);
    
    ML_alphaL = extract_term(S.ML, alphaL);                                     % kL1
    ML_alpha3 = extract_term(S.ML, alpha3);                                     % kL2
    ML_alpha4 = extract_term(S.ML, alpha4);                                     % kL3
    ML_alphaR = extract_term(S.ML, alphaR);                                     % kL4
    ML_omegaL_sqr = extract_term(S.ML, omegaL);                                 % kL5
    ML_omega3_sqr = extract_term(S.ML, omega3);                                 % kL6
    ML_omegaR_sqr = extract_term(S.ML, omegaR);                                 % kL8
    
    MR_alphaL = extract_term(S.MR, alphaL);                                     % kR1
    MR_alpha3 = extract_term(S.MR, alpha3);                                     % kR2
    MR_alpha4 = extract_term(S.MR, alpha4);                                     % kR3
    MR_alphaR = extract_term(S.MR, alphaR);                                     % kR4
    MR_omegaL_sqr = extract_term(S.MR, omegaL);                                 % kR5
    MR_omega4_sqr = extract_term(S.MR, omega4);                                 % kR7
    MR_omegaR_sqr = extract_term(S.MR, omegaR);                                 % kL8
    
    MmL = vpa(ML_alphaL*alphaL + ML_alpha3*alpha3 + ML_alpha4*alpha4 + ML_alphaR*alphaR + ML_omegaL_sqr*omegaL^2 + ML_omega3_sqr*omega3^2 + ML_omegaR_sqr*omegaR^2,4);
    MmR = vpa(MR_alphaL*alphaL + MR_alpha3*alpha3 + MR_alpha4*alpha4 + MR_alphaR*alphaR + MR_omegaL_sqr*omegaL^2 + MR_omega4_sqr*omega4^2 + MR_omegaR_sqr*omegaR^2,4);
end