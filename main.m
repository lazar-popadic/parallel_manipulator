%% forw k test
clear

plot_forw_k(90, 90, 180, 0);
pause(0.4);
plot_forw_k(180, 0, 220, 135);
pause(0.4);
plot_forw_k(220, 135, 45, -40);
pause(0.4);
plot_forw_k(45, -40, 135, 45);

%% inv k test
clear

[start_ang_left, start_ang_right] = inv_k(90,1);
[des_ang_left, des_ang_right] = inv_k(-90,1);

plot_forw_k(start_ang_left, start_ang_right, des_ang_left, des_ang_right);

start_ang_left= des_ang_left;
start_ang_right = des_ang_right;
[des_ang_left, des_ang_right] = inv_k(0,140);

plot_forw_k(start_ang_left, start_ang_right, des_ang_left, des_ang_right);

%% initialization of pid parameters
