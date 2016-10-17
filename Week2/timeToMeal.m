function tDevour = timeToMeal(angle)
%timeToMeal This function calculates the amount of time until one of the
%   raptors comes within 0.1 metres of you (guaranteed death). This
%   function models the movement of each raptor given their initial speed.
%   The function takes in the angle indicating the direction of your
%   movement. It then returns the time until you are eaten.
%
% Running this function with an input of 30 gives us a tDevour = 0.4265.

% This initializes the variables needed for the computation.

% The angle is inputted in degrees and must be converted to radians.
angleRad = deg2rad(angle);

% This is the length of each side of the equilateral triangle.
d = 20;

% This is your initial speed.
vh = 6;

% This is the value that helps describe the raptors initial position.
a = d * (sqrt(3))/6;

% The following vector represets each raptor's initial position.
r1 = [-10 -a];
r2 = [10 -a];
r3 = [0 2*a];

% The following represents each raptor's speed.
v1 = 25;
v2 = 25;
v3 = 20;

% TThis anonymous function represents your position at time t.
h = @(t) (vh * t);

% This is the span of time that we will consider.
tspan = [0 1];

% This anonymous function calculates the norm of h(t) and r(2).
normCalc = @(t, r) sqrt((r(1) - h(t)*cos(angleRad))^2 + ...
    (r(2) - h(t)*sin(angleRad))^2); 

% This is the events function for odefun. It stops the calculation
% once the norm = 0.1.
    function [position, isterminal, direction] = myEventsfnc(t, r)
        position = normCalc(t, r) - 0.1;
        isterminal = 1;
        direction = 0;
    end

% This sets the options input to ode45 to include the events function.
options = odeset('Events', @myEventsfnc);

% This defines the ode that will be passed into ode45. The function is
% dr/dt = (h(t) - r(t))/norm of h(t) and r(t).
odefun = @(t, r) [((h(t)*cos(angleRad) - r(1))/normCalc(t, r)); ...
    ((h(t)*sin(angleRad) - r(2))/normCalc(t, r))] ;

% This defines the ode45 solve for each of the three raptors. 
% Each te represents the time to event for each raptor.
[t1, y1, te1, x1] = ode45(@(t1,y1) v1 * odefun(t1,y1), tspan, r1, options);
[t2, y2, te2, x2] = ode45(@(t2,y2) v2 * odefun(t2,y2), tspan, r2, options);
[t3, y3, te3, x3] = ode45(@(t3,y3) v3 * odefun(t3,y3), tspan, r3, options);

% Thus, this calculates the time until you are devoured by finding the
% minimum time to event from each raptor.
tDevour = min([te1, te2, te3]);

end

