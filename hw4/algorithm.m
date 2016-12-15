function prob = algorithm(q)
load sp500;
% plot and return the probability

% (1) Since we need to plot the probability of good state in 39 weeks, then
% we need to calculate for 39 individual states instead of a 39-state
% sequence. Thus this algorithm implements forward & backward algorithm to
% solve this problem. It includes two parts, the fowrward algorithm and
% backward algorithm.
% 
% (2) According to the price_move of sp500.mat, we can notice that there
% are two possible outcome of y which are +1 and -1, and two possible
% outcome of x which are good and bad during 39 weeks. Thus i(+1/-1) can be
% 1 or 2, k(good/bad) can be 1 or 2 and t can take from 1 to 39.

%%% (1)FORWARD ALGORITHM
%% Initialization
[numOfWeeks,~]=size(price_move);
% emission matrix: row: +1, -1; column: good, bad.
emission=[q,1-q;1-q,q];
% transition matrix: row: good, bad; column: good, bad.
transition=[0.8 0.2; 0.2 0.8];
% start probability
pi=[0.2, 0.8];
alpha=zeros(numOfWeeks,2);
% alpha(1,1) -> good, alpha(1,2) -> bad. The first price_move is -1.
alpha(1,1)=pi(1)*emission(2,1);
alpha(1,2)=pi(2)*emission(2,2);
%% Iteration
for week=2:numOfWeeks
    if(price_move(week)==1)
        alpha(week,1)=emission(1,1)*(alpha(week-1,1)*transition(1,1)+alpha(week-1,2)*transition(2,1));
        alpha(week,2)=emission(1,2)*(alpha(week-1,1)*transition(1,2)+alpha(week-1,2)*transition(2,2));
    else
        alpha(week,1)=emission(2,1)*(alpha(week-1,1)*transition(1,1)+alpha(week-1,2)*transition(2,1));
        alpha(week,2)=emission(2,2)*(alpha(week-1,1)*transition(1,2)+alpha(week-1,2)*transition(2,2));
    end
end
%% Termination
p1=alpha(numOfWeeks,1)+alpha(numOfWeeks,2);
%%% (2)BACKWARD ALGORITHM
%% Initialization
beta=zeros(numOfWeeks,2);
beta(numOfWeeks,1)=1;
beta(numOfWeeks,2)=1;
%% Iteration
for week=(numOfWeeks-1):-1:1
    if(price_move(week+1)==1)
        beta(week,1)=transition(1,1)*emission(1,1)*beta(week+1,1)+transition(1,2)*emission(1,2)*beta(week+1,2);
        beta(week,2)=transition(2,1)*emission(1,1)*beta(week+1,1)+transition(2,2)*emission(1,2)*beta(week+1,2);
    else
        beta(week,1)=transition(1,1)*emission(2,1)*beta(week+1,1)+transition(1,2)*emission(2,2)*beta(week+1,2);
        beta(week,2)=transition(2,1)*emission(2,1)*beta(week+1,1)+transition(2,2)*emission(2,2)*beta(week+1,2);
    end
end
%% Termination
p2=alpha.*beta;
%%% (3)FINAL RESULT
prob=p2/p1;