

%% initialize
adaptorVendor = 'ni';
galvoDeviceID = 'Dev1';
xChID = 'ao0';
yChID = 'ao1';
s = daq.createSession(adaptorVendor);
mirrorXChannel = s.addAnalogOutputChannel(galvoDeviceID, xChID, 'Voltage');
mirrorYChannel = s.addAnalogOutputChannel(galvoDeviceID, yChID, 'Voltage');
sampleRate = s.Rate; % maybe try lower?


%% test square

gridSize = 2; % units?
holdTime = 0.0001; % sec, at each corner

nSamp = holdTime*sampleRate;

a = repmat(gridSize*[-1 -1 1 1]'/2, 1, nSamp);
a = reshape(a', nSamp*4, 1);
b = repmat(gridSize*[-1 1 1 -1]'/2, 1, nSamp);
b = reshape(b', nSamp*4, 1);

for n = 1:100
    s.queueOutputData([a b]); s.startForeground;
end


%% test brain coordinate pattern

mmPerVolt = 3.6;
gridSize = 1; % mm
parkPosition = [-10 -10];
holdTime = 0.0001; % sec, at each corner

nSamp = holdTime*sampleRate;

coords = expandedBrainCoords()';
a = repmat(gridSize*coords(:,1)', 1, nSamp);
a = reshape(a', nSamp*numel(coords(:,1)), 1);
b = repmat(gridSize*coords(:,2)', 1, nSamp);
b = reshape(b', nSamp*numel(coords(:,2)), 1);

for n = 1:100
    s.queueOutputData([a -b; parkPosition]/mmPerVolt); s.startForeground;
end