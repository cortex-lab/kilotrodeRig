
cd('J:\data\');
%script for running Kilosort

%%
% mouseName = 'M160731_MOEC';
% thisDate = datestr(now, 'yyyy-mm-dd');
% thisDate = '2016-09-05';
if ~exist('tag')
    fnBase = [mouseName '_' thisDate '_g0_t0.imec.'];
    fnBase1 = [mouseName '_' thisDate '_g1_t0.imec.'];
else
    fnBase = [mouseName '_' thisDate '_' tag '_g0_t0.imec.'];
    fnBase1 = [mouseName '_' thisDate '_' tag '_g1_t0.imec.'];
end
%% parameters


ops.chanMap = 'forPRBimecP3opt3.mat';
ops.NchanTOT = 385;
ops.Nfilt = 960;

if ~exist(rootDrive)
    rootDrive = 'J:/'; % now need this parameter
end

ops.root = fullfile(rootDrive, 'data', mouseName, thisDate);

% basketDrive = 'Z:\';
% zserverDrive = 'X:\';
% lugaroDrive = 'Y:\';
basketDrive = '\\basket.cortexlab.net\data\';
zserverDrive = '\\zserver.cortexlab.net\data2\';
lugaroDrive = '\\lugaro.cortexlab.net\bigdrive\staging\';
lugaroDrive2 = '\\lugaro.cortexlab.net\bigdrive\toarchive\';

if ~exist('tag')
    zserverDest = fullfile(zserverDrive, 'Subjects', mouseName, thisDate, 'ephys');
%     basketDest = fullfile(basketDrive, 'nick', mouseName, thisDate, 'ephys');

    % update 2017-05-16 - nothing goes to basket anymore, sorting results
    % to zserver instead
    basketDest = fullfile(zserverDrive, 'Subjects', mouseName, thisDate, 'ephys', 'sorting');
    lugaroDest = fullfile(lugaroDrive, [mouseName '_' thisDate '_ephys']);
else
    zserverDest = fullfile(zserverDrive, 'Subjects', mouseName, thisDate, ['ephys_' tag]);
%     basketDest = fullfile(basketDrive, 'nick', mouseName, thisDate, ['ephys_' tag]);

    % update 2017-05-16 - nothing goes to basket anymore, sorting results
    % to zserver instead
    basketDest = fullfile(zserverDrive, 'Subjects', mouseName, thisDate, ['ephys_' tag], 'sorting');
    lugaroDest = fullfile(lugaroDrive, [mouseName '_' thisDate '_ephys_' tag]);
end

%% deal with special case where I recorded g0 and g1 
% Assume I want the g0 to go to 

if exist(fullfile(ops.root, [fnBase1 'ap.bin']))
    fprintf(1, 'found g1, so moving g0 first.\n')
    
    mkdir(zserverDest);
    mkdir(fullfile(zserverDest, 'lfpRF'));
    d = dir(fullfile(ops.root, '*g0*'));
    for dind = 1:length(d)
        movefile(fullfile(ops.root, d(dind).name), fullfile(zserverDest, 'lfpRF'));
    end

    fnBase = fnBase1;
end

%%
fn = fullfile(ops.root, [fnBase 'ap.bin']);

load(ops.chanMap);

ext = fn(end-2:end);
fnAfterCAR = [fn(1:end-4) '_CAR.' ext];

ops.fbinary = fnAfterCAR;

%% cut file if necessary

if exist('maxSample')
    cutFile(fn, ops.NchanTOT, maxSample);
end

%% first perform CAR

addpath('J:\data\');
tic
medianTrace = applyCARtoDat(fn, ops.NchanTOT);
toc
fclose('all');

%% raw goes to toarchive
fprintf(1, 'moving raw to lugaro\n');
tic
mkdir(lugaroDest);
movefile(fullfile(ops.root, [fnBase 'ap.bin']), lugaroDest);
toc
fprintf(1, 'copying to lugaro''s toarchive\n');
tic
movefile(lugaroDest, lugaroDrive2);
toc

%% then run KS
ks_master_file;
fclose('all');

%% then copy to server
tic

% npy files go to basket
mkdir(basketDest)
fprintf(1, 'moving npy to basket\n');
movefile(fullfile(ops.root, '*.npy'), basketDest);
movefile(fullfile(ops.root, 'params.py'), basketDest);
movefile(fullfile(ops.root, 'rez.mat'), basketDest);
toc
%% afterCAR (along with LFP, meta, median) goes to zserver
mkdir(zserverDest);
fprintf(1, 'moving CAR to zserver\n');
pause(1.0);
try
    movefile(fnAfterCAR, zserverDest);
catch
    warning('COULD NOT MOVE %s TO ZSERVER!!!', fnAfterCAR);
end
toc

%%
fprintf(1, 'moving other to zserver\n');
movefile(fullfile(ops.root, [fnBase 'ap.meta']), zserverDest);
movefile(fullfile(ops.root, [fnBase 'ap_medianTrace.mat']), zserverDest);
movefile(fullfile(ops.root, [fnBase 'lf.bin']), zserverDest);
movefile(fullfile(ops.root, [fnBase 'lf.meta']), zserverDest);
toc


if length(dir(ops.root))==2 % empty folder
    cd(fileparts(ops.root));
    rmdir(ops.root);
end

fprintf(1, 'done!\n');
toc