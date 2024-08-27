% Parametri simulacije
Tsim = 10e-3;                                                               % Fiksni korak simulacije: 10 [ms]
Tstart = 0;                                                                 % Vremenska instanca pocetka simulacije: 0 [s]
Tstop = 2;                                                                  % Vremenska instanca zavrsetka simulacije: 10 [s]

% % Parametri strujnog kola indukta - rotora
% Ra = 0.075;                                                                 % Normalizovana vrednost otpora namotaja rotora: 0.075 [r.j]
% Ta = 20e-3;                                                                 % Vremenska konstanta elektromagnetnog podsistema rotora: Ta = La/Ra = 20 [ms]
% 
% % Parametri mehanickog podsistema - koordinate brzina obrtanja rotora i pozicije
% kw = 0;                                                                     % Normalizovana vrednost koeficijenta sile mehanickog trenja: 0 [r.j]
% Tm = 0.5;                                                                   % Vremenska konstanta mehanickog podsistema (vreme integracije brzine): Tm = J*Wb/Mb = 500 [ms]
% kth = 0;                                                                    % Normalizovana vrednost koeficijenta sile istezanja/elasticnosti opruge: 0 [r.j]
% Tth = 1;                                                                    % Vremenska konstanta mehanickog podsistema (vreme integracije pozicije): Tth = Thb/Wb = 1 [s]
% 
% Up = (1-Ra);                                                                % Normalizovana vrednost pobudnog napona statora (jednaka nazivnom fluksu masine): 0.925 [r.j]

% Parametri DC motora
Ra = 0.242;
La = 0.0321e-3;
Kt = 10.7e-3;
Kb = 10.7e-3;
Jm = 21.4e-7;
Bm = 1e-5;

den = [Jm*La (Jm*Ra+Bm*La) (Ra*Bm+Kt*Kb)];
den_theta = [Jm*La (Jm*Ra+Bm*La) (Ra*Bm+Kt*Kb) 0];
num_Mm_theta = [-La Ra];
num_Mm_omega = num_Mm_theta;
num_Mm_alpha = -Kb*Kt;
num_Ua_theta = Kt;
num_Ua_omega = Kt;
num_Ua_alpha = [Jm*Kt Kt*Bm];
G_Mm_theta = tf(num_Mm_theta, den_theta)
G_Mm_omega = tf(num_Mm_omega, den)
G_Mm_alpha = tf(num_Mm_alpha, den)
G_Ua_theta = tf(num_Ua_theta, den_theta)
G_Ua_omega = tf(num_Ua_omega, den)
G_Ua_alpha = tf(num_Ua_alpha, den)

% Zadavanje referentnog i pocetnog polozaja
x_start = 0.3;
y_start = 0.005;
x_ref = -0.3;
y_ref = 0.005;

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
Initial_swarm_span = 100;