function mutationScore = calculateMutationScore(mutantsMatrix, TCPArray)

    nTestCases = size(TCPArray,2);
    nMutants = size(mutantsMatrix,2);
    faultsPosition = zeros(1,nMutants);
    
    for ii=1:nTestCases
        testCase = TCPArray(ii);
        for jj=1:nMutants
            if faultsPosition(jj)==0 && mutantsMatrix(testCase,jj)==1
               faultsPosition(jj) = 1;
            end
            
        end  
    end
   mutationScore=sum(faultsPosition)/nMutants;
end

