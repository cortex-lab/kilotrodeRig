

function condNums = getBlockCondNums(parameters, cond)
% Return the index of the condition number for each trial

nTr = length(cond);

fc = fieldnames(cond);

q = struct2cell(cond);
q2 = q(~strcmp(fc, 'repeatNum'), :,:);
q3 = vertcat(q2{:});
condsByTr = reshape(q3, [], nTr);
nPars = size(condsByTr,1);

fp = fieldnames(parameters);

q = struct2cell(parameters);
q2 = q(ismember(fp, fc), :,:);
nConds = size(q2{1},2);
q3 = vertcat(q2{:});
condsByPar = reshape(q3, [], nConds);

% and if that wasn't complicated enough, now this: bsxfun compares each X 
% (which will be one column of condsByTr, i.e. the
% cond for a particular trial) to each column of condsByPar. The matching
% one is the one for which all of them match, i.e. the sum is nPars. Find
% that entry. 
condNums = cellfun(@(x)find(sum(bsxfun(@eq, condsByPar, x))==nPars), num2cell(condsByTr,1));