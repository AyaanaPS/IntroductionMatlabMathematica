% This finds the minimum time to meal using fminbnd (an optimization
% method from Week 5). It tries all the angles from 0 to 360 on the
% timeToMeal function and selects the one that results in the minimum
% value.
[xmin, fvalMin] = fminbnd(@timeToMeal, 0, 360);

% This finds the maximum time to meal using fminbnd. This time, instead
% of trying each angle on timeToMeal, it tries it on the negated 
% timeToMeal, since the negative of the max value will become the min
% value.
[xmax, fvalMax] = fminbnd(@(a) - timeToMeal(a), 0, 360);

% This prints out the results in a readable format.
fprintf('Worst angle: %f\n', xmin);
fprintf('\tTime To Death: %f\n\n', timeToMeal(xmin));
fprintf('Best angle: %f\n', xmax);
fprintf('\tTime To Death: %f\n\n', timeToMeal(xmax));