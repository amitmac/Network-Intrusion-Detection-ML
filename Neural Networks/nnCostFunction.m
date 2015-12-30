function [J grad] = nnCostFunction(nn_params, ...
                                   input_layer_size, ...
                                   hidden_layer_size, ...
                                   num_labels, ...
                                   X, y, lambda)
                               
Theta1 = reshape(nn_params(1:hidden_layer_size * (input_layer_size + 1)), ...
                 hidden_layer_size, (input_layer_size + 1));

Theta2 = reshape(nn_params((1 + (hidden_layer_size * (input_layer_size + 1))):end), ...
                 num_labels, (hidden_layer_size + 1));

m = size(X, 1);
         
J = 0;
Theta1_grad = zeros(size(Theta1));
Theta2_grad = zeros(size(Theta2));

a1 = [ones(m, 1) X];
a2 = [ones(m, 1) sigmoid(a1 * Theta1')];
h = sigmoid(a2 * Theta2');
yVec = repmat([1:num_labels], m, 1) == repmat(y, 1, num_labels);
cost = -yVec .* log(h) - (1 - yVec) .* log(1 - h);

Theta1ExcludingBias = Theta1(:, 2:end);
Theta2ExcludingBias = Theta2(:, 2:end);
J = (1 / m) * sum(sum(cost)) + ...
    (lambda / (2 * m)) * (sum(sum(Theta1ExcludingBias .^ 2)) + ...
    sum(sum(Theta2ExcludingBias .^ 2)));

delta1 = zeros(size(Theta1));
delta2 = zeros(size(Theta2));

for t = 1:m,
    a1t = a1(t,:)';
    a2t = a2(t,:)';
    ht = h(t,:)';
    yVecT = yVec(t,:)';

    d3t = ht - yVecT;

    z2t = [1; Theta1 * a1t];
    d2t = Theta2' * d3t .* sigmoidGradient(z2t);

    delta1 = delta1 + d2t(2:end) * a1t';
    delta2 = delta2 + d3t * a2t';
end;

%Theta1_grad = (1 / m) * delta1;
%Theta2_grad = (1 / m) * delta2;

Theta1ZeroedBias = [ zeros(size(Theta1, 1), 1) Theta1ExcludingBias ];
Theta2ZeroedBias = [ zeros(size(Theta2, 1), 1) Theta2ExcludingBias ];
Theta1_grad = (1 / m) * delta1 + (lambda / m) * Theta1ZeroedBias;
Theta2_grad = (1 / m) * delta2 + (lambda / m) * Theta2ZeroedBias;

grad = [Theta1_grad(:) ; Theta2_grad(:)];

end
