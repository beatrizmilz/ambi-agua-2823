Comparacao com a Resolucao conama 357/2005
================
Beatriz

``` r
devtools::load_all()
```

    ## ℹ Loading manuscript.AmbiAgua

``` r
dados_filtrados <- sampling_data_long |>
  dplyr::filter(variable %in% c("dissolved_oxygen",
                                "ph",
                                "CHLA",
                                "NO2", "NO3", "NH4",
                                "TP"))

# PG 33
```

``` r
conama_nh4 <- dados_filtrados |>
  dplyr::filter(variable %in% c("ph", "NH4")) |>
  dplyr::select(id, season, variable, result_variable) |>
  tidyr::pivot_wider(id_cols = c(id, season),
                     names_from = variable,
                     values_from = result_variable) |>
  dplyr::mutate(
    dentro_conama = dplyr::case_when(
      is.na(NH4) ~ TRUE,
      ph >= 7.5 & NH4 < 3.7 * 1000 ~ TRUE,
      ph > 7.5 & ph <= 8 & NH4 < 2 * 1000 ~ TRUE,
      ph > 8 & ph <= 8.5 & NH4 < 1 * 1000 ~ TRUE,
      ph > 8.5 & NH4 < 0.5 * 1000 ~ TRUE,
      TRUE ~ FALSE
    ),
    variable = "NH4"
  ) |> 
  dplyr::select(-ph) |> 
  dplyr::rename(result_variable = NH4)
```

``` r
dados_conama <- dados_filtrados |>
  dplyr::mutate(
    dentro_conama = dplyr::case_when(
      variable == "dissolved_oxygen" & result_variable > 5 ~ TRUE,
      variable == "dissolved_oxygen" & result_variable <= 5 ~ FALSE,
      
      variable == "ph" &
        result_variable >= 6 &  result_variable <= 9 ~ TRUE,
      variable == "ph" &  result_variable > 9 ~ FALSE,
      variable == "ph" &  result_variable < 6 ~ FALSE,
      
      variable == "CHLA" & result_variable < 30 ~ TRUE,
      variable == "CHLA" & result_variable >= 30 ~ FALSE,
      
      
      variable == "TP" & result_variable < 0.1 * 1000 ~ TRUE,
      variable == "TP" & result_variable >= 0.1 * 1000 ~ FALSE,
      
      variable == "NO3" & is.na(result_variable) ~ TRUE,
      variable == "NO3" & result_variable < 10 * 1000 ~ TRUE,
      variable == "NO3" & result_variable >= 10 * 1000 ~ FALSE,
      
      variable == "NO2" & is.na(result_variable) ~ TRUE,
      variable == "NO2" & result_variable < 1 * 1000 ~ TRUE,
      variable == "NO2" & result_variable >= 1 * 1000 ~ FALSE,
    )
  ) |> 
  dplyr::filter(variable != "NH4") |> 
  dplyr::bind_rows(conama_nh4)
```

``` r
fora_conama <- dados_conama |> 
  dplyr::filter(dentro_conama == FALSE) 

fora_conama|> 
  dplyr::count(variable, season, dentro_conama) |> 
  dplyr::mutate(porc = round(n/12*100, 1)) |> 
  dplyr::arrange(porc)
```

    ## # A tibble: 9 × 5
    ##   variable         season dentro_conama     n  porc
    ##   <chr>            <chr>  <lgl>         <int> <dbl>
    ## 1 dissolved_oxygen dry    FALSE             3  25  
    ## 2 dissolved_oxygen rainy  FALSE             3  25  
    ## 3 ph               rainy  FALSE             3  25  
    ## 4 NH4              rainy  FALSE             5  41.7
    ## 5 NH4              dry    FALSE             6  50  
    ## 6 CHLA             dry    FALSE             8  66.7
    ## 7 TP               rainy  FALSE             9  75  
    ## 8 CHLA             rainy  FALSE            10  83.3
    ## 9 TP               dry    FALSE            12 100
