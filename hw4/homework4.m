function homework4
% This is the main function for homework 4
% You are asked to plugin your implementation for algorithm, the argument is the q



clear;close all;

load sp500;

p1=algorithm(0.7);
p2=algorithm(0.9);

% The probability of good economic in the 39th week.
display(p1(39,1));
display(p2(39,1));

% Plot the probability of good economic in 39 weeks.
week=1:1:39;
plot(week,p1(:,1));
hold on;
plot(week,p2(:,1));
legend('q=0.7','q=0.9')
title('Probability of good economic in 39 weeks');
end
