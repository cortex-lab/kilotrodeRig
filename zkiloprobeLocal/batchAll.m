addpath(genpath('C:\Users\Experiment\Documents\GitHub\widefield'))
addpath(genpath('C:\Users\Experiment\Documents\GitHub\Rigbox'))
addpath(genpath('C:\Users\Experiment\Documents\GitHub\alyx-matlab'))
addpath('C:\Users\Experiment\Documents\GitHub\kilotrodeRig\zkiloprobeLocal')
addpath(genpath('C:\Users\Experiment\Documents\missing-http-1.0.0')); onLoad

%% alyx login

fprintf(1, 'Login to alyx first! login window may be on the other screen\n')
ai = alyx.loginWindow;

%%

clearvars -except ai
mouseName = 'SS090';
thisDate = '2018-01-10';
tag = 'K1';
rootDrive = 'J:/';
ks_batch;

clearvars -except ai
mouseName = 'SS090';
thisDate = '2017-12-19';
tag = 'K2';
rootDrive = 'F:/';
ks_batch;

%% example SVD - andy 

% clear all
% load('J:\data\andyMasterOps.mat')
% mouseName = 'AP000';
% thisDate = '2017-00-0';
% expNums = [1];
% rootDrive = 'G:/';

% runSVDKT

% to set ROI for SVD:
% ops = svdROI(ops);

% for only blue:
% load('J:\data\andyMasterOps_blue.mat')


%% example SVD
% clear all
% load('J:\data\nickMasterOps.mat')
% mouseName = 'Kendall';
% thisDate = '2017-06-07';
% expNums = [1 2];
% rootDrive = 'J:/';
% runSVDKT

%% example kilosort
% clear all
% cd('J:\data\');
% mouseName = 'SS082';
% thisDate = '2017-11-25';
% tag = 'K1';
% rootDrive = 'J:/';
% ks_batch;

%% example kilosort remote
% clear all
% cd('J:\data\');
% mouseName = 'Moniz';
% thisDate = '2017-05-14';
% tag = 'M2';
% ks_batch_remote;