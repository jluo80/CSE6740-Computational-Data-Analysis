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