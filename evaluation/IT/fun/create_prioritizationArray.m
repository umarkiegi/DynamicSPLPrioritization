function create_prioritizationArray (paths, type) 
%create_prioritizationArray Creates a .mat file in stage dir 
% with the array of test cases (4200) prioritized statically based on defined type

    % load data
    PTCSimilarityMatrixVarName = strcat('ProductTestCaseSimilarity',type);
    ProductTestCaseSimilarityPath = strcat(paths.stage,'\',PTCSimilarityMatrixVarName,'.mat');
    load(ProductTestCaseSimilarityPath);
    
    % Initializations
    distancesMatrix = eval(PTCSimilarityMatrixVarName);
    nTestCases = size(distancesMatrix,1);
    testSuite = randperm(nTestCases); 
    testSuiteInStudy = sort(testSuite);
    
    prioritizationArray = prioritizeBasedOnDistances(distancesMatrix,testSuiteInStudy);
    
    % save
    prioritizationArrayPath = strcat(paths.stage,'\prioritizationArray',type,'.mat');
    save(prioritizationArrayPath,'prioritizationArray');
    % Display
    fprintf('Prioritization Array (%s) calculated\n',type);
    
end