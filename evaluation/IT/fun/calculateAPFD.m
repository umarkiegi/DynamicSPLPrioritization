function apfd = calculateAPFD(mutantsMatrix, TCPArray)

    nTestCases = size(TCPArray,2);
    nMutants = size(mutantsMatrix,2);
    faultsPosition = zeros(1,nMutants);
    
    for ii=1:nTestCases
        testCase = TCPArray(ii);
        for jj=1:nMutants
            if faultsPosition(jj)==0 && mutantsMatrix(testCase,jj)==1
               faultsPosition(jj) = ii;
            end
            
        end  
    end
    apfd = 1-(sum(faultsPosition)/(nTestCases*nMutants))+(1/(2*nTestCases));
end

