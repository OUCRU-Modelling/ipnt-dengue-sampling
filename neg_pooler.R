library(tidyverse)

neg_samples <- read_csv("selected_neg_samples-ansi.csv") %>%
  filter_out(year == 2018)

neg_samples %>%
  mutate(
    pool = sprintf("76DX-152-5%03d", rep(1:175, 4))
  ) %>%
  write_excel_csv("selected_neg_samples-ansi-pooled.csv")
