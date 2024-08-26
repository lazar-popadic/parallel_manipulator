%% inv k test
clear, clf

[start_ang_left, start_ang_right] = inv_k(0.09,0.001);
[des_ang_left, des_ang_right] = inv_k(-0.09,0.001);

plot_forw_k(rad2deg(start_ang_left), rad2deg(start_ang_right), rad2deg(des_ang_left), rad2deg(des_ang_right));
pause(0.2);

start_ang_left= des_ang_left;
start_ang_right = des_ang_right;
[des_ang_left, des_ang_right] = inv_k(0,0.14);

plot_forw_k(rad2deg(start_ang_left), rad2deg(start_ang_right), rad2deg(des_ang_left), rad2deg(des_ang_right));
pause(0.2);

start_ang_left= des_ang_left;
start_ang_right = des_ang_right;
[des_ang_left, des_ang_right] = inv_k(0.09,0.001);

plot_forw_k(rad2deg(start_ang_left), rad2deg(start_ang_right), rad2deg(des_ang_left), rad2deg(des_ang_right));
pause(0.2);

start_ang_left= des_ang_left;
start_ang_right = des_ang_right;
[des_ang_left, des_ang_right] = inv_k(0,0.04);

plot_forw_k(rad2deg(start_ang_left), rad2deg(start_ang_right), rad2deg(des_ang_left), rad2deg(des_ang_right));
%% forw k test
clear, clf

plot_forw_k(90, 90, 180, 0);
pause(0.2);
plot_forw_k(180, 0, 220, 135);
pause(0.2);
plot_forw_k(220, 135, 45, -40);
pause(0.2);
plot_forw_k(45, -40, 135, 45);

%% single link dinamic test
clear, clf

x_1_0_deg = 90;
x_1_0_rad = x_1_0_deg / 180 * pi;

t=0:0.01:10;
x_1_0=[x_1_0_rad  0];                   % pocetni uslovi

[t, x_1] = ode45('single_link_ode',t,x_1_0);

figure(1)
plot(t,x_1(:,1),'Linewidth',2);
xlabel('vreme');
hold on
plot(t,x_1(:,2),'Linewidth',2)
legend('ugao','ugaona brzina');

%% single link animation
clf

L = 80;
ang_displacement_1 = x_1(:,1);
ct = 1;
for i = 1:length(ang_displacement_1)
    Ang_disp_1 = ang_displacement_1(i);
    x0 = -40;
    y0 = 0;
    x1 = x0 + L*sin(Ang_disp_1 + pi/2);
    y1 = y0 - L*cos(Ang_disp_1 + pi/2);
    plot([-40,40],[0,0], 'LineWidth',1,'color','k')
    hold on
    plot([x0 x1],[y0 y1], 'LineWidth', 1,'color','k')
    hold on
    plot(x1,y1,'o','markersize',5,'Markerfacecolor','k');
    hold off
    axis([-160 160 -80 160]);   
    M(ct) = getframe(gcf);    
    ct = ct+1;   
end
%% dual independent link animation
clear, clf

x_1_0_deg = 90;
x_1_0_rad = x_1_0_deg / 180 * pi;
x_2_0_deg = 90;
x_2_0_rad = x_1_0_deg / 180 * pi;

t=0:0.01:1;
x_1_0=[x_1_0_rad  0];                   % pocetni uslovi
x_2_0=[x_2_0_rad  0];                   % pocetni uslovi

[t, x_1] = ode45('single_link_ode',t,x_1_0);
[t, x_2] = ode45('single_link_ode2',t,x_2_0);


L = 80;
ang_displacement_1 = x_1(:,1);
ang_displacement_2 = x_2(:,1);
ct = 1;
for i = 1:length(ang_displacement_1)
    Ang_disp_1 = ang_displacement_1(i);
    x_1_0 = -40;
    y_1_0 = 0;
    x_1_1 = x_1_0 + L*sin(Ang_disp_1 + pi/2);
    y_1_1 = y_1_0 - L*cos(Ang_disp_1 + pi/2);
    plot([-40,40],[0,0], 'LineWidth',1,'color','k')
    hold on
    plot([x_1_0 x_1_1],[y_1_0 y_1_1], 'LineWidth', 1,'color','k')
    hold on
    plot(x_1_1,y_1_1,'o','markersize',5,'Markerfacecolor','k');

    Ang_disp_2 = ang_displacement_2(i);
    x_2_0 = 40;
    y_2_0 = 0;
    x_2_1 = x_2_0 + L*sin(Ang_disp_2 + pi/2);
    y_2_1 = y_2_0 - L*cos(Ang_disp_2 + pi/2);
    plot([x_2_0 x_2_1],[y_2_0 y_2_1], 'LineWidth', 1,'color','k')
    hold on
    plot(x_2_1,y_2_1,'o','markersize',5,'Markerfacecolor','k');

    hold off
    axis([-160 160 -80 160]);   
    M(ct) = getframe(gcf);    
    ct = ct+1;   
end
%% new inverse kinematics
[thetaL, theta3, theta4R, thetaR] = inv_k(0.09,0.001)

%% new forward kinematics
[xtcp, ytcp, theta3, theta4R, Vxtcp, Vytcp, omega3, omega4, axtcp, aytcp, alpha3, alpha4] = forw_k(3*pi/3, pi/4, 0.1, 0.1, 0.01, 0.01);
[xtcpm, ytcpm, theta3m, theta4Rm, Vxtcpm, Vytcpm, omega3m, omega4m, axtcpm, aytcpm, alpha3m, alpha4m] = forw_k_m(3*pi/3, pi/4, 0.1, 0.1, 0.01, 0.01);

%% dinamics
ML = 1000;
thetaL = pi/2;
omegaL = 0.1;
alphaL = 0.01;
MR = 1;
thetaR = pi/4;
omegaR = 0.1;
alphaR = 0.01;

[~, P, D, mP, mD, JsP, JsD] = get_params();
    [xtcp, ytcp, theta3, theta4R, ~, ~, omega3, omega4, ~, ~, alpha3, alpha4] = forw_k(thetaL, thetaR, omegaL, omegaR, alphaL, alphaR);
    
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