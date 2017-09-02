
function [tags, hasEphys] = getEphysTags(mouseName, thisDate)
% function [tags, hasEphys] = getEphysTags(mouseName, thisDate)

rootE = dat.expPath(mouseName, thisDate, 1, 'main', 'master');
root = fileparts(rootE);

% determine whether there is ephys and if so what tags
d = dir(fullfile(root, 'ephys*'));

clear tags

if numel(d)==1 && strcmp(d.name, 'ephys')
    tags = {[]};
    hasEphys = true;
elseif numel(d)>=1
    for q = 1:numel(d)
        tags{q} = d(q).name(7:end);
    end
    hasEphys = true;
else
    tags = {[]};
    hasEphys = false;
end