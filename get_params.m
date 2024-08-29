function [L, P, D, mP, mD, JsP, JsD] = get_params()
L = 40e-3;                                                                    % [m]
P = 60e-3;                                                                   % [m]
D = 90e-3;                                                                   % [m]
mP = 200e-3;                                                                  % [kg]
mD = 240e-3;                                                                  % [kg]
JsP = 1/12 * mP * (P ^ 2);                                                  % [kg * m^2]
JsD = 1/12 * mD * (D ^ 2);                                                  % [kg * m^2]
end