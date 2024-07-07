clear

% [xt,yt,x2,y2,x3,y3,x4,y4,x5,y5] = forward_kinematics(135,45);

% Plot links
n = 100;

xlim([-120 120])
ylim([-50 160])
hold on

for i = 2:n
    [xt,yt,x2,y2,x3,y3,x4,y4,x5,y5] = forward_kinematics(200-1.2*i,0.4*i-20);
    f = plot(xt, yt, "k-s", "MarkerFaceColor", 'r', "MarkerSize", 8);
	h = plot([x2 x3 xt x5 x4], [y2 y3 yt y5 y4], '-ok');
	pause(0.01);
    delete(f)
    delete(h)
end

f = plot(xt, yt, "k-s", "MarkerFaceColor", 'r', "MarkerSize", 8);
h = plot([x2 x3 xt x5 x4], [y2 y3 yt y5 y4], '-ok');