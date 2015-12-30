function p = predict(Theta1, Theta2, Theta3, X)

m = size(X, 1);
num_labels = size(Theta3, 1);

% You need to return the following variables correctly 
p = zeros(size(X, 1), 1);


a1 = X; % add 1
z2 = sigmoid(a1 * Theta1');
a2 = [ones(size(z2, 1), 1) z2]; % add 1
z3 = sigmoid(a2 * Theta2');
a3 = [ones(size(z3, 1), 1) z3];; % H_theta(x)
z4 = a3 * Theta3';
a4 = sigmoid(z4);


%h1 = sigmoid(X * Theta1');
%h2 = sigmoid([ones(m, 1) h1] * Theta2');

%z3 = sigmoid(a2 * Theta2');
%a3 = [ones(size(z3, 1), 1) z3];; % H_theta(x)
%h3 = sigmoid([ones(sigmoid(h2))]);

[dummy, p] = max(a4, [], 2);

% =========================================================================


end
