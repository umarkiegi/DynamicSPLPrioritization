**step1_prepareRequiredData.m**
Run this script several times (uncomment sub step each time) to prepare the following dataset:

- ProductSimilarity.mat		//Similarity between products (feature-based Al-Hajjaji)
- TestCase150Similarity_v1.mat		//Similarity between 150 test cases (mean of all signals)
- ProductTestCaseSimilarityWAS_v1.mat	//Product and TC similiarity Weighted All Signlas (**AS**)
- ProductTestCaseSimilarityWCS_v1.mat	//Product and TC similiarity Weighted Contained Signals (**GS**)
- prioritizationArrayWAS_v1.mat		//Several prioritizationArrayXXXX files can be created WAS, WCS, v1, etc.
- DynamicParamValues.mat	//Create file containing different parameter values to run DynamicSPLPrioritization algorithm
- prioritizationArrayRandom.mat  //PrioritizationArray for Random type generation

**step2_DynamicPrioritization_multiparam.m**
Run this script to run the DynamicSPLPrioritization algorithm with provided param values.
For each run configure %%% INPUT Parameters
Resulting output is placed in out directory.

**step3_mainBASELINE.m**
Script to get BASELINE metrics.

**NOTES**
- Do NOT use v2 files (based on wrong distances)
- LARGE files not included into the repo
  Use these links to get the large files and place them into /stage directory:
  + ProductTestCaseSimilarityWAS_v1.mat
  https://www.dropbox.com/s/58u8pjepq8dchsr/ProductTestCaseSimilarityWAS_v1.mat?dl=0
  + ProductTestCaseSimilarityWCS_v1.mat
  https://www.dropbox.com/s/s710wbldflmgtrh/ProductTestCaseSimilarityWCS_v1.mat?dl=0
