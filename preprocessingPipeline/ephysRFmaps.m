
% Make and save some basic RF mapping plots from neuropixels recordings

function ephysRFmaps(mouseName, thisDate, ephysTagInd, savePlots)

%% 
addpath(genpath('C:\Users\Nick\Documents\github\nickBox')) % only used for "saveFig" function, I think
addpath(genpath('C:/Users/Nick/Documents/github/Rigbox'))
addpath(genpath('C:/Users/Nick/Documents/github/spikes'))
addpath(genpath('C:/Users/Nick/Documents/github/kilotrodeRig'))
addpath(genpath('C:/Users/Nick/Documents/github/npy-matlab'))
addpath('F:\Dropbox\ucl\code\rfMapping') % only used for computeSparseNoiseSignals

%% 
% clear all; close all;
% mouseName = 'Radnitz';
% thisDate = '2017-01-13';
% ephysTagInd = 2;
% savePlots = false;

%% some params about what to plot
plotContours = false;
plotOneRF = false;
plotPSTHViewer = false;
% plotContours = true;
% plotOneRF = true;
% plotPSTHViewer = true;

%% paths
% rootE = dat.expPath(mouseName, thisDate, 1, 'main', 'master');
% root = fileparts(rootE);
root = getRootDir(mouseName, thisDate);

alignDir = fullfile(root, 'alignments');

%% determine which block is the correct one for mapping data

rootExp = dat.expFilePath(mouseName, thisDate, 1, 'Timeline', 'master');
expInf = fileparts(fileparts(rootExp));

d = dir(fullfile(expInf, '*'));
expNums = cell2mat(cellfun(@str2num, {d(3:end).name}, 'uni', false));

rfExpNums = [];
for e = length(expNums):-1:1
    % if block, load block and get stimWindowUpdateTimes
    dBlock = dat.expFilePath(mouseName, thisDate, expNums(e), 'block', 'master');
    if exist(dBlock, 'file')
        load(dBlock);
        if isfield(block, 'expDef') && ~isempty(strfind(block.expDef, 'sparseNoiseAsync_NS'))
            rfExpNums(end+1) = e; 
        end
    end
end

%% determine which timeline to use
% defined as which one we have the sync for

for e = 1:length(rfExpNums)
    d = dir(fullfile(alignDir, sprintf('block_%d_sw*', rfExpNums(e))));
    if ~isempty(d) % found an alignment between this rf and a timeline
        q = sscanf(d.name, 'block_%d_sw_in_timeline_%d.npy');
        rfExpNum = q(1); tlExpNum = q(2);
        fprintf(1, 'using rfExpNum %d and tlExpNum %d\n', rfExpNum, tlExpNum);
        break
    end
end

%% load sync information  

tags = getEphysTags(mouseName, thisDate);
masterTimebase = tags{1};
ephysTag = tags{ephysTagInd}; 

fprintf(1, 'loading ephys_%s\n', ephysTag);

if ~strcmp(ephysTag, masterTimebase)
    bEphysToMaster = readNPY(fullfile(alignDir, ...
        sprintf('correct_ephys_%s_to_ephys_%s.npy', ephysTag, masterTimebase)));
else % this one is master, so use a dummy conversion
    bEphysToMaster = [1; 0];
end

bTLtoMaster = readNPY(fullfile(alignDir, ...
    sprintf('correct_timeline_%d_to_ephys_%s.npy', tlExpNum, masterTimebase)));

%% load spikes

% ksDir = fullfile('\\basket.cortexlab.net\data\nick\', mouseName, thisDate, ['ephys_' ephysTag]);
% figRoot = fullfile(ksDir, 'figs');

ksDir = getKSdir(mouseName, thisDate, ephysTag);
figRoot = getFigDir(mouseName, thisDate, ephysTag);

if ~exist(figRoot); mkdir(figRoot); end

s = loadKSdir(ksDir);

s.st = applyCorrection(s.st, bEphysToMaster);

%% compute basic things from spikes
[spikeAmps, spikeDepths, templateDepths, tempAmps, tempsUnW, templateDuration, waveforms] = ...
    templatePositionsAmplitudes(s.temps, s.winv, s.ycoords, s.spikeTemplates, s.tempScalingAmps);

spikeDurs = templateDuration(s.spikeTemplates+1);


%% load experiment info
load(dat.expFilePath(mouseName, thisDate, rfExpNum, 'block', 'master'))

stimArrayTimes = readNPY(fullfile(alignDir, ...
    sprintf('block_%d_sw_in_timeline_%d.npy', rfExpNum, tlExpNum)));

stimArrayTimes = applyCorrection(stimArrayTimes, bTLtoMaster);
%%
[stimTimeInds, stimPositions, stimArray] = ...
    computeSparseNoiseSignals(block);

if length(block.stimWindowUpdateTimes)==length(stimArrayTimes)+1 && min(stimTimeInds{1})>1
    % this is the weird case I still can't figure out where sometimes you
    % have to drop the first stimWindowUpdateTimes
    stimTimeInds = cellfun(@(x)x-1, stimTimeInds, 'uni', false);
end

stimTimes = cellfun(@(x)stimArrayTimes(x), stimTimeInds, 'uni', false);


%% first just see if there's something sensible for some stimulus
if plotPSTHViewer
    inclSpikes = spikeAmps>50;
    st = s.st(inclSpikes);
    clu = ceil(spikeDepths(inclSpikes)/80)*80;
    
    % center of right screen
    inclStims = stimPositions{1}(:,1)>-10 & stimPositions{1}(:,1)<10 & ...
        stimPositions{1}(:,2)>=80 & stimPositions{1}(:,2)<=96;
    
    % center of left screen
    inclStims2 = stimPositions{1}(:,1)>-10 & stimPositions{1}(:,1)<10 & ...
        stimPositions{1}(:,2)>=-96 & stimPositions{1}(:,2)<=-80;
    
    stimes = [stimTimes{1}(inclStims); stimTimes{1}(inclStims2)];
    slabels = [ones(1,sum(inclStims)) 1+ones(1,sum(inclStims2))];
    psthViewer(st, clu, stimes, [-0.2 1], slabels);
end

%% try one mua bit with sparseNoiseRF
if plotOneRF
    
%     inclSpikes = spikeAmps>50 & ceil(spikeDepths/80)*80==2720;
%     st = s.st(inclSpikes);
    inclSpikes = md.clu==97;
    st = md.st(inclSpikes);
    clear params
    params.useSVD = true;
%     params.countWindow = [-0.05 0.6];
    params.countWindow = [-0.4 1.5];
    params.binSize = 0.02;
    % params.countWindow = [0.2 0.5];
    
    [rfMap, stats] = sparseNoiseRF(st, stimTimes{1}, stimPositions{1}, params);
end

%% now for each cluster

% TODO: include rasters? 

q = 1;
inclSpikes = spikeAmps>50;
st = s.st(inclSpikes);
depthBinSize = 80;
clu = ceil(spikeDepths(inclSpikes)/depthBinSize);
cids = unique(clu);
nSub = ceil(sqrt(length(cids)));
params.makePlots = false;
params.useSVD = true;
params.countWindow = [-0.05 0.3];
params.binSize = 0.01;

xPos = unique(stimPositions{1}(:,1)); nX = length(xPos);
yPos = unique(stimPositions{1}(:,2)); nY = length(yPos);

fAll = figure;
p = get(fAll, 'Position');
set(fAll, 'Position', [p(1) p(2) 341        1078]);
allMaps = {};

cids = 1:ceil(3840/depthBinSize);
for c = 1:length(cids);
    
    if sum(clu==cids(c))>100 % at least some spikes
        [rfMap, stats] = sparseNoiseRF(st(clu==cids(c)), stimTimes{1}, stimPositions{1}, params);

        %subtightplot(nSub, nSub, c, 0.01, 0.01, 0.01);
        ax = axes;
        imagesc(yPos, xPos, rfMap);

        hold on; %plot(90,0, 'ro');
        plot([-45 -45], [min(xPos) max(xPos)], 'k');
        plot([45 45], [min(xPos) max(xPos)], 'k');
    %     imagesc(conv2(gausswin(5), gausswin(5), rfMap, 'same')); 
        axis image; axis off
        set(ax, 'Position', [0.01 (c-1)/(length(cids)+1)+0.01 0.95 0.95/length(cids)]);
        %ylabel(depthBinSize*c-depthBinSize/2);
        ah = annotation('textbox',[0.1 (c-1)/(length(cids)+1)+0.01 0.2 0.95/length(cids)], 'String', num2str(depthBinSize*c-depthBinSize/2), 'EdgeColor', 'none');
        
        axT = axes;
        plot(stats.timeBins, stats.timeCourse-mean(stats.timeCourse(stats.timeBins<0))); 
        yl = ylim();
        hold on; plot([0 0], yl, 'k--');
        axis off
        set(axT, 'Position', [0.5 (c-1)/(length(cids)+1)+0.01 0.45 0.95/length(cids)*1.5]);
        
        allMaps{c} = rfMap;
        allStats{c} = stats;
        drawnow;
    end
end

if savePlots
    saveFig(fAll, fullfile(figRoot, ['rfMapsAll_' ephysTag]), 'jpg');
end

%% plot them more spread out

fAll = figure;
% set(fAll, 'Position', [ -1896          55        1764         929]);
p = get(fAll, 'Position');
set(fAll, 'Position', [p(1) p(2) 1764         929]);
cids = 1:ceil(3840/depthBinSize);
nSub = ceil(sqrt(length(cids)));
for c = 1:length(cids);
    
    if sum(clu==cids(c))>100 % at least some spikes
        rfMap = allMaps{c}; stats = allStats{c};
        
        ax = subtightplot(nSub, nSub, c, 0.01, 0.01, 0.01);
        imagesc(yPos, xPos, rfMap);

        hold on; %plot(90,0, 'ro');
        plot([-45 -45], [min(xPos) max(xPos)], 'k');
        plot([45 45], [min(xPos) max(xPos)], 'k');
    %     imagesc(conv2(gausswin(5), gausswin(5), rfMap, 'same')); 
        axis image; axis off
%         set(ax, 'Position', [0.01 (c-1)/(length(cids)+1)+0.01 0.95 0.95/length(cids)]);
        title(depthBinSize*c-depthBinSize/2);
%         ah = annotation('textbox',[0.1 (c-1)/(length(cids)+1)+0.01 0.2 0.95/length(cids)], 'String', num2str(depthBinSize*c-depthBinSize/2), 'EdgeColor', 'none');
        
        
        
        drawnow;
    end
end
if savePlots
    saveFig(fAll, fullfile(figRoot, ['rfMapsAllbigger_' ephysTag]), 'jpg');
end


%% try plotting some contours

if plotContours
    xp = unique(stimPositions{1}(:,1));
    yp = unique(stimPositions{1}(:,2));
    
    inclC = [34:46]; % for V1
    % inclC = [33 35:40]; % for AM
    
    figure;
    c = copper(length(inclC));
    colors = c(:, [1 3 2]);
    for cInd = 1:length(inclC)
        c = inclC(cInd);
        
        contour(yp, xp, allMaps{c}, max(allMaps{c}(:))*0.5*[1 1], 'Color', colors(cInd,:), 'LineWidth', 2.0);
        hold on;
        
    end
    plot(90, 0, 'ko'); plot(90, 0, 'gx');
    axis image; makepretty;
    
end

%%
return;

%%
addpath('F:\Dropbox\ucl\code\analysisScripts')
mouseName = 'Hench';
dates = datenum('2017-06-14')+[0:4];
% dates = datenum('2017-06-13');

for d = 1:length(dates)
    thisDate = datestr(dates(d), 'yyyy-mm-dd');
    tags = getEphysTags(mouseName, thisDate);
    for t = 1:length(tags)
        fprintf('%s, %s\n', thisDate, tags{t});
        ephysRFmaps(mouseName, thisDate, t, true);
    end
end
fprintf(1, 'done\n')


