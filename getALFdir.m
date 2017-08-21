
function alfDir = getALFdir(mouseName, thisDate, varargin)
% function alfDir = getALFdir(mouseName, thisDate[, ephysTag])

rootE = dat.expPath(mouseName, thisDate, 1, 'main', 'master');
root = fileparts(rootE);

alfDir = fullfile(root, 'alf');

if ~isempty(varargin)
    alfDir = fullfile(alfDir, varargin{1});
end

if ~exist(alfDir, 'dir')
    error('alfDir not found! at %s\n', alfDir);
end