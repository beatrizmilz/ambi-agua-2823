STI
================

-   Usando as mesmas variáveis da PCA

-   <https://github.com/r-spatial/sf/issues/1464>

### Preparando os dados

``` r
devtools::load_all()
```

    ## ℹ Loading manuscript.AmbiAgua

``` r
data_sti <-
  dataset_pca_sti %>% dplyr::select( # retira algumas variáveis não necessárias
    -id,
    -sampling_event,
    -season,
    -tsi_tsr_class,
    -season_numeric,
    -euphotic_zone_depth,
    -secchi_depth,
    -precipitation_30days,
    -air_temperature,-tsi_tsr,
    -NP_ratio,
    -saturation_dissolved_oxygen
  ) %>%
  dplyr::rename("Site" = sampling_sites,
         "Date" = sampling_event_num) %>%
  dplyr::relocate(Site, .before = Date)

data_sti_sem_site_data <- data_sti %>% dplyr::select(-Site,-Date)
```

``` r
#log-transform species data (excluding site and time colums)

#JEAN: Aqui, Beatriz, nao transforme o pH porque jah eh medido em escala log
data_sti_log <-
  data.frame(log(data_sti_sem_site_data[, -12] + 1), pH = data_sti_sem_site_data$ph)
```

## Multivariada

``` r
# # multivariada ----
sti_multivariada <- adespatial::stimodels(
  data_sti_log,
  #dados transformados com log
  S = 4,  # quantos pontos de coleta?
  Ti = 6,  # quantas coletas ao longo do tempo?
  nperm = 999, # número de permutações
  model = "5" # qual modelo utilizado
)
```

    ## Registered S3 methods overwritten by 'adegraphics':
    ##   method         from
    ##   biplot.dudi    ade4
    ##   kplot.foucart  ade4
    ##   kplot.mcoa     ade4
    ##   kplot.mfa      ade4
    ##   kplot.pta      ade4
    ##   kplot.sepan    ade4
    ##   kplot.statis   ade4
    ##   scatter.coa    ade4
    ##   scatter.dudi   ade4
    ##   scatter.nipals ade4
    ##   scatter.pco    ade4
    ##   score.acm      ade4
    ##   score.mix      ade4
    ##   score.pca      ade4
    ##   screeplot.dudi ade4

    ## Registered S3 method overwritten by 'spdep':
    ##   method   from
    ##   plot.mst ape

    ## Registered S3 methods overwritten by 'adespatial':
    ##   method             from       
    ##   plot.multispati    adegraphics
    ##   print.multispati   ade4       
    ##   summary.multispati ade4

    ## =======================================================
    ##         Space-time ANOVA without replicates
    ##                                                   
    ##   Pierre Legendre, Miquel De Caceres, Daniel Borcard
    ## =======================================================
    ## 
    ##  Number of space points (s) = 4 
    ##  Number of time points (tt) = 6 
    ##  Number of observations (n = s*tt) = 24 
    ##  Number of response variables (p) = 12 
    ##  
    ##  Computing dbMEMs to code for space
    ##  Truncation level for space dbMEMs = 1 
    ##  Computing dbMEMs to code for time
    ##  Truncation level for time dbMEMs = 1 
    ## 
    ##  Number of space coding functions = 1 
    ## 
    ##  Number of time coding functions = 2 
    ## 
    ##  MODEL V: HELMERT CONTRAST FOR TESTING MAIN FACTORS.
    ##           SPACE AND TIME dbMEMs FOR TESTING INTERACTION.
    ##    Number of space variables = 3 
    ##    Number of time variables = 5 
    ##    Number of interaction variables = 2 
    ##    Number of residual degrees of freedom = 13 
    ## 
    ##  Interaction test:   R2 = 0.0517   F = 1.4127   P( 999 perm) = 0.205 
    ##  Space test:         R2 = 0.3   F = 5.4633   P( 999 perm) = 0.001 
    ##  Time test:          R2 = 0.4103   F = 4.4833   P( 999 perm) = 0.001 
    ## 
    ## -------------------------------------------------------
    ##          Time for computation = 0.371000  sec 
    ## =======================================================

``` r
sti_multivariada
```

    ## $testSTI
    ## $testSTI$MS.num
    ## [1] 8.403052
    ## 
    ## $testSTI$MS.den
    ## [1] 5.948242
    ## 
    ## $testSTI$R2
    ## [1] 0.05171719
    ## 
    ## $testSTI$R2.adj
    ## [1] -0.03859546
    ## 
    ## $testSTI$F
    ## [1] 1.412695
    ## 
    ## $testSTI$Prob
    ## [1] 0.205
    ## 
    ## 
    ## $testS
    ## $testS$MS.num
    ## [1] 32.49684
    ## 
    ## $testS$MS.den
    ## [1] 5.948242
    ## 
    ## $testS$R2
    ## [1] 0.3000063
    ## 
    ## $testS$R2.adj
    ## [1] 0.1950072
    ## 
    ## $testS$F
    ## [1] 5.463269
    ## 
    ## $testS$Prob
    ## [1] 0.001
    ## 
    ## 
    ## $testT
    ## $testT$MS.num
    ## [1] 26.66757
    ## 
    ## $testT$MS.den
    ## [1] 5.948242
    ## 
    ## $testT$R2
    ## [1] 0.4103188
    ## 
    ## $testT$R2.adj
    ## [1] 0.2465184
    ## 
    ## $testT$F
    ## [1] 4.48327
    ## 
    ## $testT$Prob
    ## [1] 0.001
    ## 
    ## 
    ## $X.matrix
    ## [1] NA
    ## 
    ## attr(,"class")
    ## [1] "sti"

``` r
sti_multivariada_tibble <- tibble::tibble(
  variavel = character(),
  fator  = character(),
  f = double(),
  p = double(),
  r2 = double(),
  r2adj = double()
) %>%
  tibble::add_row(
    variavel = "multivariada",
    fator = "S*T",
    f = sti_multivariada$testSTI$F ,
    p = sti_multivariada$testSTI$Prob ,
    r2 = sti_multivariada$testSTI$R2,
    r2adj = sti_multivariada$testSTI$R2.adj
  ) %>%
  tibble::add_row(
    variavel = "multivariada",
    fator = "S",
    f = sti_multivariada$testS$F ,
    p = sti_multivariada$testS$Prob ,
    r2 = sti_multivariada$testS$R2,
    r2adj = sti_multivariada$testS$R2.adj
  ) %>%
  tibble::add_row(
    variavel = "multivariada",
    fator = "T",
    f = sti_multivariada$testT$F ,
    p = sti_multivariada$testT$Prob ,
    r2 = sti_multivariada$testT$R2,
    r2adj = sti_multivariada$testT$R2.adj
  ) %>%
  dplyr::relocate(variavel, fator, r2, f, p , r2adj)

sti_multivariada_tibble
```

    ## # A tibble: 3 × 6
    ##   variavel     fator     r2     f     p   r2adj
    ##   <chr>        <chr>  <dbl> <dbl> <dbl>   <dbl>
    ## 1 multivariada S*T   0.0517  1.41 0.205 -0.0386
    ## 2 multivariada S     0.300   5.46 0.001  0.195 
    ## 3 multivariada T     0.410   4.48 0.001  0.247

``` r
sti_multivariada_tibble %>% readr::write_rds("results/sti_multi_tabela_final.Rds")
```

### UNIVARIADA

``` r
# univariada ----

calcular_sti_univar <- function(i){
  sti_uni <- adespatial::stimodels(
    data_sti_log[, i],
    S = 4,     # quantos ponto de coleta?
    Ti = 6,     # quantas coletas ao longo do tempo?
    nperm = 999, # número de permutações
    model = "5" # qual modelo utilizado
  )
  var <- names(data_sti_log)[i]


  tibble::tibble(
    variavel = character(),
    fator  = character(),
    f = double(),
    p = double(),
    r2 = double(),
    r2adj = double()
  ) %>%
    tibble::add_row(
      variavel = var,
      fator = "S",
      f = sti_uni$testS$F ,
      p = sti_uni$testS$Prob ,
      r2 = sti_uni$testS$R2,
      r2adj = sti_uni$testS$R2.adj
    ) %>%
    tibble::add_row(
      variavel = var,
      fator = "T",
      f = sti_uni$testT$F ,
      p = sti_uni$testT$Prob ,
      r2 = sti_uni$testT$R2,
      r2adj = sti_uni$testT$R2.adj
    ) %>%
    tibble::add_row(
      variavel = var,
      fator = "S*T",
      f = sti_uni$testSTI$F ,
      p = sti_uni$testSTI$Prob ,
      r2 = sti_uni$testSTI$R2,
      r2adj = sti_uni$testSTI$R2.adj
    )


}

sti_uni_tibble <- purrr::map_dfr( 1:ncol(data_sti_log), calcular_sti_univar)
```

    ## =======================================================
    ##         Space-time ANOVA without replicates
    ##                                                   
    ##   Pierre Legendre, Miquel De Caceres, Daniel Borcard
    ## =======================================================
    ## 
    ##  Number of space points (s) = 4 
    ##  Number of time points (tt) = 6 
    ##  Number of observations (n = s*tt) = 24 
    ##  Number of response variables (p) = 1 
    ##  
    ##  Computing dbMEMs to code for space
    ##  Truncation level for space dbMEMs = 1 
    ##  Computing dbMEMs to code for time
    ##  Truncation level for time dbMEMs = 1 
    ## 
    ##  Number of space coding functions = 1 
    ## 
    ##  Number of time coding functions = 2 
    ## 
    ##  MODEL V: HELMERT CONTRAST FOR TESTING MAIN FACTORS.
    ##           SPACE AND TIME dbMEMs FOR TESTING INTERACTION.
    ##    Number of space variables = 3 
    ##    Number of time variables = 5 
    ##    Number of interaction variables = 2 
    ##    Number of residual degrees of freedom = 13 
    ## 
    ##  Interaction test:   R2 = 0.0243   F = 1.7716   P( 999 perm) = 0.204 
    ##  Space test:         R2 = 0.0503   F = 2.446   P( 999 perm) = 0.097 
    ##  Time test:          R2 = 0.8364   F = 24.4235   P( 999 perm) = 0.001 
    ## 
    ## -------------------------------------------------------
    ##          Time for computation = 0.328000  sec 
    ## =======================================================
    ## 
    ## =======================================================
    ##         Space-time ANOVA without replicates
    ##                                                   
    ##   Pierre Legendre, Miquel De Caceres, Daniel Borcard
    ## =======================================================
    ## 
    ##  Number of space points (s) = 4 
    ##  Number of time points (tt) = 6 
    ##  Number of observations (n = s*tt) = 24 
    ##  Number of response variables (p) = 1 
    ##  
    ##  Computing dbMEMs to code for space
    ##  Truncation level for space dbMEMs = 1 
    ##  Computing dbMEMs to code for time
    ##  Truncation level for time dbMEMs = 1 
    ## 
    ##  Number of space coding functions = 1 
    ## 
    ##  Number of time coding functions = 2 
    ## 
    ##  MODEL V: HELMERT CONTRAST FOR TESTING MAIN FACTORS.
    ##           SPACE AND TIME dbMEMs FOR TESTING INTERACTION.
    ##    Number of space variables = 3 
    ##    Number of time variables = 5 
    ##    Number of interaction variables = 2 
    ##    Number of residual degrees of freedom = 13 
    ## 
    ##  Interaction test:   R2 = 0.1256   F = 5.3993   P( 999 perm) = 0.028 
    ##  Space test:         R2 = 0.6174   F = 17.6969   P( 999 perm) = 0.001 
    ##  Time test:          R2 = 0.1059   F = 1.8208   P( 999 perm) = 0.185 
    ## 
    ## -------------------------------------------------------
    ##          Time for computation = 0.354000  sec 
    ## =======================================================
    ## 
    ## =======================================================
    ##         Space-time ANOVA without replicates
    ##                                                   
    ##   Pierre Legendre, Miquel De Caceres, Daniel Borcard
    ## =======================================================
    ## 
    ##  Number of space points (s) = 4 
    ##  Number of time points (tt) = 6 
    ##  Number of observations (n = s*tt) = 24 
    ##  Number of response variables (p) = 1 
    ##  
    ##  Computing dbMEMs to code for space
    ##  Truncation level for space dbMEMs = 1 
    ##  Computing dbMEMs to code for time
    ##  Truncation level for time dbMEMs = 1 
    ## 
    ##  Number of space coding functions = 1 
    ## 
    ##  Number of time coding functions = 2 
    ## 
    ##  MODEL V: HELMERT CONTRAST FOR TESTING MAIN FACTORS.
    ##           SPACE AND TIME dbMEMs FOR TESTING INTERACTION.
    ##    Number of space variables = 3 
    ##    Number of time variables = 5 
    ##    Number of interaction variables = 2 
    ##    Number of residual degrees of freedom = 13 
    ## 
    ##  Interaction test:   R2 = 0.1036   F = 2.0146   P( 999 perm) = 0.155 
    ##  Space test:         R2 = 0.1248   F = 1.6191   P( 999 perm) = 0.057 
    ##  Time test:          R2 = 0.4375   F = 3.4047   P( 999 perm) = 0.011 
    ## 
    ## -------------------------------------------------------
    ##          Time for computation = 0.334000  sec 
    ## =======================================================
    ## 
    ## =======================================================
    ##         Space-time ANOVA without replicates
    ##                                                   
    ##   Pierre Legendre, Miquel De Caceres, Daniel Borcard
    ## =======================================================
    ## 
    ##  Number of space points (s) = 4 
    ##  Number of time points (tt) = 6 
    ##  Number of observations (n = s*tt) = 24 
    ##  Number of response variables (p) = 1 
    ##  
    ##  Computing dbMEMs to code for space
    ##  Truncation level for space dbMEMs = 1 
    ##  Computing dbMEMs to code for time
    ##  Truncation level for time dbMEMs = 1 
    ## 
    ##  Number of space coding functions = 1 
    ## 
    ##  Number of time coding functions = 2 
    ## 
    ##  MODEL V: HELMERT CONTRAST FOR TESTING MAIN FACTORS.
    ##           SPACE AND TIME dbMEMs FOR TESTING INTERACTION.
    ##    Number of space variables = 3 
    ##    Number of time variables = 5 
    ##    Number of interaction variables = 2 
    ##    Number of residual degrees of freedom = 13 
    ## 
    ##  Interaction test:   R2 = 0.0014   F = 0.0327   P( 999 perm) = 0.969 
    ##  Space test:         R2 = 0.3174   F = 4.9882   P( 999 perm) = 0.001 
    ##  Time test:          R2 = 0.4055   F = 3.8243   P( 999 perm) = 0.026 
    ## 
    ## -------------------------------------------------------
    ##          Time for computation = 0.333000  sec 
    ## =======================================================
    ## 
    ## =======================================================
    ##         Space-time ANOVA without replicates
    ##                                                   
    ##   Pierre Legendre, Miquel De Caceres, Daniel Borcard
    ## =======================================================
    ## 
    ##  Number of space points (s) = 4 
    ##  Number of time points (tt) = 6 
    ##  Number of observations (n = s*tt) = 24 
    ##  Number of response variables (p) = 1 
    ##  
    ##  Computing dbMEMs to code for space
    ##  Truncation level for space dbMEMs = 1 
    ##  Computing dbMEMs to code for time
    ##  Truncation level for time dbMEMs = 1 
    ## 
    ##  Number of space coding functions = 1 
    ## 
    ##  Number of time coding functions = 2 
    ## 
    ##  MODEL V: HELMERT CONTRAST FOR TESTING MAIN FACTORS.
    ##           SPACE AND TIME dbMEMs FOR TESTING INTERACTION.
    ##    Number of space variables = 3 
    ##    Number of time variables = 5 
    ##    Number of interaction variables = 2 
    ##    Number of residual degrees of freedom = 13 
    ## 
    ##  Interaction test:   R2 = 0.0923   F = 1.6139   P( 999 perm) = 0.227 
    ##  Space test:         R2 = 0.3207   F = 3.7392   P( 999 perm) = 0.03 
    ##  Time test:          R2 = 0.2155   F = 1.5076   P( 999 perm) = 0.253 
    ## 
    ## -------------------------------------------------------
    ##          Time for computation = 0.339000  sec 
    ## =======================================================
    ## 
    ## =======================================================
    ##         Space-time ANOVA without replicates
    ##                                                   
    ##   Pierre Legendre, Miquel De Caceres, Daniel Borcard
    ## =======================================================
    ## 
    ##  Number of space points (s) = 4 
    ##  Number of time points (tt) = 6 
    ##  Number of observations (n = s*tt) = 24 
    ##  Number of response variables (p) = 1 
    ##  
    ##  Computing dbMEMs to code for space
    ##  Truncation level for space dbMEMs = 1 
    ##  Computing dbMEMs to code for time
    ##  Truncation level for time dbMEMs = 1 
    ## 
    ##  Number of space coding functions = 1 
    ## 
    ##  Number of time coding functions = 2 
    ## 
    ##  MODEL V: HELMERT CONTRAST FOR TESTING MAIN FACTORS.
    ##           SPACE AND TIME dbMEMs FOR TESTING INTERACTION.
    ##    Number of space variables = 3 
    ##    Number of time variables = 5 
    ##    Number of interaction variables = 2 
    ##    Number of residual degrees of freedom = 13 
    ## 
    ##  Interaction test:   R2 = 0.0162   F = 0.6197   P( 999 perm) = 0.56 
    ##  Space test:         R2 = 0.3042   F = 7.7698   P( 999 perm) = 0.001 
    ##  Time test:          R2 = 0.51   F = 7.815   P( 999 perm) = 0.001 
    ## 
    ## -------------------------------------------------------
    ##          Time for computation = 0.333000  sec 
    ## =======================================================
    ## 
    ## =======================================================
    ##         Space-time ANOVA without replicates
    ##                                                   
    ##   Pierre Legendre, Miquel De Caceres, Daniel Borcard
    ## =======================================================
    ## 
    ##  Number of space points (s) = 4 
    ##  Number of time points (tt) = 6 
    ##  Number of observations (n = s*tt) = 24 
    ##  Number of response variables (p) = 1 
    ##  
    ##  Computing dbMEMs to code for space
    ##  Truncation level for space dbMEMs = 1 
    ##  Computing dbMEMs to code for time
    ##  Truncation level for time dbMEMs = 1 
    ## 
    ##  Number of space coding functions = 1 
    ## 
    ##  Number of time coding functions = 2 
    ## 
    ##  MODEL V: HELMERT CONTRAST FOR TESTING MAIN FACTORS.
    ##           SPACE AND TIME dbMEMs FOR TESTING INTERACTION.
    ##    Number of space variables = 3 
    ##    Number of time variables = 5 
    ##    Number of interaction variables = 2 
    ##    Number of residual degrees of freedom = 13 
    ## 
    ##  Interaction test:   R2 = 0.0635   F = 2.4664   P( 999 perm) = 0.129 
    ##  Space test:         R2 = 0.125   F = 3.2379   P( 999 perm) = 0.037 
    ##  Time test:          R2 = 0.6443   F = 10.0173   P( 999 perm) = 0.001 
    ## 
    ## -------------------------------------------------------
    ##          Time for computation = 0.328000  sec 
    ## =======================================================
    ## 
    ## =======================================================
    ##         Space-time ANOVA without replicates
    ##                                                   
    ##   Pierre Legendre, Miquel De Caceres, Daniel Borcard
    ## =======================================================
    ## 
    ##  Number of space points (s) = 4 
    ##  Number of time points (tt) = 6 
    ##  Number of observations (n = s*tt) = 24 
    ##  Number of response variables (p) = 1 
    ##  
    ##  Computing dbMEMs to code for space
    ##  Truncation level for space dbMEMs = 1 
    ##  Computing dbMEMs to code for time
    ##  Truncation level for time dbMEMs = 1 
    ## 
    ##  Number of space coding functions = 1 
    ## 
    ##  Number of time coding functions = 2 
    ## 
    ##  MODEL V: HELMERT CONTRAST FOR TESTING MAIN FACTORS.
    ##           SPACE AND TIME dbMEMs FOR TESTING INTERACTION.
    ##    Number of space variables = 3 
    ##    Number of time variables = 5 
    ##    Number of interaction variables = 2 
    ##    Number of residual degrees of freedom = 13 
    ## 
    ##  Interaction test:   R2 = 0.0232   F = 0.4575   P( 999 perm) = 0.651 
    ##  Space test:         R2 = 0.1825   F = 2.4038   P( 999 perm) = 0.126 
    ##  Time test:          R2 = 0.4655   F = 3.6793   P( 999 perm) = 0.037 
    ## 
    ## -------------------------------------------------------
    ##          Time for computation = 0.330000  sec 
    ## =======================================================
    ## 
    ## =======================================================
    ##         Space-time ANOVA without replicates
    ##                                                   
    ##   Pierre Legendre, Miquel De Caceres, Daniel Borcard
    ## =======================================================
    ## 
    ##  Number of space points (s) = 4 
    ##  Number of time points (tt) = 6 
    ##  Number of observations (n = s*tt) = 24 
    ##  Number of response variables (p) = 1 
    ##  
    ##  Computing dbMEMs to code for space
    ##  Truncation level for space dbMEMs = 1 
    ##  Computing dbMEMs to code for time
    ##  Truncation level for time dbMEMs = 1 
    ## 
    ##  Number of space coding functions = 1 
    ## 
    ##  Number of time coding functions = 2 
    ## 
    ##  MODEL V: HELMERT CONTRAST FOR TESTING MAIN FACTORS.
    ##           SPACE AND TIME dbMEMs FOR TESTING INTERACTION.
    ##    Number of space variables = 3 
    ##    Number of time variables = 5 
    ##    Number of interaction variables = 2 
    ##    Number of residual degrees of freedom = 13 
    ## 
    ##  Interaction test:   R2 = 0.0026   F = 4.8562   P( 999 perm) = 0.023 
    ##  Space test:         R2 = 0.0042   F = 5.2181   P( 999 perm) = 0.011 
    ##  Time test:          R2 = 0.9896   F = 731.0701   P( 999 perm) = 0.001 
    ## 
    ## -------------------------------------------------------
    ##          Time for computation = 0.329000  sec 
    ## =======================================================
    ## 
    ## =======================================================
    ##         Space-time ANOVA without replicates
    ##                                                   
    ##   Pierre Legendre, Miquel De Caceres, Daniel Borcard
    ## =======================================================
    ## 
    ##  Number of space points (s) = 4 
    ##  Number of time points (tt) = 6 
    ##  Number of observations (n = s*tt) = 24 
    ##  Number of response variables (p) = 1 
    ##  
    ##  Computing dbMEMs to code for space
    ##  Truncation level for space dbMEMs = 1 
    ##  Computing dbMEMs to code for time
    ##  Truncation level for time dbMEMs = 1 
    ## 
    ##  Number of space coding functions = 1 
    ## 
    ##  Number of time coding functions = 2 
    ## 
    ##  MODEL V: HELMERT CONTRAST FOR TESTING MAIN FACTORS.
    ##           SPACE AND TIME dbMEMs FOR TESTING INTERACTION.
    ##    Number of space variables = 3 
    ##    Number of time variables = 5 
    ##    Number of interaction variables = 2 
    ##    Number of residual degrees of freedom = 13 
    ## 
    ##  Interaction test:   R2 = 0.0406   F = 1.7329   P( 999 perm) = 0.21 
    ##  Space test:         R2 = 0.4543   F = 12.9347   P( 999 perm) = 0.002 
    ##  Time test:          R2 = 0.3529   F = 6.0287   P( 999 perm) = 0.002 
    ## 
    ## -------------------------------------------------------
    ##          Time for computation = 0.326000  sec 
    ## =======================================================
    ## 
    ## =======================================================
    ##         Space-time ANOVA without replicates
    ##                                                   
    ##   Pierre Legendre, Miquel De Caceres, Daniel Borcard
    ## =======================================================
    ## 
    ##  Number of space points (s) = 4 
    ##  Number of time points (tt) = 6 
    ##  Number of observations (n = s*tt) = 24 
    ##  Number of response variables (p) = 1 
    ##  
    ##  Computing dbMEMs to code for space
    ##  Truncation level for space dbMEMs = 1 
    ##  Computing dbMEMs to code for time
    ##  Truncation level for time dbMEMs = 1 
    ## 
    ##  Number of space coding functions = 1 
    ## 
    ##  Number of time coding functions = 2 
    ## 
    ##  MODEL V: HELMERT CONTRAST FOR TESTING MAIN FACTORS.
    ##           SPACE AND TIME dbMEMs FOR TESTING INTERACTION.
    ##    Number of space variables = 3 
    ##    Number of time variables = 5 
    ##    Number of interaction variables = 2 
    ##    Number of residual degrees of freedom = 13 
    ## 
    ##  Interaction test:   R2 = 0.0029   F = 0.1964   P( 999 perm) = 0.825 
    ##  Space test:         R2 = 0.2352   F = 10.789   P( 999 perm) = 0.001 
    ##  Time test:          R2 = 0.6675   F = 18.3728   P( 999 perm) = 0.001 
    ## 
    ## -------------------------------------------------------
    ##          Time for computation = 0.329000  sec 
    ## =======================================================
    ## 
    ## =======================================================
    ##         Space-time ANOVA without replicates
    ##                                                   
    ##   Pierre Legendre, Miquel De Caceres, Daniel Borcard
    ## =======================================================
    ## 
    ##  Number of space points (s) = 4 
    ##  Number of time points (tt) = 6 
    ##  Number of observations (n = s*tt) = 24 
    ##  Number of response variables (p) = 1 
    ##  
    ##  Computing dbMEMs to code for space
    ##  Truncation level for space dbMEMs = 1 
    ##  Computing dbMEMs to code for time
    ##  Truncation level for time dbMEMs = 1 
    ## 
    ##  Number of space coding functions = 1 
    ## 
    ##  Number of time coding functions = 2 
    ## 
    ##  MODEL V: HELMERT CONTRAST FOR TESTING MAIN FACTORS.
    ##           SPACE AND TIME dbMEMs FOR TESTING INTERACTION.
    ##    Number of space variables = 3 
    ##    Number of time variables = 5 
    ##    Number of interaction variables = 2 
    ##    Number of residual degrees of freedom = 13 
    ## 
    ##  Interaction test:   R2 = 0.0545   F = 1.8321   P( 999 perm) = 0.192 
    ##  Space test:         R2 = 0.3694   F = 8.2751   P( 999 perm) = 0.001 
    ##  Time test:          R2 = 0.3826   F = 5.1427   P( 999 perm) = 0.01 
    ## 
    ## -------------------------------------------------------
    ##          Time for computation = 0.326000  sec 
    ## =======================================================

``` r
sti_uni_tibble %>% readr::write_rds("results/sti_uni_tabela_final.Rds")
```

## Arrumando as tabelas

``` r
readr::read_rds("results/sti_uni_tabela_final.Rds") %>%
  dplyr::mutate(
    f = round(f, 2),
    p = round(p, 2),
    r2 = round(r2, 2),
    r2adj = round(r2adj, 2)
  ) %>%
  # R² ajustados negativos foram truncados em zero
  dplyr::mutate(
    r2adj = dplyr::if_else(r2adj < 0, 0, r2adj),
    significativo = dplyr::if_else(p < 0.05, TRUE, FALSE)
  ) %>%
  readr::write_rds("results/sti_uni_tabela_arrumada.Rds")
```
