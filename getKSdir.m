

function ksDir = getKSdir(mouseName, thisDate, ephysTag)

% first look in zserver
% rootE = dat.expPath(mouseName, thisDate, 1, 'main', 'master');
% root = fileparts(rootE);
root = getRootDir(mouseName, thisDate);

if ~isempty(ephysTag)
    ephysFolder = ['ephys_' ephysTag];
else
    ephysFolder = 'ephys';
end

ksDir = fullfile(root, ephysFolder, 'sorting');
if exist(fullfile(ksDir, 'spike_times.npy'), 'file')
    return;
else
    ksDir = fullfile('\\basket.cortexlab.net\data\nick\', ...
        mouseName, thisDate, ephysFolder);
    if exist(fullfile(ksDir, 'spike_times.npy'), 'file')
        return;
    else
        ksDir = fullfile('\\basket.cortexlab.net\data\nick\', ...
            mouseName, thisDate);
        if exist(fullfile(ksDir, 'spike_times.npy'), 'file')
            return;
        else
            fprintf('could not find ksDir\n');
        end
    end
end
