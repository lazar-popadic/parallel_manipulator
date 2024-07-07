function plot_forw_k(start_ang_l, start_ang_r, end_ang_l, end_ang_r)
    clf
    n = 100;

    xlim([-120 120])
    ylim([-50 160])
    hold on

    for i = 2:n
       cur_ang_l = start_ang_l * (n - i) / n + end_ang_l * i / n;
       cur_ang_r = start_ang_r * (n - i) / n + end_ang_r * i / n;
       [xt,yt,x2,y2,x3,y3,x4,y4,x5,y5] = forw_k(cur_ang_l, cur_ang_r);
       f = plot(xt, yt, "k-s", "MarkerFaceColor", 'r', "MarkerSize", 8);
    	h = plot([x2 x3 xt x5 x4], [y2 y3 yt y5 y4], '-ok');
    	pause(0.01);
        delete(f)
        delete(h)
    end

    f = plot(xt, yt, "k-s", "MarkerFaceColor", 'r', "MarkerSize", 8);
    h = plot([x2 x3 xt x5 x4], [y2 y3 yt y5 y4], '-ok');
end