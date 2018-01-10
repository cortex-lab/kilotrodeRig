
cd('J:\data\');
%script for running Kilosort

% remote version assumes data file is already CAR and is located on
% zserver/Data/Subjects, and that no movements of files need to happen
% other than KS results. 

%%
% mouseName = 'M160731_MOEC';
% thisDate = datestr(now, 'yyyy-mm-dd');
% thisDate = '2016-09-05';
% if ~exist('tag')
%     fnBase = [mouseName '_' thisDate '_g0_t0.imec.'];
% else
%     fnBase = [mouseName '_' thisDate '_' tag '_g0_t0.imec.'];
% end

zserverDrive = '\\zserver.cortexlab.net\data2\';
basketDrive = '\\basket.cortexlab.net\data\';


if ~exist('tag')
    zserverDest = fullfile(zserverDrive, 'Subjects', mouseName, thisDate, 'ephys');
    
    % update 2017-05-16 - nothing goes to basket anymore, sorting results
    % to zserver instead
    basketDest = fullfile(zserverDrive, 'Subjects', mouseName, thisDate, 'ephys', 'sorting');
%     basketDest = fullfile(basketDrive, 'nick', mouseName, thisDate, 'ephys');
else
    zserverDest = fullfile(zserverDrive, 'Subjects', mouseName, thisDate, ['ephys_' tag]);
    
    % update 2017-05-16 - nothing goes to basket anymore, sorting results
    % to zserver instead
    basketDest = fullfile(zserverDrive, 'Subjects', mouseName, thisDate, ['ephys_' tag], 'sorting');
%     basketDest = fullfile(basketDrive, 'nick', mouseName, thisDate, ['ephys_' tag]);
end

%% get filename

zsd = dir(fullfile(zserverDest, '*_CAR.bin'));

%% parameters

ops.chanMap = 'forPRBimecP3opt3.mat';
ops.NchanTOT = 385;
ops.Nfilt = 960;

ops.root = fullfile('J:\data', mouseName, thisDate);
mkdir(ops.root)

% fn = fullfile(ops.root, [fnBase 'ap_CAR.bin']);
fn = fullfile(ops.root, zsd.name);


fprintf(1, 'copying file to local drive\n');
% copyfile(fullfile(zserverDest, [fnBase 'ap_CAR.bin']), ops.root);
copyfile(fullfile(zserverDest, zsd.name), ops.root);

fprintf(1, 'done copying\n');

load(ops.chanMap);

ops.fbinary = fn;



%% then run KS
ks_master_file;
fclose('all')
%% then copy to server
tic


% npy files go to basket
mkdir(basketDest)
fprintf(1, 'moving npy to basket\n');
movefile(fullfile(ops.root, '*.npy'), basketDest);
movefile(fullfile(ops.root, 'params.py'), basketDest);
movefile(fullfile(ops.root, 'rez.mat'), basketDest);
toc


%% delete local files
% rmdir(ops.root, 's');
if length(dir(ops.root))==2 % empty folder
    cd(fileparts(ops.root));
    rmdir(ops.root);
end

fprintf(1, 'done!\n');
toc