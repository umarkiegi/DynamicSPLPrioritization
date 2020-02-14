function [prioritizedTestSuite] = prioritizeBasedOnDistances(distanceMatrix, testsToPrioritize)
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here
    numberOfTestCases = size(testsToPrioritize,2);
    prioritizedTestSuite(1) = testsToPrioritize(1);
    testsToPrioritize(1) = [];
    %takeFarthest(prioritizedTestSuite, testsToPrioritize, distanceMatrix);
    for ii=2:numberOfTestCases
        idx = takeFarthest(prioritizedTestSuite, testsToPrioritize, distanceMatrix);
        prioritizedTestSuite(ii) = testsToPrioritize(idx);
        testsToPrioritize(idx) = [];
        if mod(ii,50)==0
            fprintf('\n %s \n',num2str(ii));
        end
    end

end

function farthestTestIndex = takeFarthest(prioritizedTestSuite, testsToPrioritize, distanceMatrix)
    distance = 0;
    index = 1;
    
    %take the minimum distance between tests in prioritizedTestSuite and
    %tests to prioritize
    for ii=1:size(testsToPrioritize,2)
        for jj=1:size(prioritizedTestSuite,2)
            distances(jj) = distanceMatrix(testsToPrioritize(ii),prioritizedTestSuite(jj));
        end
        dist(ii) = min(distances);
    end
    [farthest, farthestTestIndex] = max(dist);
end