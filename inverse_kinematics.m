function [thetaL_ref, thetaR_ref] = inverse_kinematics(xtcp,ytcp)
    [L,P,D] = get_params();

    C1 = ((xtcp + L/2)^2 + ytcp^2 + P^2 - D^2) / (2*ytcp*P);
    C2 = (xtcp + L/2) / ytcp;
    C3 = ((xtcp - L/2)^2 + ytcp^2 + P^2 - D^2) / (2*ytcp*P);
    C4 = (xtcp - L/2) / ytcp;

    thetaL_ref = 2*atan2(1+sqrt(1-C1*C1+C2*C2), C1+C2);
    thetaR_ref = 2*atan2(1-sqrt(1-C3*C3+C4*C4), C3+C4);

    thetaL_ref = wrapTo2Pi(thetaL_ref);
    thetaR_ref = wrapToPi(thetaR_ref);
end