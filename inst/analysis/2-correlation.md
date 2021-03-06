Correlation
================

``` r
devtools::load_all()
library(corrplot)
```

## Arrumando os dados

``` r
sampling_data_numeric <-
  #Selecionar apenas variáveis numéricas
  dplyr::select_if(sampling_data_wide, is.numeric) %>% 
  # Remover coluna das variáveis calculadas, e também das variáveis que não temos dados para todas as coletas
  dplyr::select(
    -id,
    -sampling_event_num,
    -sampling_sites,
    -euphotic_zone_depth,
    -secchi_depth,
    -tsi_tsr,
    -NP_ratio
  ) %>%  
  dplyr::mutate_all(tidyr::replace_na, 0) # Os NA são referentes à amostras abaixo do limite de detecção. Substituí por 0, pois dá erro na matriz se deixar NA
```

## Matriz de correlação

``` r
correlacao <- cor(sampling_data_numeric)

corrplot::corrplot(correlacao)
```

![](2-correlation_files/figure-gfm/unnamed-chunk-3-1.png)<!-- -->
