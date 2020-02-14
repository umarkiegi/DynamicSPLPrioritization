function create_ProductTestCaseSimilarityWAS_Matrix(paths,Wp,Wtc)
%create_ProductTestCaseSimilarityWAS_Matrix Creates a .mat file in stage dir 
% with the similarity between test cases executed in all producs
% based on the weighted all signals distances

    % Load data
    ProductSimilarityPath = strcat(paths.stage,'\ProductSimilarity.mat');
    load(ProductSimilarityPath);
    TestCase150SimilarityPath = strcat(paths.stage,'\TestCase150Similarity.mat');
    load(TestCase150SimilarityPath);
    
    % Initializations
    nP = size(ProductSimilarity,1);
    nTC = size(TestCase150Similarity,1);
    nTCPro = nTC*nP;
    ProductTestCaseSimilarityWAS = zeros(nTCPro,nTCPro);

    for iP=1:nP
        fprintf('\n PRODUCT %s \n',num2str(iP));
        for iTC=1:nTC
            i = (iP-1)*nTC +iTC;
            for jP=1:nP
                for jTC=1:nTC
                    j = (jP-1)*nTC +jTC;
                    if ~isequal(i,j)
                        simProduct = ProductSimilarity(iP,jP);
                        simTestCases = TestCase150Similarity(iTC,jTC);
                        PTCSimilarity = simProduct*Wp + simTestCases*Wtc;
                        ProductTestCaseSimilarityWAS(i,j) = PTCSimilarity;
                    end
                end
            end
            fprintf('\t %s',num2str(iTC));
        end
    end     
    
    % save
    ProductTestCaseSimilarityWASPath = strcat(paths.stage,'\ProductTestCaseSimilarityWAS.mat');
    save(ProductTestCaseSimilarityWASPath,'ProductTestCaseSimilarityWAS');
    % Display
	fprintf('ProductTestCaseSimilarityWAS calculated\n');
    
end