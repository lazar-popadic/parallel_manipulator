function [left_ang_deg, right_ang_deg] = inv_k(xt,yt)
    [l,p,d] = get_L_P_D();
    % Coordinates of the input joints
    x2 = -l/2;          % x-coordinate of the left input joint
    y2 = 0;              % y-coordinate of the left input joint
    x4 = l/2;         % x-coordinate of the right input joint
    y4 = 0;              % y-coordinate of the right input joint

    % Additional variables
    A = xt - x2;
    B = yt - y2;
    C1 = (A*A + B*B + p*p - d*d) / (2*B*p);
    C2 = A / B;

    C = xt - x4;
    D = yt - y4;
    C3 = (C*C + D*D + p*p - d*d) / (2*D*p);
    C4 = C / D;

    % Solve ik
    sol_theta2(1) = 2*atan2(1+sqrt(1-C1*C1+C2*C2), C1+C2);
    sol_theta2(2) = 2*atan2(1-sqrt(1-C1*C1+C2*C2), C1+C2);
    %sol_theta2(1) = wrapToPi(sol_theta2(1));
    %sol_theta2(2) = wrapToPi(sol_theta2(2));

    sol_theta4(1) = 2*atan2(1+sqrt(1-C3*C3+C4*C4), C3+C4);
    sol_theta4(2) = 2*atan2(1-sqrt(1-C3*C3+C4*C4), C3+C4);
    sol_theta4(1) = wrapToPi(sol_theta4(1));
    sol_theta4(2) = wrapToPi(sol_theta4(2));

     % Take the right solution for +- configuration
     % TODO: izracunaj i theta3 i 5 zbog ovoga
     

    left_ang_deg = rad2deg(double(sol_theta2(1)));
    right_ang_deg = rad2deg(double(sol_theta4(2)));
end