
function allPos = standardBrainCoords()

lrPos = [repmat(-3.5:3.5, 1, 5) -2.5:2.5 -1.5:1.5 -0.5 0.5];
apPos = [zeros(1,8)-4 zeros(1,8)-3 zeros(1,8)-2 ...
    zeros(1,8)-1 zeros(1,8) ones(1,6) ...
    zeros(1,4)+2 zeros(1,2)+3];

allPos = [lrPos; apPos];