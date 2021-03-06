function [cost, grad] = softmaxCost(theta, numClasses, inputSize, lambda, data, labels)

% numClasses - the number of classes 
% inputSize - the size N of the input vector
% lambda - weight decay parameter
% data - the N x M input matrix, where each column data(:, i) corresponds to
%        a single test set
% labels - an M x 1 matrix containing the labels corresponding for the input data
%

% Unroll the parameters from theta
theta = reshape(theta, numClasses, inputSize);

numCases = size(data, 2);

groundTruth = full(sparse(labels, 1:numCases, 1));
cost = 0;

thetagrad = zeros(numClasses, inputSize);

%% ---------- YOUR CODE HERE --------------------------------------
%  Instructions: Compute the cost and gradient for softmax regression.
%                You need to compute thetagrad and cost.
%                The groundTruth matrix might come in handy.


% sizes (debug mode)---- data 8 100, theta 10 8,z and hx 10 100
m=size(data,2);
z=theta*data;
z = bsxfun(@minus, z, max(z, [], 1));
%hx= (sum(sum(exp(z-alpha)))^-1) *exp(z-alpha);
hx=exp(z);
hx = bsxfun(@rdivide, hx, sum(hx));
y=groundTruth;
const=(lambda*sum((sum(theta.^2)-theta(1).^2)))/2;
%cost=sum(sum(-y*log(hx)-(1-y)*log(1-hx)))/m +const;

for i=1:m
  cost=cost +(1-y(:,i))'*log(1-hx(:,i)) +y(:,i)'*log(hx(:,i)) ;

cost=-cost/m + const; 

thetagrad=-((y-hx)*data')/m+lambda*theta;
thetagrad(1)=thetagrad(1)-lambda*theta(1);

% ------------------------------------------------------------------
% Unroll the gradient matrices into a vector for minFunc
grad = [thetagrad(:)];
end

