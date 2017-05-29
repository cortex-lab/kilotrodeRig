
function figDir = getFigDir(mouseName, thisDate, ephysTag)

if ~isempty(ephysTag)
    ephysFolder = ['ephys_' ephysTag];
else
    ephysFolder = 'ephys';
end

figDir = fullfile('\\basket.cortexlab.net\data\nick\', ...
        mouseName, thisDate, ephysFolder);