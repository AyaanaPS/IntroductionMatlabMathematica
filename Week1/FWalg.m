function result = FWalg (A)
%FWalg: This function implements the Floyd-Warshall Algorithm.
%   It takes an adjacency matrix A, representing the network G.
%   It outputs the matrix D, which is a matrix of the shortest path
%       between the nodes of G.

% The original/inputted matrix is just the matrix of
% distances between nodes in the graph. In other words
% the value at the location (i, j) in the matrix is the 
% distance between the i and j nodes in the graph.
% A distance of 0 means that the two nodes (i, j) are equal.
% A distance of infinity means that there is no edge directly
% connecting the two edges.
% Any other distance is the weight of the edge connecting the
% two nodes.
original = A;

% This ensures that the inputted matrix is square. If not,
% an error is thrown.
[n,m] = size(original);
if(n ~= m)
    % If the matrix is not a square then an error is thrown.
    error('Input matrix must be square');
end

% This iterates through the range of the size of the matrix.
% k represents the row/column currently being looked at.
% For example, a current value of k = 2 means we are going to
% focus on the 2nd column and 2nd row.
for k=1:n
    % This generates a matrix of the kth column repeated n times.
    % So that it is the same size as the original matrix.
    split1 = repmat(original(:,k), 1, n);
    % This generates a matrix of the kth row repeated n times.
    split2 = repmat(original(k,:), n, 1);
    % This compares every element of the original and the sum
    % of the above two created matrixes, and makes a new matrix
    % that stores the smaller of the elements at each location.
    % What this does is see if the path of i to k to j is smaller
    % than the current path from i to j. If it is, the value at 
    % the (i, j) location in the matrix is replaced with the smaller
    % path distance.
    original = min(original, (split1 + split2));
end

% This returns the final matrix that contains the smallest path distance
% for every (i, j) node pair.
result = original;
    
end


