function centroids = computeCentroids(X, idx, K)

    [m n] = size(X);
    centroids = zeros(K, n);

    for i=1:K
        centroids(i,:) = mean(X(find(idx==i),:));
    end

end

