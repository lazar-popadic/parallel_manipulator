function cost = tunning(K)
assignin('base', 'K', K);
%disp("____________");
%K
sim("five_bar.slx");
cost = IAE1(length(IAE1));
end