clear

%--------------------------------------------------------------------------------------------------------------------------------
% Parametri simulacije
%--------------------------------------------------------------------------------------------------------------------------------
Tsim = 10e-6;                                                               % Fiksni korak simulacije: 10 [us]
Tstart = 0;                                                                 % Vremenska instanca pocetka simulacije: 0 [s]
Tstop = 10;                                                                 % Vremenska instanca zavrsetka simulacije: 10 [s]

%--------------------------------------------------------------------------------------------------------------------------------
% Parametri za snimanje trajektorije pogona
%--------------------------------------------------------------------------------------------------------------------------------
Trec = 1e-3;                                                                % Perioda odabiranja snimaca trajektorije: 1 [ms]

ymin = -2.0;                                                                % Donji limit ordinatne ose 
ymax = 2.0;                                                                 % Gornji limit ordinatne ose 
xmin = -10.0;                                                               % Donji limit apscisne ose 
xmax = 10.0;                                                                % Gornji limit apscisne ose 

%--------------------------------------------------------------------------------------------------------------------------------
% Parametri strujnog kola indukta - rotora
%--------------------------------------------------------------------------------------------------------------------------------
Ra = 0.075;                                                                 % Normalizovana vrednost otpora namotaja rotora: 0.075 [r.j]
Ta = 20e-3;                                                                 % Vremenska konstanta elektromagnetnog podsistema rotora: Ta = La/Ra = 20 [ms]

%--------------------------------------------------------------------------------------------------------------------------------
% Parametri strujnog kola induktora - statora
%--------------------------------------------------------------------------------------------------------------------------------
Rf = 1;                                                                     % Normalizovana vrednost otpora namotaja statora: 1 [r.j]
Tf = 0.15;                                                                  % Vremenska konstanta elektromagnetnog podsistema statora: Tf = Lf/Rf = 150 [ms]

%--------------------------------------------------------------------------------------------------------------------------------
% Parametri mehanickog podsistema - koordinate brzina obrtanja rotora i pozicije
%--------------------------------------------------------------------------------------------------------------------------------
kw = 0;                                                                     % Normalizovana vrednost koeficijenta sile mehanickog trenja: 0 [r.j]
Tm = 0.5;                                                                   % Vremenska konstanta mehanickog podsistema (vreme integracije brzine): Tm = J*Wb/Mb = 500 [ms]
kth = 0;                                                                    % Normalizovana vrednost koeficijenta sile istezanja/elasticnosti opruge: 0 [r.j]
Tth = 1;                                                                    % Vremenska konstanta mehanickog podsistema (vreme integracije pozicije): Tth = Thb/Wb = 1 [s]

%--------------------------------------------------------------------------------------------------------------------------------
% Parametri blokova za eksitacija sistema - pobuda, armatura, vratilo
%--------------------------------------------------------------------------------------------------------------------------------
% Magnetni ulaz - kolo pobude
Up = (1-Ra);                                                                % Normalizovana vrednost pobudnog napona statora (jednaka nazivnom fluksu masine): 0.925 [r.j]

% Elektricni prolaz - namotaj rotora
Ua = 1;                                                                     % Normalizovana vrednost napona rotora (nazivna vrednost): 1 [r.j]
t_a = 2;                                                               % Vremenska instanca zadavanja signala napona rotora: 2 [s]

% Mehanicki prolaz - vratilo
mm = 1-Ra;                                                                  % Normalizovana vrednost momenta opterecenja na vratilu (nazivna vrednost): 0.925 [r.j]
t_opt = 5;                                                                  % Vremenska instanca zadavanja opterecenja na vratilu: 5 [s]

