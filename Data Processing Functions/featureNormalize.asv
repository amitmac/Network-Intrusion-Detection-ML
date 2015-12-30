function [X_norm, mu, sigma] = featureNormalize(X)

    X_norm = X;
    mu = zeros(1, size(X, 2));
    sigma = zeros(1, size(X, 2));
  
    mu = mean (X);
    for i=1:size(X, 2)
        X(:,i) = X(:,i) - mu(i);
    end;

    sigma = std (X);

    for i=1:size(X, 2)     
        X(:,i) = X(:,i) ./ sigma(i);
    end;
    X_norm = X;

end
