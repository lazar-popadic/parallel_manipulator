% Parametri dc motora
Ra = 0.075;
Ta = 1e-3;                                                                 % Vremenska konstanta elektromagnetnog podsistema rotora: Ta = La/Ra = 1 [ms]

Bm = 1e-6;                                                                     % Normalizovana vrednost koeficijenta sile mehanickog trenja: 1e-5 [r.j]
Tm = 500e-3;                                                                   % Vremenska konstanta mehanickog podsistema (vreme integracije brzine): Tm = 500 [ms]

Kt = 1-Ra;                                                                % Normalizovana vrednost pobudnog napona statora (jednaka nazivnom fluksu masine): 0.925 [r.j]
Kb = Kt;

% Zadavanje referentnog i pocetnog polozaja
x_start = 50e-3;
y_start = 20e-3;
x_ref = -50e-3;
y_ref = 20e-3;

[Ls, Rs] = inverse_kinematics(x_start, y_start);
[Lr, Rr] = inverse_kinematics(x_ref, y_ref);
Ls = rad2deg(Ls);
Lr = rad2deg(Lr);
Rs = rad2deg(Rs);
Rr = rad2deg(Rr);

% Zadavanje parametara za PSO
numvar = 3;
K_start = [ 0.01, 0, 0];
Inertia_range = [0.1, 0.9];
Initial_swarm_span = [80, 1, 10];

lower_bounds = [0.4, 0, 0];
upper_bounds = [80, 1, 10];

% Parametri simulacije
Tsim = 10e-4;                                                               % Fiksni korak simulacije: 10 [ms]
Tstop = 1;                                                                  % Vremenska instanca zavrsetka simulacije: 10 [s]

