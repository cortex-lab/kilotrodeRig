

function writeEphysALF(mouseName, thisDate)

useDriftmap = true;

tags = getEphysTags(mouseName, thisDate);
root = getRootDir(mouseName, thisDate);

destDir = fullfile(root, 'alf');

sp = loadAllKsDir(mouseName, thisDate);

for tg = 1:length(tags)
    thisDest = fullfile(destDir, tags{tg});
    if ~exist(thisDest, 'dir'); mkdir(thisDest); end
    
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

return;

%% demo/update all

r = listInclRecs();

for n = 1:numel(r)
    isUpdated = false;
    mouseName = r(n).mouseName; thisDate = r(n).thisDate;
    tags = getEphysTags(mouseName, thisDate);
    root = getRootDir(mouseName, thisDate);
    
    destDir = fullfile(root, 'alf');
    
    for tg = 1:numel(tags)
        thisDest = fullfile(destDir, tags{tg});
        
        if exist(fullfile(thisDest, 'spikes.clusters.npy')) && ~isUpdated
            oldClu = readNPY(fullfile(thisDest, 'spikes.clusters.npy'));
            
            ksDir = getKSdir(mouseName, thisDate, tags{tg});
            if exist(fullfile(ksDir, 'spike_clusters.npy'))
                newClu = readNPY(fullfile(ksDir, 'spike_clusters.npy'));
            else
                newClu = readNPY(fullfile(ksDir, 'spike_templates.npy'));
            end
            
            cgsFile = '';
            if exist(fullfile(ksDir, 'cluster_groups.csv'))
                cgsFile = fullfile(ksDir, 'cluster_groups.csv');
            elseif exist(fullfile(ksDir, 'cluster_group.tsv'))
                cgsFile = fullfile(ksDir, 'cluster_group.tsv');
            end
            if ~isempty(cgsFile)
                [cids, cgs] = readClusterGroupsCSV(cgsFile);
                
                noiseClusters = cids(cgs==0);
                newClu = newClu(~ismember(newClu, noiseClusters));
            end
                
            if numel(oldClu)~=numel(newClu) || any(oldClu~=newClu)
                fprintf(1, 'updating alf for %s %s\n', mouseName, thisDate);
                writeEphysALF(mouseName, thisDate);
                isUpdated = true;
                
            end
        elseif ~isUpdated % wasn't any entry at all
            fprintf(1, 'no alf found for %s %s, creating now\n', mouseName, thisDate);
            writeEphysALF(mouseName, thisDate);
            isUpdated = true;
        end
    end
end