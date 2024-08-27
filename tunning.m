function cost = tunning(K)
assignin('base', 'K', K);
P = K(1)/8
I = K(2)/50
D = K(3)/200
sim("five_bar.slx");
cost = ITAE1(length(ITAE1))
disp("____________");
end