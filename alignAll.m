

% alignment script for kilotrode rig
% want to get alignments between timeline and any blocks
% (choiceworld/signals), Protocols (mpep), and ephys files that we can
% find. 
%
% Big picture on the alignment is: one of the ephys FPGAs is the "master"
% (the first one, probably alphabetically). The other FPGAs get corrected
% to that, and timeline gets corrected to that. Others (blocks) get corrected
% to Timeline, so that part is generic to the case when there's no ephys

%% 
mouseName = 'Radnitz';
thisDate = '2017-01-09';

rootE = dat.expPath(mouseName, thisDate, 1, 'main', 'master');
root = fileparts(rootE);

alignDir = fullfile(root, 'alignments');
if ~exist(alignDir, 'dir'); mkdir(alignDir); end;

%% determine whether there is ephys and if so what tags
d = dir(fullfile(root, 'ephys*'));

clear tags
if numel(d)==1 && strcmp(d.name, 'ephys')
    tags = {[]};
    hasEphys = true;
elseif numel(d)>1
    for q = 1:numel(d)
        tags{q} = d(q).name(7:end);
    end
    hasEphys = true;
else
    hasEphys = false;
end


%% for any ephys, load the sync data

if hasEphys
    for t = 1:length(tags)
        if isempty(tags{t})
            [~, detectedFlips] = loadSync(mouseName, thisDate);
        else
            [~, detectedFlips] = loadSync(mouseName, thisDate, tags{t});
        end
        ephysFlips{t} = detectedFlips;
    end
end
    
%% synchronize multiple ephys to each other

if hasEphys
    if length(tags)>1
        for t2 = 2:length(tags)
            fprintf(1, 'correct ephys %s to %s\n', tags{t2}, tags{1});
            [~, b] = makeCorrection(ephysFlips{1}, ephysFlips{t2}, false);
            writeNPY(b, fullfile(alignDir, sprintf('correct_ephys_%s_to_ephys_%s.npy', tags{t2}, tags{1})));
        end
    end
end

%% determine what exp nums exist

rootExp = dat.expFilePath(mouseName, thisDate, 1, 'Timeline', 'master');
expInf = fileparts(fileparts(rootExp));

d = dir(fullfile(expInf, '*'));
expNums = cell2mat(cellfun(@str2num, {d(3:end).name}, 'uni', false));

%% for each expNum, determine what type it is 

hasBlock = false(size(expNums));
isMpep = false(size(expNums));
hasTimeline = false(size(expNums));

for e = 1:length(expNums)
    % if block, load block and get stimWindowUpdateTimes
    dBlock = dat.expFilePath(mouseName, thisDate, expNums(e), 'block', 'master');
    if exist(dBlock)
        load(dBlock)
        blocks{e} = block;
        hasBlock(e) = true;
    end

    dPars = dat.expFilePath(mouseName, thisDate, expNums(e), 'parameters', 'master');
    if exist(dPars)
        load(dPars)
        pars{e} = parameters;
        if isfield(parameters, 'Protocol')
            isMpep(e) = true;
        end        
    end
        

    % if there is a timeline, load it and get photodiode events, mpep UDP
    % events.
    dTL = dat.expFilePath(mouseName, thisDate, expNums(e), 'Timeline', 'master');
    if exist(dTL)
        load(dTL)
        tl{e} = Timeline;      
        hasTimeline(e) = true;
        tt = Timeline.rawDAQTimestamps;
        pd = Timeline.rawDAQData(:, strcmp({Timeline.hw.inputs.name}, 'photoDiode'));
        pdT = schmittTimes(tt, pd, [2 3]); % all flips, both up and down
        tlFlips{e} = pdT;
    end    
end

%% match up ephys and timeline events

% algorithm here is to go through each timeline available, figure out
% whether the events in timeline align with any of those in the ephys. If
% so, we have a conversion of events in that timeline into ephys
%
% Only align to the first ephys recording, since the other ones are aligned
% to that 
if hasEphys
    ef = ephysFlips{1};
    for e = 1:length(expNums)
        if hasTimeline(e)
            fprintf('trying to correct timeline %d to ephys\n', e);
            %Timeline = tl{e};
            pdT = tlFlips{e};

            if length(pdT)==length(ef)
                % easy case: the two are exactly coextensive
                [~,b] = makeCorrection(ef, pdT, false);
                success = true;
            end
            if length(pdT)<length(ef)
                [~,b,success] = findCorrection(ef, pdT, false);
            end
            if success
                writeNPY(b, fullfile(alignDir, ...
                    sprintf('correct_timeline_%d_to_ephys_%s.npy', ...
                    e, tags{1})));
                fprintf('success\n');
            else
                fprintf('could not correct timeline to ephys\n');
            end
        end
    end
end

            
               

%% match up blocks and mpeps to timeline in order

% want to connect each block or mpep with part of a timeline. So go through
% each of these in order, looking through the timelines in sequence (of
% what hasn't already been matched) looking for a match. 

for e = 1:length(expNums)
    if hasBlock(e)
        for eTL = 1:length(expNums)
            if hasTimeline(eTL)
                fprintf('trying to correct block %d to timeline %d\n', e, eTL);
                %Timeline = tl{eTL};
                pdT = tlFlips{eTL};
                block = blocks{e};
                sw = block.stimWindowUpdateTimes;
                
                success = false;
                if length(sw)<length(pdT)
                    [~,b,success,actualTimes] = findCorrection(pdT, sw, false);
                end
                if success                    
                    writeNPY(b, fullfile(alignDir, ...
                        sprintf('correct_block_%d_to_timeline_%d.npy', ...
                        e, eTL)));
                    writeNPY(actualTimes, fullfile(alignDir, ...
                        sprintf('block_%d_sw_in_timeline_%d.npy', ...
                        e, eTL)));
                    fprintf('  success\n');
                else
                    fprintf('  could not correct block %d to timeline %d\n', e, eTL);
                end
            end
        end
    elseif isMpep(e)
        % here instead... something different.
        
    end
end

