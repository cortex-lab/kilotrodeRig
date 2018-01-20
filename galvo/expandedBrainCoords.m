
function allPos = expandedBrainCoords()

% Version 1: covers the brain pretty much perfectly, but shifts the AP
% coords to be offset by 0.5mm relative to the standard map. So the
% standard map is not a subset of this. 
% lrPos = [repmat(-4.5:4.5, 1, 5) repmat(-3.5:3.5, 1, 2) -2.5:2.5 -1.5:1.5];
% apPos = [zeros(1,10)-4.5 zeros(1,10)-3.5 zeros(1,10)-2.5 ...
%     zeros(1,10)-1.5 zeros(1,10)-0.5 zeros(1,8)+0.5 zeros(1,8)+1.5 ...
%     zeros(1,6)+2.5 zeros(1,4)+3.5];

% Version 2: doing as well as possible without moving the standard map. 
lrPos = [repmat(-4.5:4.5, 1, 4) repmat(-3.5:3.5, 1, 2) -2.5:2.5 -1.5:1.5];
apPos = [zeros(1,10)-4 zeros(1,10)-3 zeros(1,10)-2 ...
    zeros(1,10)-1 zeros(1,8) ones(1,8) ...
    zeros(1,6)+2 zeros(1,4)+3];

allPos = [lrPos; apPos];