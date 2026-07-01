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

## Environment
The R environment is managed by [`rv`](https://github.com/A2-ai/rv)