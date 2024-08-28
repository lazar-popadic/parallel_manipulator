function cost = tunning(K)
assignin('base', 'K', K);
K
sim("five_bar.slx");
cost = IAE1(length(IAE1))
disp("____________");
end