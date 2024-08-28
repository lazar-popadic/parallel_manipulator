% Parametri dc motora
Ra = 0.242;
Ta = 1.3e-4;                                                                 % Vremenska konstanta elektromagnetnog podsistema rotora: Ta = La/Ra = 0.13 [ms]

Bm = 1e-5;                                                                     % Normalizovana vrednost koeficijenta sile mehanickog trenja: 1e-5 [r.j]
Tm = 4.5e-3;                                                                   % Vremenska konstanta mehanickog podsistema (vreme integracije brzine): Tm = 4.5 [ms]

Kt = 1-Ra;                                                                % Normalizovana vrednost pobudnog napona statora (jednaka nazivnom fluksu masine): 0.758 [r.j]
Kb = Kt;

% Zadavanje referentnog i pocetnog polozaja
x_start = 70e-3;
y_start = 1e-3;
x_ref = -70e-3;
y_ref = 1e-3;

[Ls, Rs] = inverse_kinematics(x_start, y_start);
[Lr, Rr] = inverse_kinematics(x_ref, y_ref);
Ls = rad2deg(Ls);
Lr = rad2deg(Lr);
Rs = rad2deg(Rs);
Rr = rad2deg(Rr);

% Zadavanje parametara za PSO
numvar = 3;
K = [ 8, 0, 0];
K_start = [ 1, 0, 0];
Inertia_range = [0.1, 1.1];
Initial_swarm_span = 1000;
upper_bounds = [ 1000, 56, 5 ];

% Parametri simulacije
Tstep = 10e-5;                                                               % Fiksni korak simulacije: 10 [ms]
Tsim = Tstep;
Tstart = 0;                                                                 % Vremenska instanca pocetka simulacije: 0 [s]
Tstop = 0.1;                                                                  % Vremenska instanca zavrsetka simulacije: 10 [s]

