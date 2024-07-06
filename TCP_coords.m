clear
% constant parameters
L = 40;              % length of the static link [mm]
P = 56;             % length of the proximal links [mm]
D = 89.6;          % length of the distal l inks [mm]

% input angles
theta2 = 150;                                 % input angle at the left input joint [degrees]
theta4 = 75;                               % input angle at the right input joint [degrees]
theta2rad = deg2rad(theta2);  % [radians]
theta4rad = deg2rad(theta4);  % [radians]

% Coordinates of the input joints
x2 = -L/2;          % x-coordinate of the left input joint
y2 = 0;              % y-coordinate of the left input joint
x4 = L/2;         % x-coordinate of the right input joint
y4 = 0;              % y-coordinate of the right input joint

% Coordinates of the proximal joints
x3 = x2 + P * cos(theta2rad);
y3 = y2 + P * sin(theta2rad);
x5 = x4 + P * cos(theta4rad);
y5 = y4 + P * sin(theta4rad);

% Equations to solve

syms theta3 theta5
eq1 = x3 + D * cos(theta3) == x5 + D * cos(theta5);
eq2 = y3 + D * sin(theta3) == y5 + D * sin(theta5);

% Solve equations
[sol_theta3, sol_theta5] = solve([eq1, eq2], [theta3, theta5]);

%fprintf('Theta2: \t\t%.2f degrees\n', theta2);
%fprintf('Theta3: \t\t%.2f degrees\n', rad2deg(double(sol_theta3())));
%fprintf('\nTheta4:  \t%.2f degrees\n', theta4);
%fprintf('Theta5: \t\t%.2f degrees\n', rad2deg(double(sol_theta5())));

% Take the right solution for +- configuration

if double(sol_theta3(1)) > theta2rad - pi && double(sol_theta3(1)) < theta2rad && double(sol_theta5(1)) > theta4rad && double(sol_theta5(1)) < theta4rad  + pi
    theta3solved = rad2deg(double(sol_theta3(1)));
    theta5solved = rad2deg(double(sol_theta5(1)));
else
    theta3solved = rad2deg(double(sol_theta3(2)));
    theta5solved = rad2deg(double(sol_theta5(2)));
end

% Display the solutions

fprintf('\nResults for checking with Fusion 360:\n\n');
fprintf('Left input angle: \t\t\t\t%.2f degrees\n', -theta2);
fprintf('Right input angle:  \t\t\t\t%.2f degrees\n', -theta4);
fprintf('Left proximal angle in regards to left input: \t%.2f degrees\n', -theta3solved + theta2);
fprintf('Right proximal angle in regards to right input: \t%.2f degrees\n\n', -theta5solved + theta4);

% Calculate the coordinates of Tcp
xt1 = x3 + D*cos(deg2rad(theta3solved));
%xt2 = x5 + D*cos(deg2rad(theta5solved));
yt1 = y3 + D*sin(deg2rad(theta3solved));
%yt2 = y5 + D*sin(deg2rad(theta5solved));

xt = xt1;
yt = yt1;

fprintf('\nCoordinates of Tcp: \t\t(%.2f mm, %.2f mm)\n', xt, yt);

% Plot links

% Link 2
x = [x2, x3];
y = [y2, y3];
plot(x,y, "k-s", "MarkerFaceColor","b","MarkerSize",12);
hold on

% Link 3
x = [x3, xt];
y = [y3, yt];
plot(x,y, "k-s", "MarkerFaceColor","b","MarkerSize",12);
hold on

% Link 4
x = [x4, x5];
y = [y4, y5];
plot(x,y, "k-s", "MarkerFaceColor","b","MarkerSize",12);
hold on

% Link 5
axis([-120 120 -60 160])
x = [x5, xt];
y = [y5, yt];
plot(x,y, "k-s", "MarkerFaceColor","b","MarkerSize",12);
hold on 