## code to prepare sampling dataset goes here

# sampling data wide --------------------
# read the raw dataset
raw_dataset <- readr::read_csv2("data-raw/raw_dataset.csv")

sampling_data_wide <- raw_dataset %>%
  # calculate tsi tp
  dplyr::mutate(tsi_tp = (10 * (6 - ((-0.27637 * SciViews::ln(TP) + 1.329766) / SciViews::ln(2)
  )))) %>%
  # calculate tsi chla
  dplyr::mutate(tsi_chla = (10 * (6 - ((-0.2512 * SciViews::ln(CHLA) + 0.842257) / SciViews::ln(2)
  )))) %>%
  # calculate tsi tsr
  dplyr::mutate(tsi_tsr = (tsi_tp + tsi_chla) / 2) %>%
  dplyr::select(-tsi_tp, -tsi_chla) %>%
  # calculate NP ratio
  dplyr::mutate(NP_ratio = (TN / 14) / (TP / 31)) %>%
  # round numeric values to 2 digits
  dplyr::mutate_if(is.numeric, round, digits = 2) %>%
  # below detection values turned to NA
  dplyr::mutate(
    TN = dplyr::case_when(TN < 102 ~ NA_real_,
                          TRUE ~ TN),
    NO3 = dplyr::case_when(NO3 < 55.5 ~ NA_real_,
                           TRUE ~ NO3),
    NO2 = dplyr::case_when(NO2 < 6 ~ NA_real_,
                           TRUE ~ NO2),
    NH4 = dplyr::case_when(NH4 < 33.5 ~ NA_real_,
                           TRUE ~ NH4),
    TP = dplyr::case_when(TP < 9 ~ NA_real_,
                          TRUE ~ TP),
    TDP = dplyr::case_when(TDP < 9 ~ NA_real_,
                           TRUE ~ TDP),
    SRP = dplyr::case_when(SRP < 6 ~ NA_real_,
                           TRUE ~ SRP),
  ) %>%
  # add the class of the TSI and TSR
  dplyr::mutate(
    tsi_tsr_class = dplyr::case_when(
      tsi_tsr <= 51.1 ~ "Ultraoligotrophic",
      tsi_tsr > 51.2 & tsi_tsr < 53.2 ~ "Oligotrophic",
      tsi_tsr > 53.2 & tsi_tsr < 55.8 ~ "Mesotrophic",
      tsi_tsr > 55.8 & tsi_tsr < 58.2 ~ "Eutrophic",
      tsi_tsr > 58.2 & tsi_tsr < 59.1 ~ "Supereutrophic",
      tsi_tsr >= 59.1 ~ "Hypereutrophic"
    )
  )


usethis::use_data(sampling_data_wide, overwrite = TRUE)

# sampling data long --------------------
sampling_data_long <- tidyr::pivot_longer(
  sampling_data_wide,
  cols = c(
    TN,
    NO2,
    NO3,
    NH4,
    TP,
    TDP,
    SRP,
    CHLA,
    euphotic_zone_depth ,
    secchi_depth   ,
    water_temperature   ,
    dissolved_oxygen  ,
    saturation_dissolved_oxygen,
    precipitation_30days,
    air_temperature ,
    electrical_conductivity  ,
    ph,
    tsi_tsr,
    NP_ratio
  ),
  names_to = "variable",
  values_to = "result_variable"
) %>%
  dplyr::mutate(result_variable = round(result_variable, digits = 2))


usethis::use_data(sampling_data_long, overwrite = TRUE)

# variable names ---------
variable_names <- tibble::tribble(
  ~ variable,
  ~ variable_name,
  "TN",
  "Total Nitrogen",
  "NO2",
  "Nitrite",
  "NO3",
  "Nitrate",
  "NH4",
  "Ammonium",
  "TP",
  "Total Phosphorus",
  "TDP",
  "Total Dissolved Phosphorus",
  "SRP",
  "Soluble Reactive Phosphorus",
  "CHLA",
  "Chlorophyll-a",
  "WT",
  "Water Temperature",
  "DO",
  "Dissolved Oxygen",
  "EC",
  "Electrical Conductivity",
  "pH",
  "pH"
  )

usethis::use_data(variable_names, overwrite = TRUE)
