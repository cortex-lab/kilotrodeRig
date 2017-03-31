

% Given that you ran alignAll and got all the alignments worked out, this
% will go through and extract basic event times. 

addpath(genpath('C:\Users\Nick\Documents\GitHub\Rigbox'))
%% 
clear all
mouseName = 'Radnitz';
thisDate = '2017-01-08';

rootE = dat.expPath(mouseName, thisDate, 1, 'main', 'master');
root = fileparts(rootE);

alignDir = fullfile(root, 'alignments');

eventsDir = fullfile(root, 'eventTimes');
if ~exist(eventsDir, 'dir'); mkdir(eventsDir); end;


%%

[expNums, blocks, hasBlock, pars, isMpep, tl, hasTimeline] = ...
    dat.whichExpNums(mouseName, thisDate);

%%

[tags, hasEphys] = getEphysTags(mouseName, thisDate);
master = tags{1};
masterName = sprintf('ephys_%s', master);

%% set manually which ones to convert to the master timebase
blockNums = [3:5];
tlNums = 2;


%% 

for b = 1:length(blockNums)
    bNum = blockNums(b);
    
    block = blocks{bNum};
    
    if strcmp(block.expType, 'ChoiceWorld')
        
        
    end
end


%% 

for t = 1:length(tlNums)
    tlNum = tlNums(t);
    
    Timeline = tl{tlNum};
    
    [beepsTL, whiteNoiseTL, valveClicksTL] = extractTimelineSignals(Timeline);

    % convert to master
    bfilename = sprintf('correct_timeline_%d_to_ephys_%s.npy', tlNum, tags{1});
    bTLtoMaster = readNPY(fullfile(alignDir, bfilename));
    beeps = applyCorrection(beepsTL, bTLtoMaster);
    whiteNoise = applyCorrection(whiteNoiseTL, bTLtoMaster);
    valveClicks = applyCorrection(valveClicksTL, bTLtoMaster);
    
    et.beeps = beeps; et.whiteNoise = whiteNoise; et.valveClicks = valveClicks;
    % save to files
    alyxIO.writeEventSeries(fullfile(eventsDir, 'timelineEvents'), masterName, et);
    
end