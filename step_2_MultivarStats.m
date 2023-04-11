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

%% define sub and model to work on

subject_label = {'05'};

task = 'Vis'; %'Aud' or 'Vis'
modelization = 'speak'; %'vow', 'cons', 'speak' or 'trialbytrial'

if strcmp(task,'Aud')
    if strcmp(modelization,'cons')
        model_file = fullfile(this_dir, 'models', 'model-MVPAAud-cons.json');
    elseif strcmp(modelization,'vow')
        model_file = fullfile(this_dir, 'models', 'model-MVPAAud-vowels.json');
    elseif strcmp(modelization, 'speak')
        model_file = fullfile(this_dir, 'models', 'model-MVPAAud-speak.json');
    elseif strcmp(modelization,'trialbytrial')
        model_file = fullfile(this_dir, 'models', 'model-MVPAAud-trialbytrial.json');
    end 
elseif strcmp(task,'Vis')
    if strcmp(modelization,'cons')
        model_file = fullfile(this_dir, 'models', 'model-MVPAVis-cons.json');
    elseif strcmp(modelization,'vow')
        model_file = fullfile(this_dir, 'models', 'model-MVPAVis-vowels.json');
    elseif strcmp(modelization,'speak')
        model_file = fullfile(this_dir, 'models', 'model-MVPAVis-speak.json');
    elseif strcmp(modelization,'trialbytrial')
        model_file = fullfile(this_dir, 'models', 'model-MVPAVis-trialbytrial.json');
    end 
end


%% run bidspm 

%opt. pour changer des options
%par exemple si on veut ajouter des options pour les résultats :
%opt.results.xxxx (see documentation)

%+ 'options', opt, .... dans bidspm command 

bidspm(bids_dir, output_dir, 'subject', ...
       'participant_label', subject_label, ...
       'action', 'stats', ...
       'preproc_dir',preproc_dir,...
       'model_file',model_file,...
       'concatenate', true, ...
       'space', {'individual', 'IXI549Space'},...
       'fwhm', 2);   

   %task is specified in the model so we can remove from the command. If
   %not the same, probably the task specified in the model would be
   %priority 
   
   
   
%'action', 'contrasts', ... %to run only the contrasts and not the
%statistical values


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
