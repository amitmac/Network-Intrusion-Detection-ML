cd 'C:\Users\Amit\Desktop'
cd 'Project\Processed Data'
X = load('X-Training.txt');
y = load('y-Training.txt');
input_layer_size = size(X,2);
hidden_layer1_size = 40;
hidden_layer2_size = 40;
num_labels = 2;
m = size(X,1);
cd 'C:\Users\Amit\Desktop\Project\Neural Networks'
theta1 = randInitializeWeights(input_layer_size,hidden_layer1_size);
theta2 = randInitializeWeights(hidden_layer1_size,hidden_layer2_size);
theta3 = randInitializeWeights(hidden_layer2_size,num_labels);
initial_params = [theta1(:) ; theta2(:) ; theta3(:)];
options = optimset('MaxIter',90);
lambda = 1;
costFunction = @(p) nnCostFunction3(p,input_layer_size,hidden_layer1_size,hidden_layer2_size,num_labels,X,y,lambda);
[nn_params,min_params,cost] = fmincg(costFunction,initial_params,options);

x = hidden_layer1_size * (input_layer_size + 1);
y = (hiden_layer1_size * (hidden_layer2_size+1));

Theta1 = reshape(nn_params(1:x), ...
                 hidden_layer1_size, (input_layer_size + 1));
             
Theta2 = reshape(nn_params((1 + x):(x+y), ...
                 hidden_layer2_size, (hidden_layer1_size + 1)));
             
Theta3 = reshape(nn_params((1 + x + y):end), ...
                 num_labels, (hidden_layer2_size + 1));

%displayData(Theta1(:,2:end));
Xtest = load('C:\Users\Amit\Desktop\Project\Processed Data\X-Testing.txt');
pred = predict2(Theta1, Theta2, Theta3, Xtest);

Ytest = load('C:\Users\Amit\Desktop\Project\Processed Data\y-Testing.txt');
mean(double(pred==Ytest))*100
mean(double(pred2==Ytest))*100
