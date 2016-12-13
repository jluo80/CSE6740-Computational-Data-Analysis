function [] = homework2( )
% This is a simple example to help you evaluate your clustering algo implementation. You should run your code several time and report the best
% result. The data contains a 400*101 matrix call X, in which the last
% column is the true label of the assignment, but you are not allowed to
% use this label in your implementation, the label is provided to help you
% evaluate your algorithm. 
%
%
% Please implement your clustering algorithm in the other file, mycluster.m. Have fun coding!

load('data');
T = X(:,1:100);
label = X(:,101);

sum_acc = 0;
max_acc = 0;
min_acc = 100;
run = 20;

for i = 1 : run
    [IDX, mu_jc] = mycluster(T,4);
    acc = AccMeasure(label,IDX)
    sum_acc = sum_acc + acc;
    % Find the max accuracy
    if acc > max_acc
        max_acc = acc;
    end
    % Find the min accuracy
    if acc < min_acc
        min_acc = acc;
    end    
end
average_acc = sum_acc / run;
display(average_acc);
display(max_acc);
display(min_acc);





