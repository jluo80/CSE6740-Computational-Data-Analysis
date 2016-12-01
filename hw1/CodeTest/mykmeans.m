function [ class, centroid ] = mykmeans( pixels, K )
%
% Your goal of this assignment is implementing your own K-means.
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
clc;
% initialization
num_of_pixels = size(pixels, 1);
num_of_clusters = K;
max_iter = 100;
it = 0;
distance = zeros(num_of_pixels, num_of_clusters);

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
    distance = pdist2(pixels, centroid, 'euclidean');
    for i = 1 : num_of_pixels
        [value, assigned_index] = min (distance(i, :));
        class(i, 1) = assigned_index;
    end

    % update new centroid
    for i = 1 : num_of_clusters
        sum_centroid = curr_centroid;
        count = 0;
        for j = 1 : num_of_pixels
            if class(j, 1) == i
                sum_centroid(i, :) = sum_centroid(i, :) + pixels(j, :);
                count = count + 1;
            end
        end
        centroid(i, :) = sum_centroid(i, :) / count;
    end
end

