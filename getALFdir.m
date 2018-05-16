
function alfDir = getALFdir(mouseName, thisDate, varargin)
% function alfDir = getALFdir(mouseName, thisDate[, ephysTag])

root = getRootDir(mouseName, thisDate);

% rootE = dat.expPath(mouseName, thisDate, 1, 'main', 'master');
% root = fileparts(rootE);
alfDir = fullfile(root, 'alf');

if ~isempty(varargin)
    alfDir = fullfile(alfDir, varargin{1});
end

if ~exist(alfDir, 'dir')
    warning('no alf dir at %s', alfDir)
end

