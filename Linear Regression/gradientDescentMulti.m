function [theta,J_history] = gradientDescentMulti(X, y, theta, alpha, num_iters)

m = length(y); 
J_history = zeros(num_iters, 1);

n = size(X, 2);

for iter = 1:num_iters

    grad = 1/(2*m) * 2 * (X'*X*theta - X'*y);
    theta = theta - (alpha / m) * (X' * (X * theta - y));

    derivate = (X * theta - y) .^ 2;
    J_history(iter) = computeCostMulti(X,y,theta);
end

end