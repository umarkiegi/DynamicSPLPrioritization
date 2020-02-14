function create_DynamicParamValues_Matrix (paths) 
%create_DynamicParamValues Creates a .mat file in stage dir 
% with the param values for multiple Dynamic Prioritization Evaluation

    % 2 dynamic parameters are required to run Multiple Dynamic Prioritization 
    % nHistory          Number of test cases we want to execute without dynamic prioritization
    % nTCReallocation   Number of test cases we consider in the dynamic prioritization
    DynamicParamValues = [1 5;1 10;1 20;1 50;1 100;1 200;5 5;5 10;5 20;5 50;5 100;5 200;10 5;10 10;10 20;10 50;10 100;10 200;20 5;20 10;20 20;20 50;20 100;20 200;50 5;50 10;50 20;50 50;50 100;50 200];
    
    % save
    DynamicParamValuesPath = strcat(paths.stage,'\DynamicParamValues.mat');
    save(DynamicParamValuesPath,'DynamicParamValues');
    % Display
    fprintf('Dynamic Param Values Matrix created\n');
    
end