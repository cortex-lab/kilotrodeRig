

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
n = n+1; r(n).mouseName = 'Hench'; r(n).thisDate = '2017-06-17'; r(n).tlExpNum = 2; r(n).cwExpNum = 4; r(n).passiveExpNum = 6; 
% n = n+1; r(n).mouseName = 'Hench'; r(n).thisDate = '2017-06-18'; r(n).tlExpNum = 1; r(n).cwExpNum = 2; r(n).passiveExpNum = 4; 


n=1;
% % for n = 1:numel(r)
mouseName = r(n).mouseName; thisDate = r(n).thisDate; tlExpNum = r(n).tlExpNum; passiveExpNum = r(n).passiveExpNum;
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
rootE = dat.expPath(mouseName, thisDate, 1, 'main', 'master');
root = fileparts(rootE);
destDir = fullfile(root, 'alf');
% mkdir(destDir);

%% load the data

% load trial events stuff
load(fullfile(root, 'activeData'))

% licks
load(fullfile(root, 'lickData')); 

%
% also wheel, to analyze with new code. saved "wheelData" doesn't have
% position so we're going back to the source.
load(dat.expFilePath(mouseName, thisDate, tlExpNum, 'Timeline', 'master'));
tt = Timeline.rawDAQTimestamps;
wheelRaw = Timeline.rawDAQData(:, strcmp({Timeline.hw.inputs.name}, 'rotaryEncoder'));
wheelRaw = wheel.correctCounterDiscont(wheelRaw);
d = dir(fullfile(root, 'alignments', 'correct_timeline*npy'));
b = readNPY(fullfile(root, 'alignments', d.name));
tWheel = applyCorrection(tt, b);

Fs = 1000;
[moveOnsets, moveOffsets] = wheel.findWheelMoves3(wheelRaw, tWheel, Fs, []);

% if choiceworld, can do this part of the movement detection
resp = cweA.choice; hasTurn = resp==1|resp==2; resp = resp(hasTurn);
intStartTime = cwtA.goCue(hasTurn); respTime = cwtA.responseTime(hasTurn);
moveType = wheel.classifyWheelMoves(tWheel, wheelRaw, moveOnsets, moveOffsets, intStartTime, respTime, resp);
clear dm; dm.moveOnsets = moveOnsets; dm.moveOffsets = moveOffsets; dm.moveType = moveType;
    plotWheel(tWheel, wheelRaw, dm);


% write wheel

alf.writeTimeseries(destDir, 'wheel', tWheel, [], []);

writeNPY(wheelRaw(:), fullfile(destDir, 'wheel.position.npy'));
vel = wheel.computeVelocity2(wheelRaw, 0.015, 1/mean(diff(tWheel)));
writeNPY(vel(:), fullfile(destDir, 'wheel.velocity.npy'));

% write movement detection results

alf.writeInterval(destDir, 'wheelMoves', moveOnsets, moveOffsets, [], []);
if exist('moveType', 'var')
    writeNPY(moveType(:), fullfile(destDir, 'wheelMoves.type.npy'));
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


%% write ephys borders

if ~exist('av', 'var')
    av = readNPY('J:/allen/annotation_volume_10um_by_index.npy');
end
if ~exist('st', 'var')
    st = loadStructureTree('J:/allen/structure_tree_safe.csv');
end

for n = 1:numel(r)
    mouseName = r(n).mouseName; thisDate = r(n).thisDate; tlExpNum = r(n).tlExpNum;
    
    
    rootE = dat.expPath(mouseName, thisDate, 1, 'main', 'master');
    root = fileparts(rootE);
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
                load(fitFile);
                [entryRL, entryAP, vertAngle, horizAngle] = alyxInsertionFromVector(m*10, p, av, st);
                pen.entry_point_rl = entryRL;
                pen.entry_point_ap = entryAP;
                pen.vertical_angle = vertAngle;
                pen.horizontal_angle = horizAngle;
                pen.axial_angle = 0; % don't have these for now
                pen.distance_advanced = borders.upperBorder(1)+200; % 200 is for the tip
                
                savejson('probe_insertion', pen, fullfile(destDir, tags{tg}, 'probe_insertion.json'));
                
                % now, each recording site needs a site num, ccf coords, and
                % ontology - just for the 374 that were recorded
                sp = readNPY('p3a_site_positions.npy');
                cm = readNPY('p3a_channel_map.npy');
                relCoords = sp(~isnan(cm),:);
                [ccfCoords, ccfOntology] = alyxLocationFromInsertion(entryRL, entryAP, vertAngle, horizAngle, axialAngle, pen.distance_advanced, relCoords, av, st);
                
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

%% ephys itself

% for n = 1:numel(r)
%     mouseName = r(n).mouseName; thisDate = r(n).thisDate; tlExpNum = r(n).tlExpNum;
    
    tags = getEphysTags(mouseName, thisDate);
    
    sp = loadAllKsDir(mouseName, thisDate);
    
    rootE = dat.expPath(mouseName, thisDate, 1, 'main', 'master');
    root = fileparts(rootE);
    destDir = fullfile(root, 'alf');
    
    for tg = 1:length(tags)
        thisDest = fullfile(destDir, tags{tg});
        mkdir(thisDest)
        
        alf.writeEventseries(thisDest, 'spikes', sp(tg).st, [], []);
        writeNPY(sp(tg).clu, fullfile(thisDest, 'spikes.clusters.npy'));
        writeNPY(sp(tg).spikeAmps, fullfile(thisDest, 'spikes.amps.npy'));
        writeNPY(sp(tg).spikeDepths, fullfile(thisDest, 'spikes.depths.npy'));
        
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
        writeNPY(cluYpos, fullfile(thisDest, 'clusters.waveformDuration.npy'));
    end
    
% end

%% eye alignment

rootE = dat.expPath(mouseName, thisDate, 1, 'main', 'master');
root = fileparts(rootE);
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
load(timestampsFile)
tAligned = applyCorrection(tVid, b); % will be a column after this
alf.writeTimeseries(destDir, 'face', tAligned, [], []);

end

%% passive choiceworld

for n = 26:numel(r)
    mouseName = r(n).mouseName; thisDate = r(n).thisDate; tlExpNum = r(n).tlExpNum; passiveExpNum = r(n).passiveExpNum;
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
end

%% spontaneous intervals

for n = 12:numel(r)
    mouseName = r(n).mouseName; thisDate = r(n).thisDate; tlExpNum = r(n).tlExpNum; passiveExpNum = r(n).passiveExpNum;
    fprintf(1, '%s, %s\n', mouseName, thisDate);
    tags = getEphysTags(mouseName, thisDate);
    ephysDir = getALFdir(mouseName, thisDate, tags{1});
    destDir = getALFdir(mouseName, thisDate);
    st = readNPY(fullfile(ephysDir, 'spikes.times.npy'));
    cwTr = readNPY(fullfile(destDir, 'cwTrials.intervals.npy'));
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
end
%% particular timeline signals 

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