excel_reader <- function(excel_fp) {
  map(excel_sheets(excel_fp), \(sheet) {
    read_excel(excel_fp, sheet = sheet, skip = 2) %>%
      clean_names() %>%
      mutate(across(everything(), as.character))
  }) %>%
    bind_rows()
}

df_cleaner <- function(df) {
  df %>%
    # select cols of (grouping) interest
    select(
      ma_so_pxn,
      nam,
      nu,
      ngay_lay_mau,
      tinh,
      dia_chi,
      kq_dinh_typ_dengue,
      nhom_tuoi_1_15_2_15,
    ) %>%
    # rename cols to english
    rename(
      sample_id = ma_so_pxn,
      male_age = nam,
      female_age = nu,
      date_of_collection = ngay_lay_mau,
      province = tinh,
      addr = dia_chi,
      serotype = kq_dinh_typ_dengue,
      age_group = nhom_tuoi_1_15_2_15,
    ) %>%
    # remove samples without date of collection
    drop_na(date_of_collection) %>%
    # fix data types for columns
    mutate(
      date_of_collection = as.Date(date_of_collection),
      year = year(date_of_collection),
      month = month(date_of_collection),
      day = day(date_of_collection),
      district = addr %>%
        trimws(whitespace = "[ \t\r\n,-]") %>%
        str_split_i("[,-]+", -1) %>%
        trimws(whitespace = "[ \t\r\n,-]") %>%
        stri_trans_general("ASCII") %>%
        tolower(),
      province = stri_trans_general(province, "ASCII") %>% tolower(),
      serotype = factor(serotype),
    ) %>%
    pivot_longer(ends_with("_age"), names_to = "sex", values_to = "age") %>%
    drop_na(age) %>%
    mutate(
      age = case_when(
        str_detect(age, "th") ~ str_extract(age, "\\d+") %>%
          as.numeric() %>%
          `/`(12),
        as.numeric(age) > 101 ~ year - as.numeric(age),
        .default = as.numeric(age)
      )
    ) %>%
    filter_out(age == 0) %>%
    relocate(date_of_collection, .after = everything())
}
