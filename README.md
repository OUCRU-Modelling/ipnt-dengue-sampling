# Dengue sampling scripts for study with Institut Pasteur Nha Trang (part of MADZIP Consortium)

## Repo structure
- `data/` folder contains raw Excel files of dengue positive and dengue negative samples, sent by IPNT
- `sampler.R` contains R code to (1) ingest Excel data, (2) do stratified proportional sampling of both positive and negative samples, as per certain criteria, and (3) export final sample list as CSV files with *UTF-8 Byte order mark* to read in Excel
- `utils.R` contains helper, or utility, functions to read Excel file and concatenate all sheets together, and do some simple data cleaning
- `neg_pooler.R` contains R code to simply pool negative samples together into specified named batches

## Usage
1. Acquire the necessary data
2. Modify the `df_cleaner()` function in `utils.R` to match with your data
3. Modify the `sampler.R` script to match your stratified sampling criteria and run the script
4. (Optional) Modify and run `neg_pooler.R` if you want to pool your negative samples together into batches

## Sampling criteria used

### Dengue-positive samples

* Samples with a missing year were excluded.
* Samples were selected separately for each year.
* If a year contained **50 or fewer samples**, all samples were included.
* If a year contained more than 50 samples, proportional random sampling was performed within groups defined by:

  * Month
  * Province
  * Serotype
* The sampling proportions were:

  * 2019: 49%
  * 2020: 90%
  * 2021: 100%
  * 2022: 40%

### Dengue-negative samples

* Samples were selected separately for each year.
* If a year contained **200 or fewer samples**, all samples were included.
* If a year contained more than 200 samples, proportional random sampling was performed within groups defined by:

  * Day
  * Month
  * Province
* The sampling proportions were:

  * 2018: 0%
  * 2019: 70%
  * 2020: 100%
  * 2021: 100%
  * 2022: 50%

A fixed random seed (`764`) was used so that the sampling results could be reproduced.



## Environment
The R environment is managed by [`rv`](https://github.com/A2-ai/rv)
