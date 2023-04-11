% (C) Copyright 2019 bidspm developers

%%% Script for statistical univariate analysis with bidspm()
%%% to run, needs bidspm() installed and path added and saved. 
clear;
clc;

%% initialize bidspm() for this matlab session
%addpath(/Applications/bidspm);
bidspm();

%% set up BIDS folders and path
this_dir = fileparts(mfilename('fullpath'));

root_dir = fullfile(this_dir, '..');
bids_dir = fullfile(root_dir);
output_dir = fullfile(root_dir, 'derivatives');
preproc_dir = fullfile(root_dir, 'derivatives', 'bidspm-preproc');

model_file = fullfile(this_dir, 'models', 'model-TVSALoc.json');
%model_file = fullfile(this_dir, 'models', 'model-VisLoc.json');
%%model_file = fullfile(this_dir, 'models', 'model-PhonoLoc.json');
%model_file = fullfile(this_dir, 'models', 'model-MVPAAud.json');
%model_file = fullfile(this_dir, 'models', 'model-MVPAVis.json');

%% define subjects and tasks to analyze
subject_label = {'06'}; %can write several subj {'04', '05'}
%task_label = {'VisLoc'}; % PhonoLoc - VisLoc - MVPAVis - MVPAAud

%% define results saved as output

results.nodeName = 'subject_level';
%results.name = {'face_gt_others', 'word_gt_others', 'house_gt_others'};
%results.name = {'SYL_gt_SCR', 'SCR_gt_SYL'};
results.name = {'VL_gt_NL', 'NL_gt_VL'};
results.png = true();
results.csv = true();
results.montage.do = true();
results.montage.slices = -10:2:10;
results.montage.orientation = 'axial';
results.montage.background = struct('suffix', 'T1w', ...
                                    'desc', 'preproc', ...
                                    'modality', 'anat');
%(add opt.results parameters to choose contrasts/corrections..)                                 
opt.results = results;



bidspm(bids_dir, output_dir, 'subject', ...
       'participant_label', subject_label, ...
       'action', 'stats', ...
       'preproc_dir', preproc_dir, ...
       'model_file', model_file, ...
       'space', {'individual', 'IXI549Space'}, ...
       'fwhm', 6, ...
       'options', opt);
       
%'action', 'contrasts', ... %to run only the contrasts


% % %% dataset level
% % 
% % opt.results = struct('nodeName',  'dataset_level', ...
% %                      'name', {{'VisMot_gt_VisStat'}}, ...
% %                      'Mask', false, ...
% %                      'MC', 'none', ...
% %                      'p', 0.05, ...
% %                      'k', 10, ...
% %                      'NIDM', true);
% % 
% % bidspm(bids_dir, output_dir, 'dataset', ...
% %        'action', 'stats', ...
% %        'preproc_dir', preproc_dir, ...
% %        'model_file', model_file, ...
% %        'options', opt);
