function [centroids, idx] = runkMeans(X, initial_centroids, ...
                                      max_iters)

    % Initialize values
    m = size(X,1);
    K = size(initial_centroids, 1);
    centroids = initial_centroids;
    idx = zeros(m, 1);

    % Run K-Means
    for i=1:max_iters
    
        % find closest centroid
        idx = findClosestCentroids(X, centroids);
        % compute new centroids
        centroids = computeCentroids(X, idx, K);
    end

end

