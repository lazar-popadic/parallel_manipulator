% Parametri dc motora
Ra = 0.075;                                                                 % Normalizovana vrednost otpornosti: 0.075 [r.j]
Ta = 1e-3;                                                                  % Vremenska konstanta elektromagnetnog podsistema rotora: Ta = La/Ra = 1 [ms]
Bm = 1e-6;                                                                  % Normalizovana vrednost koeficijenta sile mehanickog trenja: 1e-6 [r.j]
Tm = 500e-3;                                                                % Vremenska konstanta mehanickog podsistema (vreme integracije brzine): Tm = 500 [ms]
psi_f = 1-Ra;                                                               % Normalizovana vrednost fluksa: 0.925 [r.j]

Koef_m = 2.1;                                                               % Koeficijent prebacivanja momenta iz normalizovanog domena
Koef_w = 24;                                                                % Koeficijent prebacivanja brzine iz normalizovanog domena

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
Inertia_range = [0.2, 0.9];

lower_bounds = [1, 0, 0];
upper_bounds = [40, 4, 8];

K_start = [1,0,0];
% Initial_swarm_span = [0.1, 0.01, 0.01];
% K = K_start;
K = [15,0,0.4];

w = [1, 4, 1.5];

% Parametri simulacije
Tsim = 10e-4;                                                               % Fiksni korak simulacije: 1 [ms]
Tstop = 10;                                                                 % Vremenska instanca zavrsetka simulacije: 10 [s]

Mext = 16;
Mext_start = 5;
Mext_stop = 7.5;