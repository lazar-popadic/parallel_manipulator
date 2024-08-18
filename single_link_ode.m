function xdot = single_link_ode(t,x)
L = 0.09;            % duzina clana
m = 0.05;              % masa clana
B = 0.1;            % koeficijent prigusivanja
J = 1/3 * m * L * L;

t1 = t >= 1;
t2 = t >= 1.2;
M = 1 * (t1-t2); % Spoljasnji moment, koji deluje u intervalu od t1 do t2

xdot = zeros(2,1);
xdot(1) = x(2);
xdot(2) = M / J - B / J * x(2);
end