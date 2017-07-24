

function kilotrodeTimelineToAFF(Timeline, b, destDir)
% function kilotrodeTimelineToAFF(Timeline, b, destDir)
% 
% Like alyxIO.TimelineToAFF but with special cases for kilotrode rig stuff

% Inputs:
% - Timeline, a timeline structure
% - b, a 2-element conversion vector to universal timebase, optional
% - destDir, a place to put the results

if ~exist('writeNPY')
    error('writeNPY not found; cannot proceed saving Timeline to ALF');
end

% Save hw json
if exist('savejson')
    savejson('hw', Timeline.hw, fullfile(destDir, 'TimelineHW.json'));
else
    warning('Jsonlab not found - hardware information not saved to ALF')
end

inputs = {Timeline.hw.inputs.name};
tt = Timeline.rawDAQTimestamps;

digitalSignals = {'eyeCameraStrobe', 'camSync', 'rewardEcho', ...
    'faceCamStrobe', 'pcoExposure', 'acqLive'};
digitalSaveNames = {[],[],'rewards',[],[],[]};

analogSignals = {'photoDiode', 'rotaryEncoder', 'waveOutput', ...
    'piezoLickDetector', 'audioMonitor', 'blueLEDmonitor', 'purpleLEDmonitor'};
analogSaveNames = {[], 'wheel', [], 'lickRaw', 'audioOutput', [],[]};

for d = 1:length(digitalSignals)
    ind = strcmp(digitalSignals{d}, inputs);
    sig = Timeline.rawDAQData(:,ind);
    
    if ~isempty(digitalSaveNames{d})
        saveName = digitalSaveNames{d};
    else
        saveName = digitalSignals{d};
    end
    
    [~, flipsUp, flipsDown] = schmittTimes(tt, sig, [1.2 3]);
    [flipTimes, ii] = sort([flipsUp; flipsDown]);
    polarity = [ones(size(flipsUp)); zeros(size(flipsDown))];
    polarity = polarity(ii);
    writeNPY(flipTimes, fullfile(destDir, [saveName '.times_Timeline.npy']));
    writeNPY(polarity, fullfile(destDir, [saveName '.polarity.npy']));
    
    if ~isempty(b) && numel(b)==2
        univTimes = [flipTimes ones(size(flipTimes))]*b(:);
        writeNPY(univTimes, fullfile(destDir, [saveName '.times.npy']));
    end
    
end

nSamps = Timeline.rawDAQSampleCount;
tlTimes = [0 Timeline.rawDAQTimestamps(1); nSamps-1 Timeline.rawDAQTimestamps(end)];
for a = 1:length(analogSignals)
    ind = strcmp(analogSignals{a}, inputs);
    sig = Timeline.rawDAQData(:,ind);
    
    if ~isempty(analogSaveNames{a})
        saveName = analogSaveNames{a};
    else
        saveName = analogSignals{a};
    end
    
    switch saveName
        case 'wheel'
            if exist(which('wheel.correctCounterDiscont'))
                sig = wheel.correctCounterDiscont(sig);
            else
                warning('could not find wheel.correctCounterDiscont; wheel uncorrected');
            end
    end
    
    writeNPY(sig, fullfile(destDir, [saveName '.npy']));
    
    writeNPY(tlTimes, fullfile(destDir, [saveName '.timestamps_Timeline.npy']));
    
    if ~isempty(b) && numel(b)==2
        univTimes = [tlTimes(:,2) [1;1]]*b(:);
        writeNPY(univTimes, fullfile(destDir, [saveName '.timestamps.npy']));
    end
    
end