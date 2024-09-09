% Parametri dc motora
Ra = 0.075;                                                                 % Normalizovana vrednost otpornosti: 0.075 [r.j]
Ta = 1e-3;                                                                  % Vremenska konstanta elektromagnetnog podsistema rotora: Ta = La/Ra = 1 [ms]
Bm = 1e-6;                                                                  % Normalizovana vrednost koeficijenta sile mehanickog trenja: 1e-6 [r.j]
Tm = 500e-3;                                                                % Vremenska konstanta mehanickog podsistema (vreme integracije brzine): Tm = 500 [ms]
psi_f = 1-Ra;                                                               % Normalizovana vrednost fluksa: 0.925 [r.j]

Koef_m = 4.2;                                                               % Koeficijent prebacivanja momenta iz normalizovanog domena
Koef_w = 12;                                                                % Koeficijent prebacivanja brzine iz normalizovanog domena

% Zadavanje referentnog i pocetnog polozaja
x_start = 40e-3;
y_start = 60e-3;
x_ref = -40e-3;
y_ref = 60e-3;

% [Ls, Rs] = inverse_kinematics(x_start, y_start);
% [Lr, Rr] = inverse_kinematics(x_ref, y_ref);
% Ls = rad2deg(Ls);
% Lr = rad2deg(Lr);
% Rs = rad2deg(Rs);
% Rr = rad2deg(Rr);

% Zadavanje parametara za PSO
numvar = 3;
Inertia_range = [0.4, 0.9];

lower_bounds = [2, 0, 0];
upper_bounds = [64, 36, 20];

K_start = [32,18,10];
K = K_start;

%w = [1, 1, 1];
w = [1,0,0];

% Parametri simulacije
Tsim = 2e-3;                                                               % Fiksni korak simulacije: 2 [ms]
Tstop = 10;                                                                 % Vremenska instanca zavrsetka simulacije: 10 [s]

Mext = 2;
%Mext = 0;
Mext_start = 2;
Mext_stop = 10;

%% duga putanja
x_s1 = 80e-3;
y_s1 = 40e-3;

x_start = x_s1;
x_ref = - x_s1;
y_start = y_s1;
y_ref = y_s1;
%% kratka putanja
x_s2 = 10e-3;
y_s2 = 60e-3;

x_start = x_s2;
x_ref = - x_s2;
y_start = y_s2;
y_ref = y_s2;