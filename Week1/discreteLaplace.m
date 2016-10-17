function L = discreteLaplace(ny, nx, hy, hx)
%discreteLaplace This takes in the following:
%   ny = the number of grid points in the y direction
%   nx = the number of grid points in the x direction
%   hy = the grid spacing in the y direction
%   hx = the grid spacing in the x direction
%   and outputs L, which is the sparse, banded, nxny x nxny matrix
%   corresponding to the approximation to the Laplace operator.
%   This approximation is delta_u = L*u, where u is a regular grid
%   corresponding function and delta_u is equal to:
%   (u(i,j-1)-2u(i,j)+u(i,j+1))/(hx^2)+(u(i-1,j)-2u(i,j)+u(i+1,j)/(hy^2)

% This initializes a matrix of 0's that has 5 columns and nx * ny rows.
B = zeros(nx * ny, 5);

% This initializes the entire first column to be composed of 1/(hx)^2
% This is the coefficient for u(i, j-1)
B(:, 1) = 1/(hx)^2;

% This initializes the entire second column to be composed of 1/(hy)^2
% This is the coefficient for u(i-1, j)
B(:, 2) = 1/(hy)^2;

% This initializes the entire third column to be composed of 
% ((-2)/(hx)^2) + ((-2)/(hy)^2)
% This is the coefficient for u(i, j)
B(:, 3) = ((-2)/(hx)^2) + ((-2)/(hy)^2);

% This initializes the entire fourth column to be composed of 1/(hy)^2
% This is the coefficient for u(i+1, j)
B(:, 4) = 1/(hy)^2;

% This initializes the entire fifth column to be composed of 1/(hx)^2
% This is the coefficient for u(i, j+1)
B(:, 5) = 1/(hx)^2;

% This specifies the indices of nonzero diagonals.
d = [-ny, -1, 0, 1, ny];

% L, the laplace operator, is the result of running spdiags (which 
% extracts and creats sparse band and diagonal matrices, on our
% generated matrix of the coefficients.
L = spdiags(B, d, (nx*ny), (nx*ny));

end

