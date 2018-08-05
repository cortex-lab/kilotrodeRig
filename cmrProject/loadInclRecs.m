

function r = loadInclRecs(varargin)

if nargin>0
    if any(ismember(varargin, 'noWF')); noWF = true; else; noWF = false; end
    if any(ismember(varargin, 'noSpDetail')); noSpAD = true; else; noSpAD = false; end
end
    

r = listInclRecs();

for n = 1:numel(r)
    mouseName = r(n).mouseName; thisDate = r(n).thisDate;     
    tags = getEphysTags(mouseName, thisDate);
    clear spIn
    for tg = 1:numel(tags)
        fprintf(1, ' loading %s %s %s\n', mouseName, thisDate, tags{tg});
        [sp, cweA, cwtA, moveData, lickTimes, passiveStim] = alf.loadCWAlf(mouseName, thisDate, tags{tg});
        if noWF; sp.waveforms = []; end
        if noSpAD; sp.spikeAmps = []; sp.spikeDepths = []; end
        if tg==1; spIn=sp; else spIn(tg)=sp; end
    end
    sp = combineSp(spIn);
    clear spIn    
    r(n).sp = sp; 
    r(n).cweA = cweA; 
    r(n).cwtA = cwtA; 
    r(n).moveData = moveData;
    r(n).lickTimes = lickTimes;
    r(n).passiveStim = passiveStim;
end
