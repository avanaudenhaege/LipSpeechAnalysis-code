%% Stats

%% Section 1: define which task and analysis you want to run
%task=1; %  1==loc
task=2; %  2==signMVPA

analysis_type=1; %1==univariate
%analysis_type=2; %2==multivariate (this is only possible for task=2 - signMVPA)

%this parts are only relevant for multivariate analyses and will not be used
%for univariate once
actor_type=1; %1==actor_merged
%actor_type=2; %2==actor_separated

%which_sign=1; %all signs and non-signs
which_sign=2; %only meaningful signs

%% Section 2:define all the paths for data/models

%This  is the main folder of  the bids project
bids_dir = fileparts(cd);

%This is normally a folder named "derivatives" where all the processed
%data go
output_dir = fullfile(bids_dir,'derivatives');

%This is the folder where the preproccessed data are stored
preproc_dir= fullfile(bids_dir,'derivatives/bidspm-preproc');

subject_label = {'HNS01','HNS02','HLS01','HLS02','HLS03'};

%% Section 3: select the correct model (jason file)  to use to build the design matrix and to estimate the beta values and the contrasts
if task==1 %loc
    model_file=fullfile(bids_dir,'code/model-loc.json'); %this is the model
elseif task==2 %signMVPA
    if analysis_type==1 % univariate
        model_file=fullfile(bids_dir,'code/model-signMVPAuni.json');
    elseif analysis_type==2  %multivariate
        if actor_type==1 && which_sign==1  %actor_merged and all stimuli
            model_file=fullfile(bids_dir,'code/model-signMVPA_actorMERGED.json');  %this is the model
        elseif actor_type==1 && which_sign==2  %actor_merged and only meaningful stimuli
            model_file=fullfile(bids_dir,'code/model-signMVPA_actorMERGED_onlyMeaningfull.json');  %this is the model
        elseif actor_type==2 %actor_separated
            model_file=fullfile(bids_dir,'code/model-signMVPA_actorSEPARATED.json');
        end
    end
end

%% Section 4:  run the stats to build the design matrix, to extracct the beta values and to compute the contrasts (and the 4D files for multivariate analyses)
if task==1 %loc
    bidspm(bids_dir, output_dir, 'subject', ...
        'participant_label', (subject_label), ...
        'action', 'stats', ...
        'preproc_dir',preproc_dir,...
        'model_file',model_file,...
        'task', {'loc'}, ...
        'space', {'individual', 'IXI549Space'},...
        'fwhm', 6);
elseif task==2 %signMVPA
    if analysis_type==1 % univariate
        
        bidspm(bids_dir, output_dir, 'subject', ...
            'participant_label', (subject_label), ...
            'action', 'stats', ...
            'preproc_dir',preproc_dir,...
            'model_file',model_file,...
            'task', {'signMVPA'}, ...
            'space', {'individual', 'IXI549Space'},...
            'fwhm', 6);
    elseif analysis_type==2  %multivariate
        bidspm(bids_dir, output_dir, 'subject', ...
            'participant_label', (subject_label), ...
            'action', 'stats', ...
            'preproc_dir',preproc_dir,...
            'model_file',model_file,...
            'task', {'signMVPA'}, ...
            'concatenate', true, ...
            'space', {'individual', 'IXI549Space'},...
            'fwhm', 2);
    end
end





% 'design_only', true; ... %to run only the design matrix part
%'action', 'contrasts', ... %to run only the contrasts

