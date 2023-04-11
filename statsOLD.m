%% Stats

bids_dir = '/Users/alice/Documents/DATA/signVWFA_analysis/signVWFA_BIDS';

output_dir = '/Users/alice/Documents/DATA/signVWFA_analysis/signVWFA_BIDS/derivatives';

preproc_dir= '/Users/alice/Documents/DATA/signVWFA_analysis/signVWFA_BIDS/derivatives/bidspm-preproc';
subject_label = 'HLS03';
% model_file='/Users/alice/Documents/DATA/signVWFA_analysis/signVWFA_BIDS/code/model-loc.json';
% model_file='/Users/alice/Documents/DATA/signVWFA_analysis/signVWFA_BIDS/code/model-signMVPA.json';
model_file='/Users/alice/Documents/DATA/signVWFA_analysis/signVWFA_BIDS/code/model-signMVPAtrialByTrial.json';

% 
% bidspm(bids_dir, output_dir, 'subject', ...
%        'participant_label', {subject_label}, ...
%        'action', 'stats', ...
%        'preproc_dir',preproc_dir,...
%        'model_file',model_file,...
%        'task', {'signMVPA'}, ...
%       'space', {'individual', 'IXI549Space'},...
%        'fwhm', 2);        
%    
   %'action', 'contrasts', ... %to run only the contrasts
   bidspm(bids_dir, output_dir, 'subject', ...
       'participant_label', subject_label, ...
       'action', 'contrasts', ...
       'preproc_dir',preproc_dir,...
       'model_file',model_file,...
       'task', {'signMVPA'}, ...
       'concatenate', true, ...
       'space', {'individual', 'IXI549Space'},...
       'fwhm', 2);