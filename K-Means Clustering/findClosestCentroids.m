function idx = findClosestCentroids(X, centroids)

K = size(centroids, 1);

idx = zeros(size(X,1), 1);

m = length(X);
for i=1:m
    minC = Inf;
    for j=1:K
        dist = norm(X(i,:)- centroids(j,:))^2;
        if dist < minC
            minC = dist;
            idx(i)=j;
        end
    end
end

% =============================================================

end

