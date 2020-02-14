function [prioritizedTestSuite] = prioritizeBasedOnDistancesBASELINE(distanceMatrix, testsToPrioritize)
% This function prioritizes test cases by not diversifying inputs. It is
% used as a baseline, as proposed by Henard et al. [1]
% [1] Henard, C., Papadakis, M., Harman, M., Jia, Y., & Le Traon, Y. (2016, May). 
% Comparing white-box and black-box test prioritization. In 2016 IEEE/ACM 38th 
% International Conference on Software Engineering (ICSE) (pp. 523-534). IEEE.

    numberOfTestCases = size(testsToPrioritize,2);
    prioritizedTestSuite(1) = testsToPrioritize(1);
    testsToPrioritize(1) = [];
    %takeFarthest(prioritizedTestSuite, testsToPrioritize, distanceMatrix);
    for ii=2:numberOfTestCases
        idx = takeMostSimilar(prioritizedTestSuite, testsToPrioritize, distanceMatrix);
        prioritizedTestSuite(ii) = testsToPrioritize(idx);
        testsToPrioritize(idx) = [];
    end

end

function farthestTestIndex = takeMostSimilar(prioritizedTestSuite, testsToPrioritize, distanceMatrix)
    distance = 0;
    index = 1;
    
    %take the minimum distance between tests in prioritizedTestSuite and
    %tests to prioritize
    for ii=1:size(testsToPrioritize,2)
        for jj=1:size(prioritizedTestSuite,2)
            distances(jj) = distanceMatrix(testsToPrioritize(ii),prioritizedTestSuite(jj));
        end
        dist(ii) = max(distances);
    end
    [farthest, farthestTestIndex] = min(dist);
end