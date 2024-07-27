function [left_ang_deg, right_ang_deg] = inv_k(xt,yt)
    [L,P,D] = get_L_P_D();
    % Coordinates of the input joints
    x1 = -L/2;          % x-coordinate of the left input joint
    y1 = 0;              % y-coordinate of the left input joint
    x5 = L/2;         % x-coordinate of the right input joint
    y5 = 0;              % y-coordinate of the right input joint

    % Additional variables
    A = xt - x1;
    B = yt - y1;
    C1 = (A*A + B*B + P*P - D*D) / (2*B*P);
    C2 = A / B;

    C = xt - x5;
    D1 = yt - y5;
    C3 = (C*C + D1*D1 + P*P - D*D) / (2*D1*P);
    C4 = C / D1;

    % Solve ik
    sol_thetaL(1) = 2*atan2(1+sqrt(1-C1*C1+C2*C2), C1+C2);
    sol_thetaL(2) = 2*atan2(1-sqrt(1-C1*C1+C2*C2), C1+C2);
    %sol_thetaL(1) = wrapToPi(sol_thetaL(1));
    %sol_thetaL(2) = wrapToPi(sol_thetaL(2));

    sol_thetaR(1) = 2*atan2(1+sqrt(1-C3*C3+C4*C4), C3+C4);
    sol_thetaR(2) = 2*atan2(1-sqrt(1-C3*C3+C4*C4), C3+C4);
    sol_thetaR(1) = wrapToPi(sol_thetaR(1));
    sol_thetaR(2) = wrapToPi(sol_thetaR(2));

     % Take the right solution for +- configuration
     % TODO: izracunaj i theta3 i 4R zbog ovoga
     

    left_ang_deg = rad2deg(double(sol_thetaL(1)));
    right_ang_deg = rad2deg(double(sol_thetaR(2)));
end