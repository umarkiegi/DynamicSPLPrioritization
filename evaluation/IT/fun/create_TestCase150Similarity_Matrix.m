function create_TestCase150Similarity_Matrix(paths)
%create_TestCaseSimilarity_Matrix Creates a .mat file in stage dir 
% with the similarity between test cases based on the average value of all
% signals of the test cases

    % Load data
    signalDistancePath = strcat(paths.in,'\signalDistances.mat');
    load(signalDistancePath);
    
    % Initializations
    nTC150 = size(signalDistances,1);      % number of 150% test cases

    % TC Similarity (average distance) calculation
    TestCase150Similarity = zeros(nTC150,nTC150);
    for iTC=1:(nTC150-1)
        for jTC=(iTC+1):nTC150
           TestCase150Similarity(iTC,jTC) = mean(signalDistances(iTC,jTC,:));
           TestCase150Similarity(jTC,iTC) = TestCase150Similarity(iTC,jTC);
        end
    end  

    % save
    TestCase150SimilarityPath = strcat(paths.stage,'\TestCase150Similarity.mat');
    save(TestCase150SimilarityPath,'TestCase150Similarity');
    % save excel
    TestCase150SimilarityExcelPath = strcat(paths.stage,'\TestCase150Similarity.xlsx');
    xlswrite(TestCase150SimilarityExcelPath,TestCase150Similarity,'TestCase150Similarity');
    % Display
	fprintf('TC 150 percent average signal distance similarity calculated\n');
    
end