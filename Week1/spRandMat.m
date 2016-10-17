function result = spRandMat( n )
%spRandMat: Takes an integer input and produces a random, symmetric,
%   positive definite, sparse n x n matrix

% This generates a sparse nxn matrix with a density of 0.05
A = sprand(n, n, 0.05);

% In the following, A.' is the transpose of matrix A and speye(n)
% is the sparse nxn identity matrix.
result = (A.')*A + speye(n);

end

