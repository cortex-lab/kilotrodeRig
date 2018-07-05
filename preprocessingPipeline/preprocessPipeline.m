
%%
addpath('F:\Dropbox\ucl\code\analysisScripts\');
addpath('F:\Dropbox\ucl\code\behavioralTask\burgessTask');
addpath('F:\Dropbox\ucl\code\dataAnalysis\choiceWorldAnalysis');
addpath('F:\Dropbox\ucl\code\rfMapping');
%%

clear all; close all;
mouseName = 'SS095';
thisDate = '2018-07-02'; 
useFlipper = true; flipperChan = 1;

%%
alignAll;

%%
[tags, hasEphys] = getEphysTags(mouseName, thisDate);

for tt = 1:numel(tags)
    ephysBasicPlots(mouseName, thisDate, tags{tt});
end

%%
if ~exist('hasTimeline', 'var')
    [expNums, blocks, hasBlock, pars, isMpep, tl, hasTimeline] = ...
    dat.whichExpNums(mouseName, thisDate);
end
tlExpNum = find(hasTimeline, 1, 'last');

%%
nTr = cellfun(@(x)numel(getOr(x, 'trial', [])), blocks);
cwExpNum = find(hasBlock&nTr>10, 1);

% how to pick it for signals? 
cwExpNum = 8; 

computeAndSaveBehavioralVars(mouseName, thisDate, cwExpNum, tlExpNum)

%%

rootFigDir = getFigDir(mouseName, thisDate, 'root');

% rootE = dat.expPath(mouseName, thisDate, 1, 'main', 'master');
% root = fileparts(rootE);
root = getRootDir(mouseName, thisDate);

fprintf(1, 'loading spikes\n');
sp = loadAllKsDir(mouseName, thisDate);

if exist(fullfile(root, 'activeData.mat'))
    fprintf(1, 'loading active\n');
    load(fullfile(root, 'activeData'))
    
    for q = 1:length(sp)
        f = figure; p = get(f, 'Position');
        set(f, 'Position', [ p(1) p(2)  1848        1015])
        set(f, 'Name', sprintf('%s - %s - %s', mouseName, thisDate, sp(q).name));
        psths = activePSTHs2(sp(q), cwtA, cweA, rootFigDir);
        saveFig(f, fullfile(rootFigDir, sprintf('psthByDepth_%s', sp(q).name)), 'jpg');
    end
end

%%

passiveExpNum = find(hasBlock, 1, 'last');
doAnatomy = false;

behavToALF;

%%

for tt = 1:numel(tags)
    ephysRFmaps(mouseName, thisDate, tt, true)
end


%%

% alf.evRastersALF(mouseName, thisDate, tags{1},[])

% alf.popRaster(mouseName, thisDate, tags{1}, [])

