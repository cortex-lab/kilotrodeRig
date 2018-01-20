
function allPos = expandedBrainCoords()

lrPos = [repmat(-4.5:4.5, 1, 5) repmat(-3.5:3.5, 1, 2) -2.5:2.5 -1.5:1.5];
apPos = [zeros(1,10)-4.5 zeros(1,10)-3.5 zeros(1,10)-2.5 ...
    zeros(1,10)-1.5 zeros(1,10)-0.5 zeros(1,8)+0.5 zeros(1,8)+1.5 ...
    zeros(1,6)+2.5 zeros(1,4)+3.5];

allPos = [lrPos; apPos];