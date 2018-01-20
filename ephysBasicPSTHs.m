


%%
addpath(genpath('C:\Users\Nick\Documents\GitHub\spikes'))
addpath(genpath('C:\Users\Nick\Documents\GitHub\kilotrodeRig'))

%% parameters
clear all

mouseName = 'Theiler';
thisDate = '2017-10-11';


%% paths

rootE = dat.expPath(mouseName, thisDate, 1, 'main', 'master');
root = fileparts(rootE);

alignDir = fullfile(root, 'alignments');

ksRoot = fullfile('\\basket.cortexlab.net\data\nick', mouseName, thisDate);
rootFigDir = fullfile(ksRoot, 'figs');
mkdir(rootFigDir);


rootExp = dat.expFilePath(mouseName, thisDate, 1, 'Timeline', 'master');
expInf = fileparts(fileparts(rootExp));

d = dir(fullfile(expInf, '*'));
expNums = cell2mat(cellfun(@str2num, {d(3:end).name}, 'uni', false));



%% load neural

% d = dir(fullfile(root, 'ephys*'));
% if numel(d)>1 || (numel(d)==1 && strfind(d.name, '_'))
%     for q = 1:numel(d)
%         tags{q} = d(q).name(7:end);
%     end
% end
% 
% for q = 1:length(tags)
%     tag = tags{q};
%     sptemp = loadKSdir(fullfile(ksRoot, ['ephys_' tag]));
%     sptemp.name = tag;
%     if q==1
%         sp = sptemp;
%     else
%         
%         b = readNPY(fullfile(alignDir, ...
%             sprintf('correct_ephys_%s_to_ephys_%s.npy', tag, tags{1})));
%         
%         sptemp.st = applyCorrection(sptemp.st, b);
%         
%         sp(q) = sptemp;
%     end
% end

%
% for q = 1:length(sp)
%     [spikeAmps, spikeDepths, templateYpos, tempAmps, tempsUnW, tempDur, tempPeakWF] = ...
%         templatePositionsAmplitudes(sp(q).temps, sp(q).winv, sp(q).ycoords, sp(q).spikeTemplates, sp(q).tempScalingAmps);
% 
%     if isfield(sp(q), 'gain')
%         spikeAmps = spikeAmps*sp(q).gain;
%         tempAmps = tempAmps*sp(q).gain;
%     end
% 
%     sp(q).spikeAmps = spikeAmps;
%     sp(q).spikeDepths = spikeDepths;
%     sp(q).templateYpos = templateYpos;
%     sp(q).tempAmps = tempAmps;
%     sp(q).tempsUnW = tempsUnW;
%     sp(q).tempDur = tempDur;
%     sp(q).tempPeakWF = tempPeakWF;
%     
%     
% end


% new method:
sp = loadAllKsDir(mouseName, thisDate);




%%

[expNums, blocks, hasBlock, pars, isMpep, tl, hasTimeline] = ...
    dat.whichExpNums(mouseName, thisDate);

%% tlExpNum has experimentType: 'timelineManualStart'



%%

bTLtoEphys = readNPY(fullfile(alignDir, ...
            sprintf('correct_timeline_%d_to_ephys_%s.npy', tlExpNum, tags{1})));

%% go through each expNum and each block/mpep, decide which type, plot all

for q = 1:length(sp)
    for e = 1:length(expNums)
        
        % is choiceworld?
        
        
        % is mpep? 
        
        
        
    end
end


