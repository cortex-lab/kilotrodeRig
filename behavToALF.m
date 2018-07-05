

% Some code to write to ALF for behavioral/ephys experiments

%% specify dataset

clear r;
n = 0; 
% n = n+1; r(n).mouseName = 'Cori'; r(n).thisDate = '2016-12-14'; r(n).tlExpNum = 1; r(n).cwExpNum = 2; r(n).passiveExpNum = 4; 
% n = n+1; r(n).mouseName = 'Cori'; r(n).thisDate = '2016-12-15'; r(n).tlExpNum = 1; r(n).cwExpNum = 2; r(n).passiveExpNum = 5; 
% n = n+1; r(n).mouseName = 'Cori'; r(n).thisDate = '2016-12-16'; r(n).tlExpNum = 1; r(n).cwExpNum = 2; r(n).passiveExpNum = 4; 
% n = n+1; r(n).mouseName = 'Cori'; r(n).thisDate = '2016-12-17'; r(n).tlExpNum = 1; r(n).cwExpNum = 2; r(n).passiveExpNum = 4; 
% n = n+1; r(n).mouseName = 'Cori'; r(n).thisDate = '2016-12-18'; r(n).tlExpNum = 1; r(n).cwExpNum = 2; r(n).passiveExpNum = 4; 
% 
% n = n+1; r(n).mouseName = 'Radnitz'; r(n).thisDate = '2017-01-08'; r(n).tlExpNum = 2; r(n).cwExpNum = 3; r(n).passiveExpNum = 5; 
% n = n+1; r(n).mouseName = 'Radnitz'; r(n).thisDate = '2017-01-09'; r(n).tlExpNum = 2; r(n).cwExpNum = 3; r(n).passiveExpNum = 5; 
% n = n+1; r(n).mouseName = 'Radnitz'; r(n).thisDate = '2017-01-10'; r(n).tlExpNum = 2; r(n).cwExpNum = 3; r(n).passiveExpNum = 5; 
% n = n+1; r(n).mouseName = 'Radnitz'; r(n).thisDate = '2017-01-11'; r(n).tlExpNum = 2; r(n).cwExpNum = 3; r(n).passiveExpNum = 5; 
% n = n+1; r(n).mouseName = 'Radnitz'; r(n).thisDate = '2017-01-12'; r(n).tlExpNum = 1; r(n).cwExpNum = 2; r(n).passiveExpNum = 4; 
% n = n+1; r(n).mouseName = 'Radnitz'; r(n).thisDate = '2017-01-13'; r(n).tlExpNum = 2; r(n).cwExpNum = 3; r(n).passiveExpNum = []; 
% 
% n = n+1; r(n).mouseName = 'Muller'; r(n).thisDate = '2017-01-07'; r(n).tlExpNum = 2; r(n).cwExpNum = 3; r(n).passiveExpNum = 5; 
% n = n+1; r(n).mouseName = 'Muller'; r(n).thisDate = '2017-01-08'; r(n).tlExpNum = 2; r(n).cwExpNum = 3; r(n).passiveExpNum = 5; 
% n = n+1; r(n).mouseName = 'Muller'; r(n).thisDate = '2017-01-09'; r(n).tlExpNum = 3; r(n).cwExpNum = 4; r(n).passiveExpNum = 6; 
% n = n+1; r(n).mouseName = 'Muller'; r(n).thisDate = '2017-01-10'; r(n).tlExpNum = 2; r(n).cwExpNum = 3; r(n).passiveExpNum = 5; 
% n = n+1; r(n).mouseName = 'Muller'; r(n).thisDate = '2017-01-11'; r(n).tlExpNum = 1; r(n).cwExpNum = 2; r(n).passiveExpNum = 4; 
% n = n+1; r(n).mouseName = 'Muller'; r(n).thisDate = '2017-01-12'; r(n).tlExpNum = 3; r(n).cwExpNum = 4; r(n).passiveExpNum = 6; 
% 
% 
% n = n+1; r(n).mouseName = 'Moniz'; r(n).thisDate = '2017-05-13'; r(n).tlExpNum = 2; r(n).cwExpNum = 3; r(n).passiveExpNum = 5; 
% n = n+1; r(n).mouseName = 'Moniz'; r(n).thisDate = '2017-05-14'; r(n).tlExpNum = 2; r(n).cwExpNum = 3; r(n).passiveExpNum = 5; 
% n = n+1; r(n).mouseName = 'Moniz'; r(n).thisDate = '2017-05-15'; r(n).tlExpNum = 2; r(n).cwExpNum = 3; r(n).passiveExpNum = 5; 
% n = n+1; r(n).mouseName = 'Moniz'; r(n).thisDate = '2017-05-16'; r(n).tlExpNum = 2; r(n).cwExpNum = 3; r(n).passiveExpNum = 5; 
% n = n+1; r(n).mouseName = 'Moniz'; r(n).thisDate = '2017-05-17'; r(n).tlExpNum = 2; r(n).cwExpNum = 3; r(n).passiveExpNum = 5; 
% n = n+1; r(n).mouseName = 'Moniz'; r(n).thisDate = '2017-05-18'; r(n).tlExpNum = 1; r(n).cwExpNum = 2; r(n).passiveExpNum = 4; 
% n = n+1; r(n).mouseName = 'Moniz'; r(n).thisDate = '2017-05-19'; r(n).tlExpNum = 2; r(n).cwExpNum = 3; r(n).passiveExpNum = 5; 
% 
% 
% n = n+1; r(n).mouseName = 'Hench'; r(n).thisDate = '2017-06-14'; r(n).tlExpNum = 2; r(n).cwExpNum = 3; r(n).passiveExpNum = 6; 
% n = n+1; r(n).mouseName = 'Hench'; r(n).thisDate = '2017-06-15'; r(n).tlExpNum = 2; r(n).cwExpNum = 3; r(n).passiveExpNum = 5; 
% n = n+1; r(n).mouseName = 'Hench'; r(n).thisDate = '2017-06-16'; r(n).tlExpNum = 2; r(n).cwExpNum = 3; r(n).passiveExpNum = 5; 
% n = n+1; r(n).mouseName = 'Hench'; r(n).thisDate = '2017-06-17'; r(n).tlExpNum = 2; r(n).cwExpNum = 4; r(n).passiveExpNum = 6; 
% n = n+1; r(n).mouseName = 'Hench'; r(n).thisDate = '2017-06-18'; r(n).tlExpNum = 1; r(n).cwExpNum = 2; r(n).passiveExpNum = 4; 

% n = n+1; r(n).mouseName = 'Theiler'; r(n).thisDate = '2017-10-11'; r(n).tlExpNum = 1; r(n).cwExpNum = 2; r(n).passiveExpNum = 4; 

% n = n+1; r(n).mouseName = 'Lederberg'; r(n).thisDate = '2017-12-05'; r(n).tlExpNum = 1; r(n).cwExpNum = 2; r(n).passiveExpNum = 4; 


% n=1;
% % for n = 1:numel(r)
% mouseName = r(n).mouseName; thisDate = r(n).thisDate; tlExpNum = r(n).tlExpNum; passiveExpNum = r(n).passiveExpNum;
% 
% % mouseName = 'Muller'; 
% % thisDate = '2017-01-07'; 
% % tlExpNum = 2;
% 
% % mouseName = 'Cori'; 
% % thisDate = '2016-12-18'; 
% % tlExpNum = 1;
% 
% % mouseName = 'Radnitz'; 
% % thisDate = '2017-01-12'; 
% % tlExpNum = 1;
% 
% % mouseName = 'Robbins'; 
% % thisDate = '2017-06-13'; 
% % tlExpNum = 1;
% 
% rootE = dat.expPath(mouseName, thisDate, 1, 'main', 'master');
% root = fileparts(rootE);
% destDir = fullfile(root, 'alf');
root = getRootDir(mouseName, thisDate);
destDir = getALFdir(mouseName, thisDate);
mkdir(destDir);

%% load the data

% load trial events stuff
if exist(fullfile(root, 'activeData.mat'))
    hasCW = true;
    load(fullfile(root, 'activeData'))

    % licks
    load(fullfile(root, 'lickData')); 
else
    hasCW = false;
end
%
% also wheel, to analyze with new code. saved "wheelData" doesn't have
% position so we're going back to the source.
load(dat.expFilePath(mouseName, thisDate, tlExpNum, 'Timeline', 'master'));
tt = Timeline.rawDAQTimestamps;
wheelRaw = Timeline.rawDAQData(:, strcmp({Timeline.hw.inputs.name}, 'rotaryEncoder'));
wheelRaw = wheel.correctCounterDiscont(wheelRaw);
d = dir(fullfile(root, 'alignments', 'correct_timeline*npy'));
b = readNPY(fullfile(root, 'alignments', d(end).name));
tWheel = applyCorrection(tt, b);

if hasCW
    Fs = 1000;
    [moveOnsets, moveOffsets] = wheel.findWheelMoves3(wheelRaw, tWheel, Fs, []);
    
    % if choiceworld, can do this part of the movement detection
    resp = cweA.choice; hasTurn = resp==1|resp==2; resp = resp(hasTurn);
    intStartTime = cwtA.goCue(hasTurn); respTime = cwtA.responseTime(hasTurn);
    moveType = wheel.classifyWheelMoves(tWheel, wheelRaw, moveOnsets, moveOffsets, intStartTime, respTime, resp);
    clear dm; dm.moveOnsets = moveOnsets; dm.moveOffsets = moveOffsets; dm.moveType = moveType;
    plotWheel(tWheel, wheelRaw, dm);
end

% write wheel

alf.writeTimeseries(destDir, 'wheel', tWheel, [], []);

writeNPY(wheelRaw(:), fullfile(destDir, 'wheel.position.npy'));
vel = wheel.computeVelocity2(wheelRaw, 0.015, 1/mean(diff(tWheel)));
writeNPY(vel(:), fullfile(destDir, 'wheel.velocity.npy'));

if hasCW
    % write movement detection results
    
    alf.writeInterval(destDir, 'wheelMoves', moveOnsets, moveOffsets, [], []);
    if exist('moveType', 'var')
        writeNPY(moveType(:), fullfile(destDir, 'wheelMoves.type.npy'));
    end
    
    if exist('moveAmp', 'var')
        writeNPY(moveAmp(:), fullfile(destDir, 'wheelMoves.amp.npy'));
    end

    if exist('peakVelTimes', 'var')
        peakVel = interp1(tWheel, vel, peakVelTimes);
        writeNPY(peakVel(:), fullfile(destDir, 'wheelMoves.peakVel.npy'));
    end

    % write lick

    alf.writeTimeseries(destDir, 'lickSignal', tLick, [], []);
    writeNPY(lickSigC(:), fullfile(destDir, 'lickSignal.trace.npy'));
    alf.writeEventseries(destDir, 'licks', lickTimes, [], []);

    % write behavioral event times and metadata

    % vars = cweA.Properties.VariableNames;
    % for v = 1:numel(vars)
    %     if ~strcmp(vars{v}, 'vcc')
    %         var = cweA.(vars{v});
    %         writeNPY(var, fullfile(destDir, ['choiceWorldTrials.' vars{v} '.npy']));
    %     end
    % end
    % 
    % vars = {'stimOn', 'beeps', 'feedbackTime', 'responseTime'};
    % for v = 1:numel(vars)
    %     var = cwtA.(vars{v});
    %     if ~strcmp(vars{v}, 'beeps')        
    %         writeNPY(var, fullfile(destDir, ['choiceWorldTimes.' vars{v} '.npy']));
    %     else
    %         writeNPY(var, fullfile(destDir, 'choiceWorldTimes.goCue.npy'));
    %     end
    % end

    alf.writeEventseries(destDir, 'cwStimOn', cwtA.stimOn, [], []);
    writeNPY(cweA.contrastLeft, fullfile(destDir, 'cwStimOn.contrastLeft.npy'));
    writeNPY(cweA.contrastRight, fullfile(destDir, 'cwStimOn.contrastRight.npy'));

    alf.writeEventseries(destDir, 'cwResponse', cwtA.responseTime, [], []);
    writeNPY(cweA.choice, fullfile(destDir, 'cwResponse.choice.npy'));

    alf.writeEventseries(destDir, 'cwGoCue', cwtA.beeps, [], []);

    alf.writeEventseries(destDir, 'cwFeedback', cwtA.feedbackTime, [], []);
    writeNPY(cweA.feedback, fullfile(destDir, 'cwFeedback.type.npy'));

    alf.writeInterval(destDir, 'cwTrials', cwtA.trialStarts, cwtA.trialEnds, [], []);
    writeNPY(cweA.repNum, fullfile(destDir, 'cwTrials.repNum.npy'));
    writeNPY(cweA.inclTrials, fullfile(destDir, 'cwTrials.inclTrials.npy'));
end

%% parameters
% r = listInclRecs('all');

% for n = 11:numel(r)
%     clear cwExpNum
%     mouseName = r(n).mouseName; thisDate = r(n).thisDate;
    
    if ~exist('cwExpNum')
        [expNums, blocks, hasBlock, pars, isMpep, tl, hasTimeline] = ...
            dat.whichExpNums(mouseName, thisDate);
        nTr = cellfun(@(x)numel(getOr(x, 'trial', [])), blocks);
        cwExpNum = find(hasBlock&nTr>10, 1);
        parameters = pars{cwExpNum};
    else
        % load parameters
        load(dat.expFilePath(mouseName, thisDate, cwExpNum, 'parameters', 'master'));
    end

    % prep
    parameters.experimentFun = func2str(parameters.experimentFun);

    % to json
    q = jsonencode(parameters);

    destFile = fullfile(getALFdir(mouseName, thisDate, []), 'parameters.json');
    fprintf(1, 'writing %s\n', destFile);
    fprintf(1, '  cwExpNum %d target %d %d\n', cwExpNum, parameters.targetThreshold, parameters.targetAltitude);
    fid = fopen(destFile, 'w');
    fwrite(fid, q, 'char');
    fclose(fid);

% end

%% write ephys borders
clear brainLoc
if doAnatomy
    
    if ~exist('av', 'var')
        av = readNPY('J:/allen/annotation_volume_10um_by_index.npy');
    end
    if ~exist('st', 'var')
        st = loadStructureTree('J:/allen/structure_tree_safe.csv');
    end

    for n = 32%1:numel(r)
        mouseName = r(n).mouseName; thisDate = r(n).thisDate; tlExpNum = r(n).tlExpNum;


%         rootE = dat.expPath(mouseName, thisDate, 1, 'main', 'master');
%         root = fileparts(rootE);
        root = getRootDir(mouseName, thisDate);

        destDir = fullfile(root, 'alf');
        mkdir(destDir);
        tags = getEphysTags(mouseName, thisDate);

        for tg = 1:length(tags)
            fprintf(1, '%s, %s, %s\n', mouseName, thisDate, tags{tg});
            mkdir(fullfile(destDir, tags{tg}));

            manBordersFile = fullfile('\\basket.cortexlab.net\data\nick\', mouseName, thisDate, ...
                ['ephys_' tags{tg}], 'manualBorders.mat');
            if exist(manBordersFile, 'file')
                load(manBordersFile);
                writetable(borders,fullfile(destDir, tags{tg}, ['borders_' tags{tg} '.tsv']) ,'Delimiter','\t', 'FileType', 'text');


                fitFile = fullfile('\\basket.cortexlab.net\data\nick\', mouseName, thisDate, ...
                    ['ephys_' tags{tg}], 'histologyFit.mat');
                if exist(fitFile, 'file')                
                    clear d;
                    load(fitFile);
                    [entryRL, entryAP, vertAngle, horizAngle] = alyxInsertionFromVector(m*10, p, av, st);
                    pen.entry_point_rl = entryRL;
                    pen.entry_point_ap = entryAP;
                    pen.vertical_angle = vertAngle;
                    pen.horizontal_angle = horizAngle;
                    pen.axial_angle = 0; % don't have these for now
                    if exist('d')
                        pen.distance_advanced = d*1000;
                    else
                        pen.distance_advanced = borders.upperBorder(1)+200; % 200 is for the tip
                    end
                    
                    savejson('probe_insertion', pen, fullfile(destDir, tags{tg}, 'probe_insertion.json'));

                    % now, each recording site needs a site num, ccf coords, and
                    % ontology - just for the 374 that were recorded
                    sp = readNPY('p3a_site_positions.npy');
                    cm = readNPY('p3a_channel_map.npy');
                    relCoords = sp(~isnan(cm),:);
                    [ccfCoords, ccfOntology] = alyxLocationFromInsertion(entryRL, entryAP, vertAngle, horizAngle, 0, pen.distance_advanced, relCoords, av, st);

                    % use the ccfCoords as returned by this function, but not the
                    % ontology, since we have manual labels.
                    brainLoc.site_no = find(~isnan(cm))-1; % zero-index
                    brainLoc.ccf_ap = ccfCoords(:,1);
                    brainLoc.ccf_dv = ccfCoords(:,2);
                    brainLoc.ccf_lr = ccfCoords(:,3);

                    manOntology = {};
                    upp = borders.upperBorder+200; low = borders.lowerBorder+200; % +200 for tip
                    for ch = 1:size(ccfCoords,1)
                        a = find(sp(ch,2)>low&sp(ch,2)<=upp);
                        if ~isempty(a)
                            manOntology{ch} = borders.acronym{a};
                        else
                            manOntology{ch} = '';
                        end
                    end
                    brainLoc.allen_ontology = manOntology';
                    savejson('brain_locations', brainLoc, fullfile(destDir, tags{tg}, 'brain_locations.json'));
                else
                    fprintf(1, 'no histology fit!\n');
                end
            end
        end
    end
end

%% ephys itself

useDriftmap = true;

% for n = 1:numel(r)
%     mouseName = r(n).mouseName; thisDate = r(n).thisDate; tlExpNum = r(n).tlExpNum;
        

    tags = getEphysTags(mouseName, thisDate);
    root = getRootDir(mouseName, thisDate);

    destDir = fullfile(root, 'alf');
            
    sp = loadAllKsDir(mouseName, thisDate);        
    
    for tg = 1:length(tags)
        thisDest = fullfile(destDir, tags{tg});
        mkdir(thisDest)
        
        alf.writeEventseries(thisDest, 'spikes', sp(tg).st, [], []);
        writeNPY(sp(tg).clu, fullfile(thisDest, 'spikes.clusters.npy'));
        writeNPY(sp(tg).spikeAmps, fullfile(thisDest, 'spikes.amps.npy'));
        
        if useDriftmap
            ksDir = getKSdir(mouseName, thisDate, tags{tg});
            [~,~, sd] = ksDriftmap(ksDir);
            writeNPY(sd, fullfile(thisDest, 'spikes.depths.npy'));
            %fprintf(1, '%s: %d, %d\n', tags{tg}, numel(sd), numel(sp(tg).spikeDepths));
        else
            writeNPY(sp(tg).spikeDepths, fullfile(thisDest, 'spikes.depths.npy'));
        end
        
        
        
        cids = sp(tg).cids(:); cgs = sp(tg).cgs(:);
        allCID = unique(sp(tg).clu);
        allCG = 3*ones(size(allCID));
        for c = 1:length(cids); allCG(allCID==cids(c))=cgs(c); end
        writeNPY(allCID, fullfile(thisDest, 'clusters.ids.npy'));
        writeNPY(allCG, fullfile(thisDest, 'clusters.groups.npy'));
        
        st = sp(tg).st;
        clu = sp(tg).clu;
        
        uClu = unique(clu);
        tempIndPerClu = findTempForEachClu(clu, sp(tg).spikeTemplates); % which template goes with each cluster
        
        tempPerClu = sp(tg).tempsUnW(tempIndPerClu(uClu+1)+1,:,:);
        writeNPY(tempPerClu, fullfile(thisDest, 'clusters.waveforms.npy'));
        
        cluYpos = sp(tg).templateYpos(tempIndPerClu(uClu+1)+1,:,:);
        writeNPY(cluYpos, fullfile(thisDest, 'clusters.depths.npy'));
        
        wfDur = sp(tg).tempDur(tempIndPerClu(uClu+1)+1,:,:);
        writeNPY(wfDur, fullfile(thisDest, 'clusters.waveformDuration.npy'));
    end
    
% end

%% eye alignment

% rootE = dat.expPath(mouseName, thisDate, 1, 'main', 'master');
% root = fileparts(rootE);
root = getRootDir(mouseName, thisDate);
destDir = fullfile(root, 'alf');

eyeFolder = fileparts(dat.expFilePath(mouseName, thisDate, tlExpNum, 'eyetracking', 'master'));

timestampsFile = fullfile(eyeFolder, 'eye_timeStamps.mat');
if ~exist(timestampsFile, 'file')
    auxVid = prepareAuxVids(mouseName, thisDate, tlExpNum);
end
load(timestampsFile)
    
tags = getEphysTags(mouseName, thisDate); masterAlign = tags{1};
alignDir = fullfile(root, 'alignments');
alignFile = dir(fullfile(alignDir, sprintf('correct_timeline*ephys_%s.npy', masterAlign)));
b = readNPY(fullfile(alignDir, alignFile.name));

tAligned = applyCorrection(tVid, b); % will be a column after this

alf.writeTimeseries(destDir, 'eye', tAligned, [], []);

processedFile = fullfile(eyeFolder, 'eye_processed.mat');
if ~exist(processedFile, 'file')
    fprintf(1, 'eye movie not processed\n');
else
    load(processedFile)
    alf.eyeToALF(results, destDir)
end

% same thing for face
timestampsFile = fullfile(eyeFolder, 'face_timeStamps.mat');
if exist(timestampsFile, 'file')
    load(timestampsFile)
    tAligned = applyCorrection(tVid, b); % will be a column after this
    alf.writeTimeseries(destDir, 'face', tAligned, [], []);
end


%% passive choiceworld

% for n = 1:numel(r)
%     mouseName = r(n).mouseName; thisDate = r(n).thisDate; tlExpNum = r(n).tlExpNum; passiveExpNum = r(n).passiveExpNum;
    if ~isempty(passiveExpNum)
        fprintf(1, '%s, %s\n', mouseName, thisDate);
        destDir = getALFdir(mouseName, thisDate);
        load(dat.expFilePath(mouseName, thisDate, tlExpNum, 'Timeline', 'master'));
        [cwtP, cweP] = loadPassiveCW(mouseName, thisDate, tlExpNum, passiveExpNum, Timeline);
        
        alf.writeInterval(destDir, 'passiveTrials', cwtP.trialStarts, cwtP.trialEnds, [], []);
        writeNPY(cweP.condNums, fullfile(destDir, 'passiveTrials.condNum.npy'));
        
        cL = cweP.contrastLeft; cR = cweP.contrastRight;
        stimTime = cwtP.stimOn;
        hasStim = cL>0 | cR>0;
        stimOn = stimTime(hasStim);
        cL = cL(hasStim);
        cR = cR(hasStim);
        alf.writeEventseries(destDir, 'passiveStimOn', stimOn, [], []);
        writeNPY(cL, fullfile(destDir, 'passiveStimOn.contrastLeft.npy'));
        writeNPY(cR, fullfile(destDir, 'passiveStimOn.contrastRight.npy'));
        
        alf.writeEventseries(destDir, 'passiveBeep', cwtP.goCue(cweP.hasBeep), [], []);
        alf.writeEventseries(destDir, 'passiveValveClick', cwtP.responseTime(cweP.hasClick), [], []);
        alf.writeEventseries(destDir, 'passiveWhiteNoise', cwtP.responseTime(cweP.hasWhiteNoise), [], []);
    end
% end

%% sparse noise timing

% for n = 1:numel(r)
% mouseName = r(n).mouseName; thisDate = r(n).thisDate; tlExpNum = r(n).tlExpNum;
% fprintf(1, '%s, %s\n', mouseName, thisDate);

% paths
% rootE = dat.expPath(mouseName, thisDate, 1, 'main', 'master');
% root = fileparts(rootE);
root = getRootDir(mouseName, thisDate);

alignDir = fullfile(root, 'alignments');

% determine which block is the correct one for mapping data

rootExp = dat.expFilePath(mouseName, thisDate, 1, 'Timeline', 'master');
expInf = fileparts(fileparts(rootExp));

d = dir(fullfile(expInf, '*'));
expNums = cell2mat(cellfun(@str2num, {d(3:end).name}, 'uni', false));

rfExpNums = [];
for e = 1:length(expNums)
    % if block, load block and get stimWindowUpdateTimes
    dBlock = dat.expFilePath(mouseName, thisDate, expNums(e), 'block', 'master');
    if exist(dBlock, 'file')
        load(dBlock);
        if isfield(block, 'expDef') && ~isempty(strfind(block.expDef, 'sparseNoiseAsync_NS'))
            rfExpNums(end+1) = e; 
        end
    end
end

% determine which timeline to use
% defined as which one we have the sync for

for e = length(rfExpNums):-1:1 % search in reverse order, to choose the last if multiple
    d = dir(fullfile(alignDir, sprintf('block_%d_sw*', rfExpNums(e))));
    if ~isempty(d) % found an alignment between this rf and a timeline
        q = sscanf(d.name, 'block_%d_sw_in_timeline_%d.npy');
        rfExpNum = q(1); tlExpNum = q(2);
        fprintf(1, 'using rfExpNum %d and tlExpNum %d\n', rfExpNum, tlExpNum);
        break
    end
end

% load sync information  

tlToMasterFile = dir(fullfile(alignDir, ...
    sprintf('correct_timeline_%d_to_ephys_*.npy', tlExpNum)));
bTLtoMaster = readNPY(fullfile(alignDir,tlToMasterFile.name));

% load experiment info
load(dat.expFilePath(mouseName, thisDate, rfExpNum, 'block', 'master'))

stimArrayTimes = readNPY(fullfile(alignDir, ...
    sprintf('block_%d_sw_in_timeline_%d.npy', rfExpNum, tlExpNum)));

stimArrayTimes = applyCorrection(stimArrayTimes, bTLtoMaster);
%
[stimTimeInds, stimPositions, stimArray] = ...
    computeSparseNoiseSignals(block);

if length(block.stimWindowUpdateTimes)==length(stimArrayTimes)+1 && min(stimTimeInds{1})>1
    % this is the weird case I still can't figure out where sometimes you
    % have to drop the first stimWindowUpdateTimes
    stimTimeInds = cellfun(@(x)x-1, stimTimeInds, 'uni', false);
end

stimTimes = cellfun(@(x)stimArrayTimes(x), stimTimeInds, 'uni', false);

alfDir = getALFdir(mouseName, thisDate);

alf.writeEventseries(alfDir, 'sparseNoise', stimTimes{1}, [], []);
writeNPY(stimPositions{1}, fullfile(alfDir, 'sparseNoise.positions.npy'));

% end


%% spontaneous intervals

% for n = 1:numel(r)
%     mouseName = r(n).mouseName; thisDate = r(n).thisDate; tlExpNum = r(n).tlExpNum; passiveExpNum = r(n).passiveExpNum;
%     fprintf(1, '%s, %s\n', mouseName, thisDate);
%     tags = getEphysTags(mouseName, thisDate);
    ephysDir = getALFdir(mouseName, thisDate, tags{1});
    destDir = getALFdir(mouseName, thisDate);
    st = readNPY(fullfile(ephysDir, 'spikes.times.npy'));
    try 
        cwTr = readNPY(fullfile(destDir, 'cwTrials.intervals.npy'));
    catch
        cwTr = [0 0];
    end
    try
        passiveTr = readNPY(fullfile(destDir, 'passiveTrials.intervals.npy'));
    catch
        passiveTr = [0 0];
    end
    sn = sort(readNPY(fullfile(destDir,'sparseNoise.times.npy')));
    
    starts = sort([cwTr(1,1) passiveTr(1,1) sn(1)])';
    ends = sort([cwTr(end,2) passiveTr(end,2) sn(end)])';
    
    spontInts = [st(1) starts(1); ends(1:end-1) starts(2:end); ends(end) st(end)];
    diff(spontInts,[],2)
    alf.writeInterval(destDir, 'spontaneous', spontInts(:,1), spontInts(:,2), [], []);
% end
%% particular timeline signals 

doPuffs = false;

if doPuffs
    
    sourceName = 'rewardEcho'; writeName = 'airPuffs';
    
    load(dat.expFilePath(mouseName, thisDate, tlExpNum, 'Timeline', 'master'));
    tt = Timeline.rawDAQTimestamps;
    sig = Timeline.rawDAQData(:, strcmp({Timeline.hw.inputs.name}, sourceName));
    
    
    tags = getEphysTags(mouseName, thisDate); masterAlign = tags{1};
    alignDir = fullfile(root, 'alignments');
    alignFile = dir(fullfile(alignDir, sprintf('correct_timeline*ephys_%s.npy', masterAlign)));
    b = readNPY(fullfile(alignDir, alignFile.name));
    tAligned = applyCorrection(tt, b); % will be a column after this
    
    [~, flipsUp, flipsDown] = schmittTimes(tAligned, sig, [1.2 3]);
    alf.writeInterval(destDir, writeName, flipsUp, flipsDown, [], []);
    
end

%% randomworld



%% natimg

mpNum = find(isMpep);
for q = 1:numel(mpNum)
    p = pars{mpNum(q)}.Protocol;
    if strcmp(p.xfile, 'stimLoadImg5.x')
        load natimg700_isample.mat % in kilotrodeRig repo
        % 0 is blank screen
        % 1 through 700 refers to the image index in this folder: \\zserver\Data\pregenerated_textures\Marius\proc\selection2800
        
        alignDir = fullfile(root, 'alignments');
        
        alignFile = dir(fullfile(alignDir, sprintf('mpep_%d_onsets*', mpNum(q))));        
        onsets = readNPY(fullfile(alignDir, alignFile(1).name));
        
        alignFile = dir(fullfile(alignDir, sprintf('mpep_%d_offsets*', mpNum(q))));        
        offsets = readNPY(fullfile(alignDir, alignFile(1).name));
        
        alfDir = getALFdir(mouseName, thisDate);
        alf.writeInterval(alfDir, 'naturalImages', onsets, offsets, [], []);
        writeNPY(isample(:), fullfile(alfDir, 'naturalImages.ids.npy'));
    end
end

%% spontaneous intervals, given other sources


%% galvo params

% include if any of the parameters have a "mWperV"
if any(cellfun(@(x)isfield(x, 'mWperV'), pars))
    
    galvoExpNum = find(cellfun(@(x)isfield(x, 'mWperV'), pars), 1);
    
    alfDir = getALFdir(mouseName, thisDate);    
    
    [galvoIntervals, galvoAPLR, laserIntervals, laserPower] = extractGalvo(...
        mouseName, thisDate, tlExpNum, galvoExpNum);
    
    rootE = dat.expPath(mouseName, thisDate, 1, 'main', 'master');
    root = fileparts(rootE);
    tags = getEphysTags(mouseName, thisDate); masterAlign = tags{1};
    alignDir = fullfile(root, 'alignments');
    alignFile = dir(fullfile(alignDir, sprintf('correct_timeline*ephys_%s.npy', masterAlign)));
    b = readNPY(fullfile(alignDir, alignFile.name));
    giAlign = applyCorrection(galvoIntervals, b); giAlign = reshape(giAlign, size(galvoIntervals));
    liAlign = applyCorrection(laserIntervals, b); liAlign = reshape(liAlign, size(laserIntervals));
    
    alf.writeInterval(alfDir, 'galvoPositions', giAlign(:,1), giAlign(:,2), [], []);
    writeNPY(galvoAPLR(:,1), fullfile(alfDir, 'galvoPositions.AP.npy'));
    writeNPY(galvoAPLR(:,2), fullfile(alfDir, 'galvoPositions.LR.npy'));
    
    alf.writeInterval(alfDir, 'laserPulses', liAlign(:,1), liAlign(:,2), [], []);
    writeNPY(laserPower, fullfile(alfDir, 'laserPulses.power.npy'));

end