%what I did was just use the preproc_getOption.m script
%Run it to create the opt. structure. 
%then just run 
opt = preproc_getOption();

%and then, in matlab command window; 
%run the step that I want, i.e. bidsSpatialPrepro(opt);

%------------------------------------------------------------

% This script will download the dataset from the FIL for the block design SPM tutorial
% and will run the basic preprocessing.
%
% (C) Copyright 2019 Remi Gau

clear; 
clc;

warning('off');

try
run lib/CPP_SPM/initCppSpm.m;
catch
end

opt = preproc_getOption_localizer();

reportBIDS(opt);

bidsCopyRawFolder(opt);

% In case you just want to run segmentation and skull stripping
% NOTE: skull stripping is also included in 'bidsSpatialPrepro'
% bidsSegmentSkullStrip(opt);

bidsSTC(opt);

bidsSpatialPrepro(opt);

%anatomicalQA(opt);

bidsResliceTpmToFunc(opt);

% DOES NOT WORK
% functionalQA(opt);

% create a whole brain functional mean image mask
% so the mask will be in the same resolution/space as the functional images
% one may not need it if they are running bidsFFX
% since it creates a mask.nii by default
% NEEDS DEBUGGING
% opt.skullstrip.mean = 1;
mask = bidsWholeBrainFuncMask(opt);

bidsSmoothing(opt);
