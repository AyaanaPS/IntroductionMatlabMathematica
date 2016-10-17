% This fills two column vectors (with 10^5 positions each), with random
% numbers between 0 and 1. Each row of the first vector (breakpoints1)
% represents one of the breakpoints for an event. Each row of the second
% vector (breakpoints2) represents the other breakpoint for an event.
breakpoints1 = rand(10^5, 1);
breakpoints2 = rand(10^5, 1);

% Greater is filled with the larger breakpoint in each row.
greater = max(breakpoints1, breakpoints2);
% Smaller is filled with the smaller breakpoint in each row.
smaller = min(breakpoints1, breakpoints2);

% This generates each number from 1 to 10^5, allowing us to iterate
% through the greater and smaller vector without a for loop.
pos = 1:1:(10^5);

% The following computes the length of each segment of the split.
seg1 = 1 - greater(pos);
seg2 = greater(pos) - smaller(pos);
seg3 = smaller(pos);

% The following are three generated boolean matrices that are constructed
% using the triangle inequality.
boolM1 = (seg1 < (seg2 + seg3));
boolM2 = (seg2 < (seg1 + seg3));
boolM3 = (seg3 < (seg1 + seg2));

% The final result is the sum of each of the boolean matrices.
result = boolM1 + boolM2 + boolM3;

% The number of threes is the number of times the triangle inequality
% holds true for each of the 10^5 cases.
numberOfThrees = sum(result==3);

% Thus, the final probability is the number of threes divided by 10^5.
% This results in a value around 0.25 (of course, we don't get the
% same value each time).
finalProb = numberOfThrees/(10^5);





