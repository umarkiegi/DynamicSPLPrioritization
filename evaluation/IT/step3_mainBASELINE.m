% Clear workspace, globals, console, mex and close open models without saving
clearvars; clearvars -global; clc;  % Clear workspace, globals, console
cd(strcat(pwd,'\fun\tools'));
paths = managePaths;                % Directory paths definitions
cleanOutDir(paths);                 % Delete and recreate OutDir
disableWarnings;

% load data
productTestCaseSimilarityPath = strcat(paths.stage,'\productTestCaseSimilarityWAS');
load(productTestCaseSimilarityPath);
mutantsTable = xlsread('mutantsMatrix30.xlsx');

% Initializations
prodAndTestCaseSimilarity = ProductTestCaseSimilarityWAS;
nTestCases = 2250;
testSuite = randperm(nTestCases);
testSuiteInStudy = sort(testSuite);

% BASELINE
tic;
prioritizationArrayBASELINE = prioritizeBasedOnDistancesBASELINE(prodAndTestCaseSimilarity, testSuiteInStudy);
[APFDInputDistanceBASELINE, NTEInputDistanceBASELINE] = calculateMetrics(mutantsTable, prioritizationArrayBASELINE);
distancesTime = toc; %300s aprox

% Best & Worst
prioritizationArrayBEST = prioritizeBestCase(mutantsTable, testSuiteInStudy);
[APFDBestCase, NTEBestCase] = calculateMetrics(mutantsTable, prioritizationArrayBEST);

prioritizationArrayWORST = prioritizeWorstCase(mutantsTable, testSuiteInStudy);
[APFDWorstCase, NTEWorstCase] = calculateMetrics(mutantsTable, prioritizationArrayWORST);



%save prioritizationArrayBASELINE
prioritizationArrayBASELINEPath = strcat(paths.out,'\prioritizationArrayBASELINE.mat');
save(prioritizationArrayBASELINEPath,'prioritizationArrayBASELINE');

%save results
results = [APFDInputDistanceBASELINE NTEInputDistanceBASELINE];
resultsExcelPath = strcat(paths.out,'\resultsBASELINE.xlsx');
resultsTable = array2table(results,'VariableNames',...
                        {'APFD','NTE'});
writetable(resultsTable,resultsExcelPath,'Sheet','BASELINE')
