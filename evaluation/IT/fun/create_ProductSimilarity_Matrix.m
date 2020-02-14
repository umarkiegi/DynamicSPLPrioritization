function create_ProductSimilarity_Matrix (paths,nProducts) 
%create_ProductSimilarity_Matrix Creates a .mat file in stage dir 
% with the similarity between products calculated using selected and 
% deselected feature in product configurations proposed by Al-Hajjaji

    % INPUT
    numberOfConfigs = nProducts;

    for i=1:numberOfConfigs
        c1 = ['c' num2str(i) '.config'];
        for j=1:numberOfConfigs        
            c2 = ['c' num2str(j) '.config'];
            ProductSimilarity(i,j)= calculateDistance(c1,c2,'allFeatures.config');
        end
    end

    % save
    ProductSimilarityPath = strcat(paths.stage,'\ProductSimilarity.mat');
    save(ProductSimilarityPath,'ProductSimilarity');
    % save excel
    ProductSimilarityExcelPath = strcat(paths.stage,'\ProductSimilarity.xlsx');
    xlswrite(ProductSimilarityExcelPath,ProductSimilarity,'ProductSimilarity');
    % Display
    fprintf('Product Similarity (Features) calculated\n');
    
end