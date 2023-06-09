% (C) Copyright 2020 Remi Gau, Marco Barilari

function opt = preproc_getOption()
%
% returns a structure that contains the options chosen by the user to run
% slice timing correction, pre-processing, subject and group level analysis.
%
% for more info see:
% <https://cpp-bids-spm.readthedocs.io/en/latest/set_up.html#configuration-of-the-pipeline>
% <https://cpp-bids-spm.readthedocs.io/en/latest/defaults.html#checkoptions>

if nargin < 1
    opt = [];
end

% If the following fields are left empty then all subjects will be analyzed.
opt.groups = {''};
% opt.subjects = {[]};
%
opt.subjects = {'04'};

opt.taskName = 'MVPAAud';
opt.verbosity = 1;

WD = '/Users/alice/Documents/DATA/LipSpeechPilot_analysis/LipSpeech_BIDS';

opt.dataDir = '/Users/alice/Documents/DATA/LipSpeechPilot_analysis/LipSpeech_BIDS'; 

opt.derivativesDir = '/Users/alice/Documents/DATA/LipSpeechPilot_analysis/LipSpeech_BIDS/derivatives/bidspm-preproc';

opt.pipeline.type = 'preproc';

% The directory where the data are located
% opt.dataDir = [];
% You can specify where you want the data to be saved if the default location
% does not suit you.
% opt.derivativesDir = ''

% If you use 'individual', then we stay in native space (that of the anat image)
% set to 'MNI' to normalize data
opt.space = 'IXI549Space';

% % specify the model file that contains the contrasts to compute
% opt.model.file =  fullfile('C:\Users\filip\Documents\Gin\VisualBraille\analysis\code', ...
%                             'model', 'model-visualLocalizer_smdl.json');


%% DO NOT TOUCH
opt = checkOptions(opt);
saveOptions(opt);

end
