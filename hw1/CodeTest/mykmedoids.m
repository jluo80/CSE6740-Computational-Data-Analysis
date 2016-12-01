function [ class, centroid ] = mykmedoids( pixels, K )
%
% Your goal of this assignment is implementing your own K-medoids.
% Please refer to the instructions carefully, and we encourage you to
% consult with other resources about this algorithm on the web.
%
% Input:
%     pixels: data set. Each row contains one data point. For image
%     dataset, it contains 3 columns, each column corresponding to Red,
%     Green, and Blue component.
%
%     K: the number of desired clusters. Too high value of K may result in
%     empty cluster error. Then, you need to reduce it.
%
% Output:
%     class: the class assignment of each data point in pixels. The
%     assignment should be 1, 2, 3, etc. For K = 5, for example, each cell
%     of class should be either 1, 2, 3, 4, or 5. The output should be a
%     column vector with size(pixels, 1) elements.
%
%     centroid: the location of K centroids in your result. With images,
%     each centroid corresponds to the representative color of each
%     cluster. The output should be a matrix with size(pixels, 1) rows and
%     3 columns. The range of values should be [0, 255].
%     
%
% You may run the following line, then you can see what should be done.
% For submission, you need to code your own implementation without using
% the kmeans matlab function directly. That is, you need to comment it out.

% 	[class, centroid] = kmeans(pixels, K);

%%%%%% Average
clc;
% initialization
num_of_pixels = size(pixels, 1);
num_of_clusters = K;
max_iter = 100;
it = 0;
distance = zeros(num_of_pixels, K);

% pixels-by-1 column vector
class = zeros(num_of_pixels, 1);

% K-by-3 RGB matrix
centroid = zeros(num_of_clusters, 3);
curr_centroid = zeros(num_of_clusters, 3);

% 1-by-K random selection
selected_index = randperm(num_of_pixels, num_of_clusters);

% initial centroid assignment
for i = 1 : num_of_clusters
    class(selected_index(i), 1) = i;
    centroid(i, :) = pixels(selected_index(i), :);
end

% repeat
while it <= max_iter && isequal(curr_centroid, centroid) == 0
    curr_centroid = centroid;
    % pixels-by-centroid
    % 1. Euclidean distance
    distance = pdist2(pixels, centroid, 'euclidean');
    % 2. Chebychev distance
%     distance = pdist2(pixels, centroid, 'chebychev');
    % 3. Manhattan distance
%     distance = pdist2(pixels, centroid, 'cityblock');
    for i = 1 : num_of_pixels
        [value, assigned_index] = min (distance(i, :));
        class(i, 1) = assigned_index;
    end

    % update new centroid
    for m = 1 : num_of_clusters
        sum_centroid = curr_centroid;
        avg_centroid = curr_centroid;
        count = 0;
        for j = 1 : num_of_pixels
            if class(j, 1) == m
                sum_centroid(m, :) = sum_centroid(m, :) + pixels(j, :);
                count = count + 1;
            end
        end

        avg_centroid(m, :) = sum_centroid(m, :) / count;

        cost = Inf;
        opt_medoid = selected_index(1, m);
        for o = 1 : num_of_pixels
            if class(o, 1) == m
                um = avg_centroid(m, :);
                xo = pixels(o, :);
                % 1. Euclidean distance
                temp_cost = abs((um - xo) * (um - xo)');
                % 2. Chebyshev distance
%                 temp_cost = max(abs(um - xo));
                % 3. Manhattan distance
%                 temp_cost = sum(abs(um - xo));
                if temp_cost < cost
                    cost = temp_cost;
                    opt_medoid = o;
                end
            end
        end
        selected_index(1, m) = opt_medoid;
        centroid(m, :) = pixels(opt_medoid, :);
    end
end