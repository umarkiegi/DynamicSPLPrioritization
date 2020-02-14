function prioritizedTestSuite = prioritizeBestCase(mutantsTable,testsToPrioritize)
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here
    numberOfMutants = size(mutantsTable,2);
    numberOfTC = size(testsToPrioritize,2);
    coveredMutants = zeros(1,numberOfMutants);
    %prioritizedTestSuite = testsToPrioritize;
    
    for jj=1:numberOfTC
        numOfCoveredMutants = sum(coveredMutants);
        idx = 1;
        for ii=1:size(testsToPrioritize,2)
            detectedMutantsByTC = mutantsTable(testsToPrioritize(ii),:);
            covMutants = or(coveredMutants, detectedMutantsByTC);
            if sum(covMutants) > numOfCoveredMutants
                numOfCoveredMutants = sum(covMutants);
                idx = ii;
            end        
        end
        coveredMutants = or(coveredMutants ,  mutantsTable(testsToPrioritize(idx),:));
        prioritizedTestSuite(jj)=testsToPrioritize(idx);
        testsToPrioritize(idx) = [];
    end
end

