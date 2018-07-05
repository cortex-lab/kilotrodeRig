

function [nU, nUbyArea] = numUnits(varargin)
% nU is two elements: non-mua, and all

[acr, d] = listInclArea();
r = listInclRecs();

nU = [0 0];
for n = 1:numel(r)
    mouseName = r(n).mouseName; thisDate = r(n).thisDate;
    tags = getEphysTags(mouseName, thisDate);
    
    fprintf(1, '%s, %s\n', mouseName, thisDate);
    
    for tg = 1:numel(tags)
        ad = getALFdir(mouseName, thisDate, tags{tg});
        
        
        cgs = readNPY(fullfile(ad, 'clusters.groups.npy'));
        cids = readNPY(fullfile(ad, 'clusters.ids.npy'));
        clu = readNPY(fullfile(ad, 'spikes.clusters.npy'));
        
        clu = clu(ismember(clu, cids(cgs>0)));
        nU(1) = nU(1)+numel(unique(clu));
        clu = clu(ismember(clu, cids(cgs>1)));
        nU(2) = nU(2)+numel(unique(clu));
        
        if nargout>1
            %cdep = readNPY(fullfile(ad, 'clusters.depths.npy'));
        end
    end
end

        