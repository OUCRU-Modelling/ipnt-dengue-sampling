library(tidyverse)
library(readxl)
library(janitor)
library(stringi)

source("utils.R")

set.seed(764)

neg_fp <- "data/2019-2022 DENGUE NEGATIVE.xlsx"
neg_samples <- excel_reader(neg_fp)
cleaned_neg_samples <- df_cleaner(neg_samples) %>%
  select(-serotype)
hist(cleaned_neg_samples$age)

pos_fp <- "data/2019-2022 DENGUE POSITIVE.xlsx"
pos_samples <- excel_reader(pos_fp)
cleaned_pos_samples <- df_cleaner(pos_samples) %>% drop_na(year)
hist(cleaned_pos_samples$age)

# ------------------------------------------------------------------------------

pos_prop <- c(
  `2019` = 0.49,
  `2020` = 0.9,
  `2021` = 1,
  `2022` = 0.4
) # tuning variable to hit desired sampling size
selected_pos_samples <- cleaned_pos_samples %>%
  # split sampling by year
  group_by(year) %>%
  group_split() %>%
  map2(., pos_prop, \(yearly_tbl, sampling_prop) {
    if (nrow(yearly_tbl) <= 50) {
      # if less than or equal to 50 samples, take all
      yearly_tbl
    } else {
      # stratified proportional sampling if more than 50 samples
      yearly_tbl %>%
        group_by(month, province, serotype) %>%
        slice_sample(prop = sampling_prop) %>%
        ungroup()
    }
  }) %>%
  bind_rows()

selected_pos_samples %>%
  group_by(year) %>%
  tally()
# selected_pos_samples

selected_pos_samples %>% tabyl(year)
selected_pos_samples %>% tabyl(province)
selected_pos_samples %>% tabyl(serotype)
selected_pos_samples %>% tabyl(sex)
hist(selected_pos_samples$age)

selected_pos_samples %>% write_excel_csv("selected_pos_samples-ansi2.csv")

# ------------------------------------------------------------------------------

neg_prop <- c(
  `2018` = 0,
  `2019` = 0.7,
  `2020` = 1,
  `2021` = 1,
  `2022` = 0.5
) # tuning variable to hit desired sampling size
selected_neg_samples <- cleaned_neg_samples %>%
  # split sampling by year
  group_by(year) %>%
  group_split() %>%
  map2(., neg_prop, \(yearly_tbl, sampling_prop) {
    if (nrow(yearly_tbl) <= 200) {
      # if less than or equal to 50 samples, take all
      yearly_tbl
    } else {
      # stratified proportional sampling if more than 50 samples
      yearly_tbl %>%
        group_by(day, month, province) %>%
        slice_sample(prop = sampling_prop) %>%
        ungroup()
    }
  }) %>%
  bind_rows()

selected_neg_samples %>%
  group_by(year) %>%
  tally()
# selected_pos_samples

selected_neg_samples %>% tabyl(year)
selected_neg_samples %>% tabyl(province)
selected_neg_samples %>% tabyl(sex)
hist(selected_neg_samples$age)

selected_neg_samples %>% write_excel_csv("selected_neg_samples-ansi2.csv")
