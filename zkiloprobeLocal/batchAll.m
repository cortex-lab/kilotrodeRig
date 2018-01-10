addpath(genpath('C:\Users\Experiment\Documents\GitHub\widefield'))
addpath(genpath('C:\Users\Experiment\Documents\GitHub\Rigbox'))
addpath(genpath('C:\Users\Experiment\Documents\GitHub\alyx-matlab'))

addpath('J:\')
addpath('J:\data\')
clear tag


%%

clear all
cd('J:\data\');
mouseName = 'SS090';
thisDate = '2017-12-19';
tag = 'K1';
rootDrive = 'J:/';
ks_batch;

clear all
cd('J:\data\');
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