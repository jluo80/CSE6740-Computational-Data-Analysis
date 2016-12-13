function [ class, mu_jc ] = mycluster( bow, K )
%
% Your goal of this assignment is implementing your own text clustering algo.
%
% Input:
%     bow: data set. Bag of words representation of text document as
%     described in the assignment.
%
%     K: the number of desired topics/clusters.
%
% Output:
%     class: the assignment of each topic. The
%     assignment should be 1, 2, 3, etc.
%
% For submission, you need to code your own implementation without using
% any existing libraries

% YOUR IMPLEMENTATION SHOULD START HERE!

num_of_documents = size(bow, 1); % nc 400
num_of_words = size(bow, 2); % nw 100
num_of_topics = K; % K 4

threshold = 10^-6; % convergence threshold
T_ij = bow; % matrix of count of words

% Random initialization
mu_jc = rand(num_of_words, num_of_topics); % 100-by-4
mu_jc = mu_jc ./ repmat(sum(mu_jc), num_of_words, 1); % Vertically stack row vector 100 times
% mu_jc_new = zeros(size(mu_jc, 1), size(mu_jc, 2));

pi_c = ones(1, num_of_topics) ./ num_of_topics; % [0.25, 0.25, 0.25, 0.25]
gamma_ic = zeros(num_of_documents, num_of_topics); % 400-by-4
iteration = 300;
it = 0;
%     % EM algorithm
    while it < iteration

        % Expectation step
        for i = 1 : num_of_documents
            gamma_ic(i, :) = pi_c .* prod(mu_jc .^ repmat(T_ij(i, :)', 1, num_of_topics), 1);
            gamma_ic(i, :) = gamma_ic(i, :) ./ sum(gamma_ic(i, :));
        end

        % Maximization step
        mu_jc = (gamma_ic' * T_ij)'; % 100-by-4 new mu_jc
        mu_jc = mu_jc ./ repmat(sum(mu_jc), num_of_words, 1);
        pi_c = 1 / num_of_documents * sum(gamma_ic);

        it = it + 1;
    end
[value, index] = max(gamma_ic, [] , 2); % The index of largest element in each matrix row denotes the cluster label.
class = index;
end

