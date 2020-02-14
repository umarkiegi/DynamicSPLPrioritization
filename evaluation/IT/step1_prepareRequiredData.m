% Clear workspace, globals, console, mex and close open models without saving
clearvars; clearvars -global; clc;  % Clear workspace, globals, console
cd(strcat(pwd,'\fun\tools'));
paths = managePaths;                % Directory paths definitions
disableWarnings;

%%% INPUT
Wp = 0.5;
Wtc = 0.5;
type = 'WCS'; %type = 'WAS';
%version = 'v1'; % DO NOT USE v2
nTC = 2550;
nProducts = 17;
%%%

% STEP1 - Create Product Similiarity Matrix based on features (Al-Hajjaji)
% create_ProductSimilarity_Matrix(paths,nProducts);

% STEP2 - Create TestCase 150% Similarity Matrix based on average signal distances 
% create_TestCase150Similarity_Matrix(paths);

% STEP3 - Create Product and Test Case Similarity Matrix
%         based on Weighted All Signal (WAS) distances
% create_ProductTestCaseSimilarityWAS_Matrix(paths,Wp,Wtc);

% STEP4 - Create Product and Test Case Similarity Matrix >>> TIME COSTLY
%         based on Weighted CONTAINED Signals (WCS) distances
% create_ProductTestCaseSimilarityWCS_Matrix(paths,Wp,Wtc);

% STEP5 - Create prioritizationArray
%         Create array with test cases prioritizated STATICLY (1x4200)
%         OPTIONS: Select between availble matrices (WAS, WCS, etc.)
% create_prioritizationArray(paths,type);

% STEP6 - Create DynamicParamValues Matrix
% create_DynamicParamValues_Matrix(paths);