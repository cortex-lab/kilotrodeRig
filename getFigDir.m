
function figDir = getFigDir(mouseName, thisDate, ephysTag)

if ~isempty(ephysTag)
    ephysFolder = ['ephys_' ephysTag];
else
    ephysFolder = 'ephys';
end

if strcmp(ephysTag, 'root') % for figures that aren't within a particular probe
    figDir = fullfile('\\basket.cortexlab.net\data\nick\', ...
        mouseName, thisDate, 'figs');
else
    figDir = fullfile('\\basket.cortexlab.net\data\nick\', ...
            mouseName, thisDate, ephysFolder, 'figs');
end

if ~exist(figDir, 'dir')
    try
        mkdir(figDir); 
    catch me
        
    end
end