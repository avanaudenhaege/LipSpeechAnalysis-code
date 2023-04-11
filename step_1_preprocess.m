% (C) Copyright 2019 bidspm developers

%%% Script for preprocessing pipeline with bidspm()
%%% to run, needs bidspm() installed and path added and saved. 

clear;
clc;

%% initialize bidspm() for this matlab session
% addpath(/Applications/bidspm);
bidspm();

%% set up BIDS folders and paths
this_dir = fileparts(mfilename('fullpath'));
root_dir = fullfile(this_dir, '..');

bids_dir = fullfile(root_dir);
output_dir = fullfile(root_dir, 'derivatives');

%% define subjects and tasks to preprocess
subject_label = {'05'};
task_list = {'MVPAAud'}; % PhonoLoc - VisLoc - MVPAVis - MVPAAud - TVSALoc

%% run for all tasks in the list

for t = 1:length(task_list) 
    task_label = task_list(t) ;
    
    bidspm(bids_dir, output_dir, 'subject', ...
       'participant_label', subject_label, ...
       'action', 'preprocess', ...
       'task', task_label, ...
       'ignore', {'qa'}, ... 
       'space', {'individual', 'IXI549Space'}, ...
       'fwhm', 6);
    if strncmp(task_label, 'MVPA', 4)
        bidspm(bids_dir, output_dir, 'subject', ...
       'participant_label', subject_label, ...
       'action', 'smooth', ...
       'task', task_label, ...
       'space', {'individual', 'IXI549Space'},...
       'ignore',{'qa'}, ...
       'fwhm', 2);
    end
        
end 

