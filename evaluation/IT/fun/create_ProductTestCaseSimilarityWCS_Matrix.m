function create_ProductTestCaseSimilarityWCS_Matrix(paths,Wp,Wtc)
%create_ProductTestCaseSimilarityWCS_Matrix Creates a .mat file in stage dir 
% with the similarity between test cases executed in all producs
% based on the weighted CONTAINED signals distances
% CONTAINED = shared signals between two products

    % Load data
    ProductSimilarityPath = strcat(paths.stage,'\ProductSimilarity.mat');
    load(ProductSimilarityPath);
    productSignalsPath = strcat(paths.in,'\productSignals.mat');
    load(productSignalsPath);
    signalDistancesPath = strcat(paths.in,'\signalDistances.mat');
    load(signalDistancesPath);
    signalsPath = strcat(paths.in,'\signals.mat');
    load(signalsPath);
    
    % Initializations
    nP = size(ProductSimilarity,1);
    nTC = size(signalDistances,1);
    nTCPro = nTC*nP;
    ProductTestCaseSimilarityWCS = zeros(nTCPro,nTCPro);
    nSignals = size(signals,2);

    for iP=1:nP
        fprintf('\n PRODUCT %s \n',num2str(iP));
        iCS = productSignals{iP,3};
        for iTC=1:nTC
            i = (iP-1)*nTC +iTC;
            for jP=1:nP
                jCS = productSignals{jP,3};
                for jTC=1:nTC
                    j = (jP-1)*nTC +jTC;
                    if ~isequal(i,j)
                        allDistances = permute(signalDistances(iTC,jTC,:),[3 1 2]);
                        % get CS (Equal Contained signals)
                        CS = iCS(ismember(iCS,jCS));
                        nCS = numel(CS);
                        sIdx = [];
                        for k=1:nCS
                            for iSig=1:nSignals
                                isSigFound = strcmp(signals{iSig},CS{k});
                                if isSigFound
                                    sIdx(k)=iSig;
                                    break;
                                end
                            end
                            %sIdx(k) = find(contains(signals,CS{k}));
                        end
                        CSDistances = allDistances(sIdx);
                        CSDistancesSum = sum(CSDistances);                        
                        simTestCases = CSDistancesSum / nSignals;
                        simProduct = ProductSimilarity(iP,jP);
                        PTCSimilarity = simProduct*Wp + simTestCases*Wtc;
                        ProductTestCaseSimilarityWCS(i,j) = PTCSimilarity;
                    end
                end
            end
            fprintf('\t %s',num2str(iTC));
        end
    end     
    
    % save
    ProductTestCaseSimilarityWCSPath = strcat(paths.stage,'\ProductTestCaseSimilarityWCS.mat');
    save(ProductTestCaseSimilarityWCSPath,'ProductTestCaseSimilarityWCS');
    % Display
	fprintf('ProductTestCaseSimilarityWCS calculated\n');
    
end