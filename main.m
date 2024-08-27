%%
cost = tunning(K)

%%
x_start = 0.3;
y_start = 0.005;
x_ref = -0.3;
y_ref = 0.005;

[Ls, Rs] = inverse_kinematics(x_start, y_start);
[Lr, Rr] = inverse_kinematics(x_ref, y_ref);
Ls = rad2deg(Ls)
Lr = rad2deg(Lr)
Rs = rad2deg(Rs)
Rr = rad2deg(Rr)

%%
numvar = 3;
K = [8, 0, 0];
K_start = [ 1, 0, 0]
Inertia_range = [0.1, 1.1]
Initial_swarm_span = 100