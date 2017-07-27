

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
% it happens that for all of these digital signals, I want to save both
% onsets and offsets of the pulses, so they will all be intervals (even the
% strobes give info about exposure duration, I think). It could have been
% otherwise though - eventSeries rather than interval could be appropriate
% for some other digital signals

analogSignals = {'photoDiode', 'rotaryEncoder', 'waveOutput', ...
    'piezoLickDetector', 'audioMonitor', 'blueLEDmonitor', 'purpleLEDmonitor'};
analogSaveNames = {[], 'wheel', [], 'lick', 'audioOutput', [],[]};

for d = 1:length(digitalSignals)
    ind = strcmp(digitalSignals{d}, inputs);
    sig = Timeline.rawDAQData(:,ind);
    
    if ~isempty(digitalSaveNames{d})
        saveName = digitalSaveNames{d};
    else
        saveName = digitalSignals{d};
    end
    
    [~, flipsUp, flipsDown] = schmittTimes(tt, sig, [1.2 3]);
    flipsUp = flipsUp(:); flipsDown = flipsDown(:); % to columns
    
    if numel(flipsUp)==0 && numel(flipsDown)==1
        flipsUp = tt(1);
    elseif numel(flipsUp)==1 && numel(flipsDown)==0
        flipsDown = tt(end);
    elseif numel(flipsUp)>0 && numel(flipsDown)>0    
        % since we're encoding these as intervals, want to make sure they are
        % all complete 
        if flipsUp(1)>flipsDown(1)
            flipsUp = [tt(1); flipsUp]; % first flip was down, now it's up
        end
        if flipsDown(end)<flipsUp(end)
            flipsDown = [flipsDown; tt(end)]; % last flip was up, now it's down
        end
    end
    assert(numel(flipsUp)==numel(flipsDown), ...
        sprintf('up and down digital event counts don''t match for %s', digitalSignals{d}));
    
    flipTimes = [flipsUp flipsDown];
    
%     [flipTimes, ii] = sort([flipsUp; flipsDown]);
%     polarity = [ones(size(flipsUp)); zeros(size(flipsDown))];
%     polarity = polarity(ii);
%     writeNPY(polarity, fullfile(destDir, [saveName '.polarity.npy']));
    writeNPY(flipTimes, fullfile(destDir, [saveName '.intervals_Timeline.npy']));
    
    if ~isempty(b) && numel(b)==2
        univUp = [flipsUp ones(size(flipsUp))]*b(:);
        univDown = [flipsDown ones(size(flipsDown))]*b(:);
        univTimes = [univUp univDown];
        writeNPY(univTimes, fullfile(destDir, [saveName '.intervals.npy']));
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
    
    sig = sig(:);
    
    writeNPY(sig, fullfile(destDir, [saveName '.raw.npy']));
    
    writeNPY(tlTimes, fullfile(destDir, [saveName '.timestamps_Timeline.npy']));
    
    if ~isempty(b) && numel(b)==2
        univTimes = [tlTimes(:,2) [1;1]]*b(:);
        univTimes = [[0;nSamps-1] univTimes];
        writeNPY(univTimes, fullfile(destDir, [saveName '.timestamps.npy']));
    end
    
end