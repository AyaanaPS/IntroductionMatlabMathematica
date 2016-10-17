% This script loads two vectors of dice data, each which contains the
% result of 10^4 rolls. It then performs a chi square test on each to
% determine which die is fair and which is not fair. The result of the
% test showed that die 1 is fair since it has a higher pvalue.
close all;clear;clc;

% This loads the dice data into Matlab.
load('DiceData.mat')

% This loads the die1Counts vector with the counts of each number in the
% die1 vector.
die1Counts = [sum(die1==1), sum(die1==2), sum(die1==3), sum(die1==4), ...
    sum(die1==5), sum(die1==6)];

% This loads the die2Counts vector with the counts of each number in the
% die2 vector.
die2Counts = [sum(die2==1), sum(die2==2), sum(die2==3), sum(die2==4), ...
    sum(die2==5), sum(die2==6)];

% Expected is the 'all fair' probability for each number.
expected = (10^4)/6;

% This series of computations gets the chi value for die1, using the
% formula (observed - expected)^2/expected. It computes the chi
% value for each number on the die and then sums them up to get
% the final chi value.

die1Chi = die1Counts - expected;
die1Chi = die1Chi.^2;
die1Chi = die1Chi/expected;
chiValue1 = sum(die1Chi);

% This series of computations gets the chi value for die2, using the
% above described mechanism.

die2Chi = die2Counts - expected;
die2Chi = die2Chi.^2;
die2Chi = die2Chi/expected;
chiValue2 = sum(die2Chi);

% This gets the pvalues for each computed chi value. This is done using
% chi2cdf, which takes in the chi value and the number of events - 1,
% which is simply 6 - 1.

pVal1 = chi2cdf(chiValue1, 5, 'upper');
pVal2 = chi2cdf(chiValue2, 5, 'upper');

% The result of running this script gives us:
%   pVal1 = 0.5019
%   pVal2 = 0
% A low pvalue means reject the null hypothesis. We use a 95% confidence
% interval, which means reject if less than 0.05. Thus, we reject
% the null hypothesis for pVal2. A high pvalue is greater than 0.05. Since
% the pVal1 is much greater than 0.05, we can say that it follows the
% normal distribution.
% Therefore, die1 is the fair one. 
