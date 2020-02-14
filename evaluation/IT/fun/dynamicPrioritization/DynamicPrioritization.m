classdef DynamicPrioritization < handle
    %Class that makes prioritization dynamically
        
    properties
        nHistory %Number of test cases we want to execute without dynamic prioritization
        nTCReallocation %Number of test cases we consider in the dynamic prioritization
        nProducts %Number of products we have in the product suite (derived by 2-wise, 3-wise or any other criterion)
        nTestCases %Number of 150% test cases (i.e., how many test cases we have for testing)
        staticallyPrioritizedArray %Initially prioritized test case
        historycalArray %array containing pass/fail history. Columns are |ProductID|#ofExecutedTC|#ofPassTC|#ofFailTC|
        mutantsMatrix %Relation between test case and mutants (used to get results)
    end
    
    methods
        function obj = DynamicPrioritization(nHistory,nTCReallocation,nProducts,nTestCases,mutantsMatrix)
            %Construct an instance of this class
            
            obj.nHistory = nHistory;
            obj.nTCReallocation = nTCReallocation;
            obj.nProducts = nProducts;
            obj.nTestCases = nTestCases;
            obj.historycalArray = zeros(nProducts,4);
            for ii=1:nProducts
               obj.historycalArray(ii,1)=ii; 
            end
            obj.mutantsMatrix = mutantsMatrix;
        end
        
        function prioritizedTestSuite = dynamicallyPrioritizeTestSuite(obj)
            %Makes dynamic test case prioritization
            
            %Preallocation of variables
            prioritizedTestSuite = zeros(1,obj.nTestCases*obj.nProducts);
            updatedArray = zeros(1,obj.nTCReallocation);
            productFDC = zeros(1,obj.nTCReallocation);
            
            %Step 1) execute first test cases not considering dynamicity
            for ii=1:obj.nHistory
                verdict = obj.getVerdict(obj.staticallyPrioritizedArray(ii));
                obj.updateHistoricalDatabase(verdict, obj.staticallyPrioritizedArray(ii));  
                prioritizedTestSuite(ii)=obj.staticallyPrioritizedArray(ii);
            end
            
            %Step 2) make dynamic reallocation
            dynamicallyPrioritizedTestSuite = obj.staticallyPrioritizedArray;
            for ii=obj.nHistory+1:obj.nTestCases*obj.nProducts-obj.nTCReallocation
                testCasesForDynamicUpdate = dynamicallyPrioritizedTestSuite(ii:ii+obj.nTCReallocation-1);
                for jj=1:obj.nTCReallocation
                    product = ceil(testCasesForDynamicUpdate(jj)/obj.nTestCases);
                    productFDC(jj)=obj.historycalArray(product,4)/obj.historycalArray(product,2);
                end
                if isnan(productFDC(1)) %is NaN (i.e., there has no been executions), so we execute it.
                    verdict = obj.getVerdict(dynamicallyPrioritizedTestSuite(ii));
                    obj.updateHistoricalDatabase(verdict, dynamicallyPrioritizedTestSuite(ii));  
                    prioritizedTestSuite(ii) = dynamicallyPrioritizedTestSuite(ii);
                else
                    highestFDC = productFDC(1);
                    highestIndex = 1;
                    for jj=2:obj.nTCReallocation
                        if highestFDC < productFDC(jj)
                            highestFDC = productFDC(jj);
                            highestIndex = jj;
                        end   
                    end
                    %Makes the re-allocation based on the FDC
                    updatedArray(1)=testCasesForDynamicUpdate(highestIndex);
                    for jj=1:highestIndex-1
                        updatedArray(jj+1) = testCasesForDynamicUpdate(jj);
                    end
                    for jj=highestIndex+1:obj.nTCReallocation
                        updatedArray(jj) = testCasesForDynamicUpdate(jj);
                    end
                    k=1;
                    for jj=ii:ii+obj.nTCReallocation-1
                        dynamicallyPrioritizedTestSuite(jj)=updatedArray(k);
                        k=k+1;
                    end
                    prioritizedTestSuite(ii) = updatedArray(1);
                    verdict = obj.getVerdict(updatedArray(1));
                    obj.updateHistoricalDatabase(verdict, updatedArray(1));  
                    
                end
            end
            
            %Step 3) Static prioritization for last test cases of the static
            %prioritization array
            for ii=obj.nTestCases*obj.nProducts-obj.nTCReallocation+1:obj.nTestCases*obj.nProducts
                prioritizedTestSuite(ii)=dynamicallyPrioritizedTestSuite(ii);
                verdict = obj.getVerdict(prioritizedTestSuite(ii));
                obj.updateHistoricalDatabase(verdict, prioritizedTestSuite(ii));
            end
        end
        
        function verdict = getVerdict(obj,testCaseID)   
            %Returns test result (i.e., a verdict), based on the mutants
            %matrix. Verdict 1 means a 'Fail'; Verdict 0 mens a 'Pass'
            if sum(obj.mutantsMatrix(testCaseID,:))>=1 %TODO: Cambiar a 1
                verdict = 1; %mutant found
            else
                verdict = 0; %mutant not found
            end            
        end
        
        function updateHistoricalDatabase(obj, verdict, testCase)
            %Updates the historical database considering the test case that
            %has been executed and the verdict
            productNumber = ceil(testCase/obj.nTestCases); %takes the product of the test case
            obj.historycalArray(productNumber,2)=obj.historycalArray(productNumber,2)+1; %increments number of executed test cases
            if verdict ==0
                obj.historycalArray(productNumber,3)=obj.historycalArray(productNumber,3)+1; %increments number of passes in database
            else
                obj.historycalArray(productNumber,4)=obj.historycalArray(productNumber,4)+1; %increments number of fails in database
            end
            
        end
    end
end

