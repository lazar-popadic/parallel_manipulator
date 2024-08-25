function [L, P, D, mP, mD, JsP, JsD] = get_params()
L = 0.04;                                                                   % [m]
P = 0.06;                                                                   % [m]
D = 0.09;                                                                   % [m]
mP = 0.06;                                                                  % [kg]
mD = 0.09;                                                                  % [kg]
JsP = 1/12 * mP * (P ^ 2);                                                  % [kg * m^2]
JsD = 1/12 * mD * (D ^ 2);                                                  % [kg * m^2]
end