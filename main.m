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

[start_ang_left, start_ang_right] = inv_k(52,64);
[des_ang_left, des_ang_right] = inv_k(-52,100);

plot_forw_k(start_ang_left, start_ang_right, des_ang_left, des_ang_right);