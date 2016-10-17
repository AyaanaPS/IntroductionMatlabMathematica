% This is an example of the use of the Laplace Operator
% Running this script generates the plots of u and du corresponding
% to the desired function:
% % u(x, y) = cosh(2*pi*x)*cos(6*pi*y) if x and y are within [1/4, 3/4]
% Else, u(x, y) = 9

% The following are the inputs to be passed into the discreteLaplace
% function
nx = 20; % number of grid points in the x direction
ny = 30; % number of grid points in the y direction
hx = 1/(nx - 1); % the grid spacing in the x direction
hy = 1/(ny - 1); % the grid spacing in the y direction

% This initializes a column vector that has 600 rows.
u = zeros(30*20, 1);

% This specifies where in our u vector we are changing the
% value. This will be incremented in the below for loop.
counter = 1;

% This for loop fills the u vector using the given function
for x = 0:hx:1
    for y = 0:hy:1
        % This checks to see if the x and y values are within the bounds.
        if(x >= 0.25 && x <= 0.75 && y >= 0.25 && y <= 0.75)
            % If they are within the bounds, it updates the value of u
            % at the counter index with the result of the function called
            % on the x and y values.
            u(counter) = cosh(2*pi*x)*cos(6*pi*y);
        end
        % This increments the counter variable.
        counter = counter + 1;
    end
end

% This generates the delta_u vector (the approximation)
% by creating the laplace operator using
% the discreteLaplace function, and multiplying it by the u vector created
% above.
du = discreteLaplace(ny, nx, hy, hx) * u;

% This reshapes u and du so that they are the same size.
u = reshape(u, [ny, nx]);
du = reshape(du, [ny, nx]);

figure;
% This generates a list of the X and Y values to be considered.
X = 0:hx:1;
Y = 0:hy:1;

% This plots the first graph (the graph of u) on the left of the screen.
subplot(1, 2, 1);
[Xu, Yu] = meshgrid(X, Y);
% This plots the function u with the values in Xu and Yu
surf(Xu, Yu, u);

% This plots the second graph (the graph of du) on the right of the screen.
subplot(1, 2, 2);
[Xdu, Ydu] = meshgrid(X, Y);
% This plots the function du with the values in Xu and Yu
surf(Xdu, Ydu, du);


