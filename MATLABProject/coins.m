% This script reads in a picture of coins and labels their values.
% The output is a sequence of 4 photos displaying how identification
% occurred. The last picture is of each coin colored separately, with
% a label indicating what type of coin it is.
% (Only reads of pictures of Nickels and Dimes)

% This reads in the coins.png file.
% This generates figure (a) in the output diagram.
coinPic = imread('coins.png');

% This finds the edges of the coins using the Canny method.
% This generates figure (b) in the output diagram.
coinEdges = edge(coinPic, 'canny');

% This binarizes the original coin picture and then fills in the holes.
% This generates figure (c) in the output diagram.
BWcoin = imbinarize(coinPic);
BWcoin2 = imfill(BWcoin, 'holes');

% This separates each 'hole' in the coin picture. Thus, each
% disjoint coin region is labeled as a separate coin.
coinsLabel = bwlabel(BWcoin2);

% This converts the labeled coin picture into a colored version, where
% each disjoint region is colored a different color.
RGB = label2rgb(coinsLabel);

% This generates the Centroids and Areas of each coin region.
stats = regionprops('table', coinsLabel, 'Centroid', 'Area');

% This makes two separate matrices. One is the xvalues of the centroids
% and one is the yvalues of the centroids.
centers = stats.Centroid;
xVals = centers(:, 1);
yVals = centers(:, 2);

% This gets the areas and then stores the largest area. This is the
% standard for the area of a nickel.
areas = stats.Area;
largestArea = max(areas);

% This stores the area of an actual nickel in dimN and an actual dime in
% dimD.
dimN = (.835/2)^2 * pi;
dimD = (.705/2)^2 * pi;

% This stores the ratio of the area of a nickel to a dime.
relND = dimN/dimD;

% This anonymous function takes in an area and returns the ratio of that
% area to the largest area.
getNewArea = @(cur) largestArea/cur;

% This is a lsit of the ratios of the areas to the largest area.
newAreas = arrayfun(getNewArea, areas);

% These are anonymous functions that return true if it the area
% corresponds to a nickel (for nickelsTest) or a dime (for dimesTest).
nickelsTest = @(area) area < (1 * 1.1);
dimesTest = @(area) (area >= relND) & (area < (relND * 1.1));

% This makes a boolean of all the areas that correspond to nickels.
% i.e. it contains a 1 for areas that are a nickel and a 0 for areas
% that are a dime.
nickelsA = arrayfun(nickelsTest, newAreas);

% This makes a boolean of all the areas that correspond to dimes.
% i.e. it contains a 1 for areas that are a dime and a 0 for areas
% that are a dime.
dimesA = arrayfun(dimesTest, newAreas);

% This prints out all of the diagrams with titles.
figure;
subplot(2, 2, 1);
imshow(coinPic);
title('(a) Original coin image');
subplot(2, 2, 2);
imshow(coinEdges);
title('(b) Edge detection, via "canny" filter');
subplot(2, 2, 3);
imshow(BWcoin2);
title('(c) Filled regions');
subplot(2, 2, 4);
imshow(RGB);
% This labels the RGB diagram with 'Nickel' for all of the xvals and
% yvals that correspond to 1 in the nickelsA matrix.
text(xVals(nickelsA), yVals(nickelsA), 'Nickel');
% This labels the RGB diagram with 'Dime' for all of the xvals and
% yvals that correspond to 1 in the dimesA matrix.
text(xVals(dimesA), yVals(dimesA), 'Dime');
title('(d) Distinguish disjoint regions')

suptitle('Figure 1. A sequential look at coin identification.');








