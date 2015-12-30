function [J grad] = nnCostFunction(nn_params, ...
                                   input_layer_size, ...
                                   hidden_layer1_size, ...
                                   hidden_layer2_size, ...
                                   num_labels, ...
                                   X, y, lambda)
%NNCOSTFUNCTION Implements the neural network cost function for a two layer
%neural network which performs classification
%   [J grad] = NNCOSTFUNCTON(nn_params, hidden_layer_size, num_labels, ...
%   X, y, lambda) computes the cost and gradient of the neural network. The
%   parameters for the neural network are "unrolled" into the vector
%   nn_params and need to be converted back into the weight matrices. 
% 
%   The returned parameter grad should be a "unrolled" vector of the
%   partial derivatives of the neural network.
%

% Reshape nn_params back into the parameters Theta1 and Theta2, the weight matrices
% for our 2 layer neural network
x = hidden_layer1_size * (input_layer_size + 1);
y = (hidden_layer1_size * (hidden_layer2_size+1));

Theta1 = reshape(nn_params(1:x), ...
                 hidden_layer1_size, (input_layer_size + 1));
             
Theta2 = reshape(nn_params((1 + x):(x+y)), ...
                 hidden_layer2_size, (hidden_layer1_size + 1));
             
Theta3 = reshape(nn_params((1 + x + y):end), ...
                 num_labels, (hidden_layer2_size + 1));

% Setup some useful variables
m = size(X, 1);
         
% You need to return the following variables correctly 
J = 0;
Theta1_grad = zeros(size(Theta1));
Theta2_grad = zeros(size(Theta2));
Theta3_grad = zeros(size(Theta3));

% ====================== YOUR CODE HERE ======================
% Instructions: You should complete the code by working through the
%               following parts.
%
% Part 1: Feedforward the neural network and return the cost in the
%         variable J. After implementing Part 1, you can verify that your
%         cost function computation is correct by verifying the cost
%         computed in ex4.m
%
% Part 2: Implement the backpropagation algorithm to compute the gradients
%         Theta1_grad and Theta2_grad. You should return the partial derivatives of
%         the cost function with respect to Theta1 and Theta2 in Theta1_grad and
%         Theta2_grad, respectively. After implementing Part 2, you can check
%         that your implementation is correct by running checkNNGradients
%
%         Note: The vector y passed into the function is a vector of labels
%               containing values from 1..K. You need to map this vector into a 
%               binary vector of 1's and 0's to be used with the neural network
%               cost function.
%
%         Hint: We recommend implementing backpropagation using a for-loop
%               over the training examples if you are implementing it for the 
%               first time.
%
% Part 3: Implement regularization with the cost function and gradients.
%
%         Hint: You can implement this around the code for
%               backpropagation. That is, you can compute the gradients for
%               the regularization separately and then add them to Theta1_grad
%               and Theta2_grad from Part 2.
%

a1 = [ones(m,1) X]; % add 1
z2 = sigmoid(a1 * Theta1');
a2 = [ones(size(z2, 1), 1) z2]; % add 1
z3 = sigmoid(a2 * Theta2');
a3 = [ones(size(z3, 1), 1) z3];; % H_theta(x)
z4 = a3 * Theta3';
h = sigmoid(z4);

%yVec = repmat([1:num_labels], m, 1) == repmat(y, 1, num_labels);
yVec = y;
cost = -yVec .* log(h) - (1 - yVec) .* log(1 - h);
%J = (1 / m) * sum(sum(cost));

%Theta1ExcludingBias = Theta1(:, 2:size(Theta1, 2));
%Theta2ExcludingBias = Theta2(:, 2:size(Theta2, 2));
Theta1ExcludingBias = Theta1(:, 2:end);
Theta2ExcludingBias = Theta2(:, 2:end);
Theta3ExcludingBias = Theta3(:, 2:end);
J = (1 / m) * sum(sum(cost)) + ...
    (lambda / (2 * m)) * (sum(sum(Theta1ExcludingBias .^ 2)) + ...
    sum(sum(Theta2ExcludingBias .^ 2)) + sum(sum(Theta3ExcludingBias .^ 2)));

delta1 = zeros(size(Theta1));
delta2 = zeros(size(Theta2));
delta3 = zeros(size(Theta3));

for t = 1:m,
    a1t = a1(t,:)';
    a2t = a2(t,:)';
    a3t = a3(t,:)';
    ht = h(t,:)';
    yVec = yVec(t,:)';

    delta_4 = h - yVec;
    
    delta_3 = (Theta3' * delta_4) .* [1; sigmoidGradient(z3)];
    delta_3 = delta_3(2:end);
	
    delta_2 = (Theta2' * delta_3) .* [1; sigmoidGradient(z2)];
	delta_2 = delta_2(2:end);
    
    Theta1_grad = Theta1_grad + delta_2 * a1';
	Theta2_grad = Theta2_grad + delta_3 * a2';
    Theta3_grad = Theta3_grad + delta_4 * a3';
    %delta1 = delta1 + d2t(2:end) * a1t';
    %delta2 = delta2 + d3t * a2t';
end;

%Theta1_grad = (1 / m) * delta1;
%Theta2_grad = (1 / m) * delta2;

%Theta1ZeroedBias = [ zeros(size(Theta1, 1), 1) Theta1ExcludingBias ];
%Theta2ZeroedBias = [ zeros(size(Theta2, 1), 1) Theta2ExcludingBias ];
%Theta1_grad = (1 / m) * delta1 + (lambda / m) * Theta1ZeroedBias;
%Theta2_grad = (1 / m) * delta2 + (lambda / m) * Theta2ZeroedBias;
Theta1_grad = (1/m) * Theta1_grad + (lambda/m) * [zeros(size(Theta1, 1), 1) Theta1(:,2:end)];
Theta2_grad = (1/m) * Theta2_grad + (lambda/m) * [zeros(size(Theta2, 1), 1) Theta2(:,2:end)];
Theta3_grad = (1/m) * Theta3_grad + (lambda/m) * [zeros(size(Theta3, 1), 1) Theta3(:,2:end)];


% -------------------------------------------------------------

% =========================================================================

% Unroll gradients
grad = [Theta1_grad(:) ; Theta2_grad(:) ; Theta3_grad(:)];


end