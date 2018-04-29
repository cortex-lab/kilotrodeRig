
% script for a laser calibration test

%% open device

s = daq.createSession('ni');
ch = s.addAnalogOutputChannel('Dev2', 'ao0', 'Voltage');
s.queueOutputData(0); s.startForeground;

%% test 1: steps for 1 sec 

stepDur = 0.5; 
stepSamps = round(stepDur*s.Rate);

stepVals = 0:0.01:1;

outV = reshape(repmat(stepVals, stepSamps, 1), stepSamps*numel(stepVals),1);

nReps = 10;

outV = repmat(outV, nReps,1);

outV = [outV; 0];

%% run test

s.queueOutputData(outV); s.startForeground;

%% test 2: raised cosines of different amplitudes

stepVals = 0:0.01:0.5;
cosFreq = 5; % Hz
nSamps = round(s.Rate/cosFreq);

baseWave = 1/2-cos(linspace(0, 2*pi, nSamps))/2;

outV = reshape(baseWave'*stepVals, nSamps*numel(stepVals), 1);

nReps = 1;

outV = repmat(outV, nReps,1);


outV = outV+0.125;

outV = [outV; 0];


%% run test

s.queueOutputData(outV); s.startForeground;

