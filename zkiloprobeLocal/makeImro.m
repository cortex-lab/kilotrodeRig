
filename = 'evenOddConfig.imro';
 
chanNums = 0:383; 
apGains = 500*ones(size(chanNums)); 
lfpGains = 250*ones(size(chanNums));
bankID = mod(chanNums,2);
refID = zeros(size(chanNums));

probeID = 503970728;
probeOpt = 3;
probeNChans = 384;

fid = fopen(filename, 'w');

fprintf(fid, '(%d,%d,%d)', probeID, probeOpt, probeNChans);

for c =1:length(chanNums)
    fprintf(fid, '(%d %d %d %d %d)', chanNums(c), bankID(c), refID(c), apGains(c), lfpGains(c));
end

fclose(fid);