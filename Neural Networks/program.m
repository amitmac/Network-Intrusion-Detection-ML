%cd 'C:\Users\Amit\Desktop\Project\Processed Data'
%X = load('X-Training.txt');
%y = load('y-Training.txt');
input_layer_size = size(X,2);
hidden_layer_size = 40;
num_labels = 1;
m = size(X,1);
cd 'C:\Users\Amit\Desktop\Project\Neural Networks'
theta1 = randInitializeWeights(input_layer_size,hidden_layer_size);
theta2 = randInitializeWeights(hidden_layer_size,num_labels);
initial_params = [theta1(:) ; theta2(:)];
options = optimset('MaxIter',10);
lambda = 0.1;
costFunction = @(p) nnCostFunction(p,input_layer_size,hidden_layer_size,num_labels,X,y,lambda);
[nn_params,min_params,cost] = fmincg(costFunction,initial_params,options);
Theta1 = reshape(nn_params(1:hidden_layer_size * (input_layer_size + 1)), ...
hidden_layer_size, (input_layer_size + 1));
Theta2 = reshape(nn_params((1 + (hidden_layer_size * (input_layer_size + 1))):end), ...
num_labels, (hidden_layer_size + 1));

Theta11 = reshape(min_params(1:hidden_layer_size * (input_layer_size + 1)), ...
hidden_layer_size, (input_layer_size + 1));
Theta21 = reshape(min_params((1 + (hidden_layer_size * (input_layer_size + 1))):end), ...
num_labels, (hidden_layer_size + 1));

%displayData(Theta1(:,2:end));
Xtest = load('C:\Users\Amit\Desktop\Project\Processed Data\X-Testing.txt');
pred = predict(Theta1, Theta2, Xtest);
pred2 = predict(Theta11, Theta21, Xtest);

Ytest = load('C:\Users\Amit\Desktop\Project\Processed Data\y-Testing.txt');
mean(double(pred==Ytest))*100
mean(double(pred2==Ytest))*100
