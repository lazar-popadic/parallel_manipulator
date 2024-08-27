function [L, P, D, mP, mD, JsP, JsD] = get_params()
L = 0.1;                                                                    % [m]
P = 0.15;                                                                   % [m]
D = 0.22;                                                                   % [m]
mP = 0.15;                                                                  % [kg]
mD = 0.22;                                                                  % [kg]
JsP = 1/12 * mP * (P ^ 2);                                                  % [kg * m^2]
JsD = 1/12 * mD * (D ^ 2);                                                  % [kg * m^2]
end