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

A fixed random seed `764` was set to (try to) ensures reproducibility across different runs of the sampling operation.

**Dengue-positive samples.** Samples with a missing year were excluded. Sampling was performed separately for each year. When a year contained 50 or fewer samples, all were retained; when a year contained more than 50, proportional random sampling was applied within strata defined by month, province, and serotype. Yearly sampling proportions were 49% (2019), 90% (2020), 100% (2021), and 40% (2022).

**Dengue-negative samples.** Sampling was performed separately for each year. When a year contained 200 or fewer samples, all were retained; when a year contained more than 200, proportional random sampling was applied within strata defined by day, month, and province. Yearly sampling proportions were 0% (2018), 70% (2019), 100% (2020), 100% (2021), and 50% (2022).



## Environment
The R environment is managed by [`rv`](https://github.com/A2-ai/rv)

