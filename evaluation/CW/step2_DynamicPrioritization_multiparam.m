% Clear workspace, globals, console, mex and close open models without saving
clearvars; clearvars -global; clc;  % Clear workspace, globals, console
cd(strcat(pwd,'\fun\tools'));
paths = managePaths;                % Directory paths definitions
cleanOutDir(paths);                 % Delete and recreate OutDir
disableWarnings;

%%% INPUT
nProducts = 28;
nTC150 = 150;
type = 'WAS';    % label for output file naming
version = 'v1';
%%%

% Load data
DynamicParamValuesPath = strcat(paths.stage,'\DynamicParamValues.mat');
load(DynamicParamValuesPath); clear DynamicParamValuesPath;
mutantsTable = xlsread('mutantsMatrix36.xlsx');

% Initializations
nParam = size(DynamicParamValues,1);
%prioritizationArrayFilename = strcat('prioritizationArray',type,'_',version);
prioritizationArrayFilename = 'prioritizationArrayRandom';

for iParam=1:nParam

    load(prioritizationArrayFilename);

    inHistory = DynamicParamValues(iParam,1);
    inTCReallocation = DynamicParamValues(iParam,2);
    
    dp = DynamicPrioritization(inHistory,inTCReallocation,nProducts,nTC150,mutantsTable);
    
    staticallyPrioritizedTestSuite = prioritizationArray;
    dp.staticallyPrioritizedArray = staticallyPrioritizedTestSuite;
    prioritizationArray = dp.dynamicallyPrioritizeTestSuite();
    [APFDDynamicPrio, NTEDynamicPrio] = calculateMetrics(mutantsTable, prioritizationArray);
    [APFDStaticPrio, NTEStaticPrio] = calculateMetrics(mutantsTable, staticallyPrioritizedTestSuite);
    
    results(iParam,1) = APFDStaticPrio;
    results(iParam,2) = APFDDynamicPrio;
    results(iParam,3) = NTEStaticPrio;
    results(iParam,4) = NTEDynamicPrio; 
    
end

% save
results = [DynamicParamValues results];
resultsPath = strcat(paths.out,'\results',type,'_',version,'.mat');
save(resultsPath,'results');
% save Excel
resultsExcelPath = strcat(paths.out,'\results',type,'_',version,'.xlsx');
resultsTable = array2table(results,'VariableNames',...
                        {'nHistory','nTCReallocation','APFDStaticPrio',...
                        'APFDDynamicPrio','NTEStaticPrio','NTEDynamicPrio'});
writetable(resultsTable,resultsExcelPath,'Sheet',type)
            %xlswrite(resultsExcelPath,results,type);

% Display
fprintf('Multiple Dynamic Prioritization calculated \n');

