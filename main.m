%% forw k test
clear, clf

plot_forw_k(90, 90, 180, 0);
pause(0.2);
plot_forw_k(180, 0, 220, 135);
pause(0.2);
plot_forw_k(220, 135, 45, -40);
pause(0.2);
plot_forw_k(45, -40, 135, 45);

%% inv k test
clear, clf

[start_ang_left, start_ang_right] = inv_k(90,1);
[des_ang_left, des_ang_right] = inv_k(-90,1);

plot_forw_k(start_ang_left, start_ang_right, des_ang_left, des_ang_right);
pause(0.2);

start_ang_left= des_ang_left;
start_ang_right = des_ang_right;
[des_ang_left, des_ang_right] = inv_k(0,140);

plot_forw_k(start_ang_left, start_ang_right, des_ang_left, des_ang_right);
pause(0.2);

start_ang_left= des_ang_left;
start_ang_right = des_ang_right;
[des_ang_left, des_ang_right] = inv_k(90,1);

plot_forw_k(start_ang_left, start_ang_right, des_ang_left, des_ang_right);
pause(0.2);

start_ang_left= des_ang_left;
start_ang_right = des_ang_right;
[des_ang_left, des_ang_right] = inv_k(0,60);

plot_forw_k(start_ang_left, start_ang_right, des_ang_left, des_ang_right);

%% single link dinamic test
clear, clf

x_1_0_deg = 90;
x_1_0_rad = x_1_0_deg / 180 * pi;

t=0:0.01:1;
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
ang_displacement = x_1(:,1);
ct = 1;
for i = 1:length(ang_displacement)
    Ang_disp = ang_displacement(i);
    x0 = -40;
    y0 = 0;
    x1 = x0 + L*sin(Ang_disp + pi/2);
    y1 = y0 - L*cos(Ang_disp + pi/2);
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