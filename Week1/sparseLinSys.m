% This shows that the time required to solve a sparse linear system varies 
% with the order of a matrix. The linear system being solved is
% Sx = b, where S is the output of the spRandMat function on a size and
% b is the output of the rand function on the same size.

% Executes close all, clear and clc
close all; clear; clc;

% This defines the list of sizes to work with
n = [10, 100, 1000, 2000];

% This loops through all the positions in the size array defined above (n)
for i=1:length(n)
    % S is the output of the spRandMat function called on the ith size in
    % the list n.
    S = spRandMat(n(i));
    % b is a matrix of random integers on the unit interval.
    b = rand(n(i));
    
    % The following computes the result of b/S and uses tic toc to measure
    % how long this computation takes.
    tic;
    x = b/S;
    timerVal = toc;
    
    % This outputs the time for each size.
    fprintf('For n = %d, time taken: %d\n', n(i), timerVal);
end