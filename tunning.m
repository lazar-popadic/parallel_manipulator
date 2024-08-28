function cost = tunning(K)
assignin('base', 'K', K);
P = K(1)
I = K(2)
D = K(3)
sim("five_bar.slx");
cost = IAE1(length(IAE1))
disp("____________");
end