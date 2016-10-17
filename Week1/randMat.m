function result = randMat(n)
%randMat: Takes an integer input and outputs a random, symmetric, 
%   positive definite, dense n x n matrix 

% This generates a matrix of random numbers between -1 and 1.
A = -1 + 2 * rand(n);

% In the following, A.' is the transpose of matrix A and eye(n)
% is the nxn identity matrix.
result = (A.')*A + eye(n);

end

