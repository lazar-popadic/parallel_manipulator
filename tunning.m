function cost = tunning(K)
assignin('base', 'K', K);
sim("five_bar.slx");
cost = f(length(f));
disp("IAE = " + cost + char(9) + char(9) + char(9) + "P = " + K(1) + char(9) + char(9) + "I = " + K(2) + char(9) + char(9) + "D = " + K(3));
end