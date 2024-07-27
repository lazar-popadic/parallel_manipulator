function [xt,yt,x1,y1,x2,y2,x5,y5,x4,y4] = forw_k(left_ang_deg, right_ang_deg)
    [L,P,D] = get_L_P_D();

    thetaL = left_ang_deg;
    thetaR = right_ang_deg;
    thetaLrad = deg2rad(thetaL);  % [radians]
    thetaRrad = deg2rad(thetaR);  % [radians]

    % Coordinates of the input joints
    x1 = -L/2;          % x-coordinate of the left input joint
    y1 = 0;              % y-coordinate of the left input joint
    x5 = L/2;         % x-coordinate of the right input joint
    y5 = 0;              % y-coordinate of the right input joint

    % Coordinates of the proximal joints
    x2 = x1 + P * cos(thetaLrad);
    y2 = y1 + P * sin(thetaLrad);
    x4 = x5 + P * cos(thetaRrad);
    y4 = y5 + P * sin(thetaRrad);

    % Additional variables
    A = (x4 - x2) / D;
    B = (y4 - y2) / D;
    C = (A*A + B*B) / 2;

    % Solve equations
    % [sol_theta3, sol_theta4R] = solve([eq1, eq2], [theta3, theta4R]);
    sol_theta4R(1) = 2*atan2(-B+sqrt(A*A+B*B-C*C), C-A);
    sol_theta4R(2) = 2*atan2(-B-sqrt(A*A+B*B-C*C), C-A);
    sol_theta4R(1) = wrapToPi(sol_theta4R(1));
    sol_theta4R(2) = wrapToPi(sol_theta4R(2));

    sol_theta3(1) = asin((y4-y2)/D + sin( sol_theta4R(1)));
    sol_theta3(2) = asin((y4-y2)/D + sin( sol_theta4R(2)));

    % Take the right solution for +- configuration
    if double(sol_theta3(1)) > thetaLrad - pi && double(sol_theta3(1)) < thetaLrad && double(sol_theta4R(1)) > thetaRrad && double(sol_theta4R(1)) < thetaRrad  + pi
        theta3solved = rad2deg(double(sol_theta3(1)));
        theta4Rsolved = rad2deg(double(sol_theta4R(1)));
    else
        theta3solved = rad2deg(double(sol_theta3(2)));
        theta4Rsolved = rad2deg(double(sol_theta4R(2)));
    end
    
    % Calculate the coordinates of Tcp
    xt1 = x2 + D*cos(deg2rad(theta3solved));
    xt2 = x4 + D*cos(deg2rad(theta4Rsolved));
    yt1 = y2 + D*sin(deg2rad(theta3solved));
    yt2 = y4 + D*sin(deg2rad(theta4Rsolved));

    if sqrt((xt1-x2)^2+(yt1-y2)^2) == D && sqrt((xt1-x4)^2+(yt1-y4)^2) == D
        xt = xt1;
        yt = yt1;
    else
        xt = xt2;
        yt = yt2;
    end

end