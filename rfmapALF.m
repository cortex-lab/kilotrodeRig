

function rfMap = rfmapALF(mouseName, thisDate, ephysTag, cluID)


params.makePlots = true;
params.useSVD = true;
params.countWindow = [-0.05 0.4];
params.binSize = 0.01;

alfDir = getALFdir(mouseName, thisDate);
stimTimes = readNPY(fullfile(alfDir, 'sparseNoise.times.npy'));
stimPositions = readNPY(fullfile(alfDir, 'sparseNoise.positions.npy'));

alfEphysDir = getALFdir(mouseName, thisDate, ephysTag);
st = readNPY(fullfile(alfEphysDir, 'spikes.times.npy'));
clu = readNPY(fullfile(alfEphysDir, 'spikes.clusters.npy'));

theseST = st(clu==cluID);
if ~isempty(theseST)
    [rfMap, ~] = sparseNoiseRF(theseST, stimTimes, stimPositions, params);
else
    fprintf(1, 'No spikes found for cluID=%d\n', cluID);
end

return


%% This part saves the timing out in the first place, just run once. 
addpath('F:\Dropbox\ucl\code\rfMapping') % only used for computeSparseNoiseSignals



clear r;
n = 0; 
n = n+1; r(n).mouseName = 'Cori'; r(n).thisDate = '2016-12-14'; r(n).tlExpNum = 1; r(n).cwExpNum = 2; r(n).passiveExpNum = 4; 
n = n+1; r(n).mouseName = 'Cori'; r(n).thisDate = '2016-12-15'; r(n).tlExpNum = 1; r(n).cwExpNum = 2; r(n).passiveExpNum = 5; 
n = n+1; r(n).mouseName = 'Cori'; r(n).thisDate = '2016-12-16'; r(n).tlExpNum = 1; r(n).cwExpNum = 2; r(n).passiveExpNum = 4; 
n = n+1; r(n).mouseName = 'Cori'; r(n).thisDate = '2016-12-17'; r(n).tlExpNum = 1; r(n).cwExpNum = 2; r(n).passiveExpNum = 4; 
n = n+1; r(n).mouseName = 'Cori'; r(n).thisDate = '2016-12-18'; r(n).tlExpNum = 1; r(n).cwExpNum = 2; r(n).passiveExpNum = 4; 

n = n+1; r(n).mouseName = 'Radnitz'; r(n).thisDate = '2017-01-08'; r(n).tlExpNum = 2; r(n).cwExpNum = 3; r(n).passiveExpNum = 5; 
n = n+1; r(n).mouseName = 'Radnitz'; r(n).thisDate = '2017-01-09'; r(n).tlExpNum = 2; r(n).cwExpNum = 3; r(n).passiveExpNum = 5; 
n = n+1; r(n).mouseName = 'Radnitz'; r(n).thisDate = '2017-01-10'; r(n).tlExpNum = 2; r(n).cwExpNum = 3; r(n).passiveExpNum = 5; 
n = n+1; r(n).mouseName = 'Radnitz'; r(n).thisDate = '2017-01-11'; r(n).tlExpNum = 2; r(n).cwExpNum = 3; r(n).passiveExpNum = 5; 
n = n+1; r(n).mouseName = 'Radnitz'; r(n).thisDate = '2017-01-12'; r(n).tlExpNum = 1; r(n).cwExpNum = 2; r(n).passiveExpNum = 4; 
n = n+1; r(n).mouseName = 'Radnitz'; r(n).thisDate = '2017-01-13'; r(n).tlExpNum = 2; r(n).cwExpNum = 3; r(n).passiveExpNum = []; 

n = n+1; r(n).mouseName = 'Muller'; r(n).thisDate = '2017-01-07'; r(n).tlExpNum = 2; r(n).cwExpNum = 3; r(n).passiveExpNum = 5; 
n = n+1; r(n).mouseName = 'Muller'; r(n).thisDate = '2017-01-08'; r(n).tlExpNum = 2; r(n).cwExpNum = 3; r(n).passiveExpNum = 5; 
n = n+1; r(n).mouseName = 'Muller'; r(n).thisDate = '2017-01-09'; r(n).tlExpNum = 3; r(n).cwExpNum = 4; r(n).passiveExpNum = 6; 
n = n+1; r(n).mouseName = 'Muller'; r(n).thisDate = '2017-01-10'; r(n).tlExpNum = 2; r(n).cwExpNum = 3; r(n).passiveExpNum = 5; 
n = n+1; r(n).mouseName = 'Muller'; r(n).thisDate = '2017-01-11'; r(n).tlExpNum = 1; r(n).cwExpNum = 2; r(n).passiveExpNum = 4; 
n = n+1; r(n).mouseName = 'Muller'; r(n).thisDate = '2017-01-12'; r(n).tlExpNum = 3; r(n).cwExpNum = 4; r(n).passiveExpNum = 6; 


n = n+1; r(n).mouseName = 'Moniz'; r(n).thisDate = '2017-05-13'; r(n).tlExpNum = 2; r(n).cwExpNum = 3; r(n).passiveExpNum = 5; 
n = n+1; r(n).mouseName = 'Moniz'; r(n).thisDate = '2017-05-14'; r(n).tlExpNum = 2; r(n).cwExpNum = 3; r(n).passiveExpNum = 5; 
n = n+1; r(n).mouseName = 'Moniz'; r(n).thisDate = '2017-05-15'; r(n).tlExpNum = 2; r(n).cwExpNum = 3; r(n).passiveExpNum = 5; 
n = n+1; r(n).mouseName = 'Moniz'; r(n).thisDate = '2017-05-16'; r(n).tlExpNum = 2; r(n).cwExpNum = 3; r(n).passiveExpNum = 5; 
n = n+1; r(n).mouseName = 'Moniz'; r(n).thisDate = '2017-05-17'; r(n).tlExpNum = 2; r(n).cwExpNum = 3; r(n).passiveExpNum = 5; 
n = n+1; r(n).mouseName = 'Moniz'; r(n).thisDate = '2017-05-18'; r(n).tlExpNum = 1; r(n).cwExpNum = 2; r(n).passiveExpNum = 4; 
n = n+1; r(n).mouseName = 'Moniz'; r(n).thisDate = '2017-05-19'; r(n).tlExpNum = 2; r(n).cwExpNum = 3; r(n).passiveExpNum = 5; 


n = n+1; r(n).mouseName = 'Hench'; r(n).thisDate = '2017-06-14'; r(n).tlExpNum = 2; r(n).cwExpNum = 3; r(n).passiveExpNum = 6; 
n = n+1; r(n).mouseName = 'Hench'; r(n).thisDate = '2017-06-15'; r(n).tlExpNum = 2; r(n).cwExpNum = 3; r(n).passiveExpNum = 5; 
n = n+1; r(n).mouseName = 'Hench'; r(n).thisDate = '2017-06-16'; r(n).tlExpNum = 2; r(n).cwExpNum = 3; r(n).passiveExpNum = 5; 
n = n+1; r(n).mouseName = 'Hench'; r(n).thisDate = '2017-06-17'; r(n).tlExpNum = 2; r(n).cwExpNum = 4; r(n).passiveExpNum = 6; 
n = n+1; r(n).mouseName = 'Hench'; r(n).thisDate = '2017-06-18'; r(n).tlExpNum = 1; r(n).cwExpNum = 2; r(n).passiveExpNum = 4; 


for n = 1:numel(r)
mouseName = r(n).mouseName; thisDate = r(n).thisDate; tlExpNum = r(n).tlExpNum;
fprintf(1, '%s, %s\n', mouseName, thisDate);

% paths
rootE = dat.expPath(mouseName, thisDate, 1, 'main', 'master');
root = fileparts(rootE);

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

for e = 1:length(rfExpNums)
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

end
