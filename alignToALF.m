
%% script to align a dataset in ALF format

mn = 'Robbins';
td = '2017-06-13';
en = 1;
[tags, hasEphys] = getEphysTags(mn, td);
masterAlign = tags{1};

rootE = dat.expPath(mn, td, 1, 'main', 'master');
root = fileparts(rootE);

alignDir = fullfile(root, 'alignments');

%% eye alignment

eyeFolder = fileparts(dat.expFilePath(mn, td, en, 'eyetracking', 'master'));

load(fullfile(eyeFolder, 'eye_timeStamps.mat'))

alignFile = dir(fullfile(alignDir, sprintf('correct_timeline*ephys_%s.npy', masterAlign)));
b = readNPY(fullfile(alignDir, alignFile.name));

tAligned = applyCorrection(tVid, b); % will be a column after this

writeNPY(tVid(:), fullfile(eyeFolder, 'eye.timestamps_Timeline.npy'));
writeNPY(tAligned(:), fullfile(eyeFolder, 'eye.timestamps.npy'));

%% for timeline

alignFile = dir(fullfile(alignDir, sprintf('correct_timeline*ephys_%s.npy', masterAlign)));
b = readNPY(fullfile(alignDir, alignFile.name));

tlFile = dat.expFilePath(mn, td, en, 'Timeline', 'master');
load(tlFile);

kilotrodeTimelineToAFF(Timeline, b, fileparts(tlFile))

%% for electrophysiology

for t = 1:length(tags)
    ksd = getKSdir(mn, td, tags{t});
    spikeStruct = loadParamsPy(fullfile(ksd, 'params.py'));
    ss = readNPY(fullfile(ksd, 'spike_times.npy'));
    st = double(ss)/spikeStruct.sample_rate;
    
    if t>1
                
        alignFN = sprintf('correct_ephys_%s_to_ephys_%s.npy', tags{t}, masterAlign);
        b = readNPY(fullfile(alignDir, alignFN));
        
        st = applyCorrection(st, b);
        
    end
    
    writeNPY(st, fullfile(ksd, 'spikes.times.npy'));
    
end