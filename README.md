
<!-- README.md is generated from README.Rmd. Please edit that file -->

# AMBIAGUA-2021-2823

In this repository, the code for the manuscript is available: http://www.ambi-agua.net/seer/index.php/ambi-agua/article/view/2402

## Spatio-temporal variability of water quality in Billings Reservoir Central Body - São Paulo, Brazil

### Abstract

The Billings reservoir is an important water body for public supply of
the Metropolitan Region of São Paulo, Brazil, and water captation for
public supply is located in the Rio Grande environmental compartment.
This article aims to evaluate water quality of the environmental
compartment Central Body I of the Billings reservoir, which receives the
reversed waters from the polluted Pinheiros river, at four sampling
points with different contributions from the surroundings, seeking to
verify the influence of seasonality on the results obtained and whether
there was a difference in water quality between sampling points. Water
sampling was carried out on the surface at four points, in a
longitudinal profile, covering two periods (dry and rainy) distributed
in six samplings, between 2016 and 2019. Analyzed variables included
temperature, dissolved oxygen, pH, electrical conductivity,
chlorophyll-a and nutrients (phosphorus and nitrogen). Space-Time
Interaction tests revealed that physicochemical variables did not vary
due to the interaction between sampling periods and points, but several
variables varied significantly in function of the sampling period.
Result of the Trophic State Index showed that waters of Central Body I
were classified as Hypereutrophic, highlighting the degradation of water
quality in this compartment. The results of this research can subsidize
public managers in an attempt to minimize the effects of progressive
degradation of water quality of this reservoir.

**KEYWORDS**: Eutrophication, Pinheiros river, Urban Reservoir.

## Variabilidade espaço-temporal da qualidade da água superficial do Corpo Central I da represa Billings - São Paulo, Brasil

### Resumo

A represa Billings é um reservatório importante para o abastecimento
público da região metropolitana de São Paulo, no Brasil, e a captação de
água para abastecimento público está localizada no compartimento
ambiental Rio Grande. Este artigo tem como objetivo avaliar a qualidade
das águas do compartimento ambiental Corpo Central I da represa
Billings, que recebe as águas revertidas do poluído rio Pinheiros, em
quatro pontos de coleta com contribuição do entorno diferenciada,
buscando verificar a influência da sazonalidade nos resultados obtidos e
se houve diferença da qualidade da água entre os pontos de coleta. As
coletas de água foram realizadas na superfície em quatro pontos, em um
perfil longitudinal, contemplando dois períodos (estiagem e chuvoso)
distribuídos em seis coletas, entre os anos de 2016 e 2019. As variáveis
analisadas foram temperatura, oxigênio dissolvido, pH, condutividade
elétrica, clorofila-a e nutrientes (fósforo e nitrogênio). Os testes de
Interação Espaço-Tempo revelaram que as variáveis físico-químicas não
variaram devido à interação entre os pontos e períodos de amostragem,
mas diversas variáveis variaram significativamente em função do período
de amostragem. O resultado do Índice de Estado Trófico evidenciou que as
águas do Corpo Central I foram classificadas como Hipereutróficas,
destacando a degradação da qualidade das águas neste compartimento. Os
resultados desta pesquisa podem subsidiar os gestores públicos na
tentativa de minimizar os efeitos da degradação progressiva da qualidade
da água deste reservatório.

**PALAVRAS-CHAVE**: Eutrofização, Rio Pinheiros, Reservatório Urbano.

## Packages used in this repository

``` r
devtools::load_all()
sessioninfo::package_info()
#>  ! package             * version    date (UTC) lib source
#>    ade4                  1.7-19     2022-04-19 [1] CRAN (R 4.1.1)
#>    adegenet              2.1.5      2021-10-09 [1] CRAN (R 4.1.1)
#>    adegraphics           1.0-16     2021-09-16 [1] CRAN (R 4.1.1)
#>    adephylo              1.1-11     2017-12-18 [1] CRAN (R 4.1.0)
#>    adespatial            0.3-16     2022-03-31 [1] CRAN (R 4.1.1)
#>    ape                   5.6-2      2022-03-02 [1] CRAN (R 4.1.1)
#>    assertthat            0.2.1      2019-03-21 [1] CRAN (R 4.1.0)
#>    base64enc             0.1-3      2015-07-28 [1] CRAN (R 4.1.0)
#>    boot                  1.3-28     2021-05-03 [1] CRAN (R 4.1.2)
#>    brio                  1.1.3      2021-11-30 [1] CRAN (R 4.1.1)
#>    cachem                1.0.6      2021-08-19 [1] CRAN (R 4.1.1)
#>    callr                 3.7.0      2021-04-20 [1] CRAN (R 4.1.0)
#>    class                 7.3-20     2022-01-13 [1] CRAN (R 4.1.1)
#>    classInt              0.4-3      2020-04-07 [1] CRAN (R 4.1.0)
#>    cli                   3.3.0      2022-04-25 [1] CRAN (R 4.1.2)
#>    cluster               2.1.2      2021-04-17 [1] CRAN (R 4.1.2)
#>    codetools             0.2-18     2020-11-04 [1] CRAN (R 4.1.2)
#>    colorspace            2.0-3      2022-02-21 [1] CRAN (R 4.1.1)
#>    corrplot              0.92       2021-11-18 [1] CRAN (R 4.1.1)
#>    crayon                1.5.1      2022-03-26 [1] CRAN (R 4.1.1)
#>    data.table            1.14.2     2021-09-27 [1] CRAN (R 4.1.1)
#>    DBI                   1.1.2      2021-12-20 [1] CRAN (R 4.1.1)
#>    deldir                1.0-6      2021-10-23 [1] CRAN (R 4.1.1)
#>    desc                  1.4.1      2022-03-06 [1] CRAN (R 4.1.1)
#>    devtools              2.4.3      2021-11-30 [1] CRAN (R 4.1.1)
#>    digest                0.6.29     2021-12-01 [1] CRAN (R 4.1.1)
#>    dplyr                 1.0.8      2022-02-08 [1] CRAN (R 4.1.1)
#>    e1071                 1.7-9      2021-09-16 [1] CRAN (R 4.1.1)
#>    ellipse               0.4.2      2020-05-27 [1] CRAN (R 4.1.0)
#>    ellipsis              0.3.2      2021-04-29 [1] CRAN (R 4.1.0)
#>    evaluate              0.15       2022-02-18 [1] CRAN (R 4.1.1)
#>    fansi                 1.0.3      2022-03-24 [1] CRAN (R 4.1.1)
#>    fastmap               1.1.0      2021-01-25 [1] CRAN (R 4.1.0)
#>    flextable             0.7.0      2022-03-06 [1] CRAN (R 4.1.1)
#>    forcats               0.5.1      2021-01-27 [1] CRAN (R 4.1.0)
#>    fs                    1.5.2      2021-12-08 [1] CRAN (R 4.1.1)
#>    ftExtra               0.3.0      2022-01-04 [1] CRAN (R 4.1.1)
#>    gdtools               0.2.4      2022-02-14 [1] CRAN (R 4.1.1)
#>    generics              0.1.2      2022-01-31 [1] CRAN (R 4.1.1)
#>    ggplot2               3.3.5      2021-06-25 [1] CRAN (R 4.1.1)
#>    glue                  1.6.2      2022-02-24 [1] CRAN (R 4.1.1)
#>    gtable                0.3.0      2019-03-25 [1] CRAN (R 4.1.0)
#>    hms                   1.1.1      2021-09-26 [1] CRAN (R 4.1.1)
#>    htmltools             0.5.2.9000 2022-03-14 [1] Github (rstudio/htmltools@9490b62)
#>    httpuv                1.6.5      2022-01-05 [1] CRAN (R 4.1.1)
#>    httr                  1.4.2      2020-07-20 [1] CRAN (R 4.1.0)
#>    igraph                1.2.11     2022-01-04 [1] CRAN (R 4.1.1)
#>    jpeg                  0.1-9      2021-07-24 [1] CRAN (R 4.1.0)
#>    KernSmooth            2.23-20    2021-05-03 [1] CRAN (R 4.1.2)
#>    knitr                 1.38       2022-03-25 [1] CRAN (R 4.1.1)
#>    later                 1.3.0      2021-08-18 [1] CRAN (R 4.1.1)
#>    lattice               0.20-45    2021-09-22 [1] CRAN (R 4.1.2)
#>    latticeExtra          0.6-29     2019-12-19 [1] CRAN (R 4.1.0)
#>    lazyeval              0.2.2      2019-03-15 [1] CRAN (R 4.1.0)
#>    lifecycle             1.0.1      2021-09-24 [1] CRAN (R 4.1.1)
#>    magrittr              2.0.3      2022-03-30 [1] CRAN (R 4.1.1)
#>  P manuscript.AmbiAgua * 0.0.0.9000 2022-04-28 [?] load_all()
#>    MASS                  7.3-55     2022-01-13 [1] CRAN (R 4.1.1)
#>    Matrix                1.4-0      2021-12-08 [1] CRAN (R 4.1.1)
#>    memoise               2.0.1      2021-11-26 [1] CRAN (R 4.1.1)
#>    mgcv                  1.8-39     2022-02-24 [1] CRAN (R 4.1.1)
#>    mime                  0.12       2021-09-28 [1] CRAN (R 4.1.1)
#>    munsell               0.5.0      2018-06-12 [1] CRAN (R 4.1.0)
#>    nlme                  3.1-155    2022-01-13 [1] CRAN (R 4.1.1)
#>    officer               0.4.2      2022-03-23 [1] CRAN (R 4.1.1)
#>    patchwork             1.1.1      2020-12-17 [1] CRAN (R 4.1.0)
#>    permute               0.9-7      2022-01-27 [1] CRAN (R 4.1.1)
#>    phylobase             0.8.10     2020-03-01 [1] CRAN (R 4.1.0)
#>    pillar                1.7.0      2022-02-01 [1] CRAN (R 4.1.1)
#>    pkgbuild              1.3.1      2021-12-20 [1] CRAN (R 4.1.1)
#>    pkgconfig             2.0.3      2019-09-22 [1] CRAN (R 4.1.0)
#>    pkgload               1.2.4      2021-11-30 [1] CRAN (R 4.1.1)
#>    plyr                  1.8.7      2022-03-24 [1] CRAN (R 4.1.1)
#>    png                   0.1-7      2013-12-03 [1] CRAN (R 4.1.0)
#>    prettyunits           1.1.1      2020-01-24 [1] CRAN (R 4.1.0)
#>    processx              3.5.3      2022-03-25 [1] CRAN (R 4.1.1)
#>    progress              1.2.2      2019-05-16 [1] CRAN (R 4.1.0)
#>    promises              1.2.0.1    2021-02-11 [1] CRAN (R 4.1.0)
#>    proxy                 0.4-26     2021-06-07 [1] CRAN (R 4.1.0)
#>    ps                    1.6.0      2021-02-28 [1] CRAN (R 4.1.0)
#>    purrr                 0.3.4      2020-04-17 [1] CRAN (R 4.1.0)
#>    R6                    2.5.1      2021-08-19 [1] CRAN (R 4.1.1)
#>    raster                3.5-15     2022-01-22 [1] CRAN (R 4.1.1)
#>    RColorBrewer          1.1-3      2022-04-03 [1] CRAN (R 4.1.2)
#>    Rcpp                  1.0.8.3    2022-03-17 [1] CRAN (R 4.1.1)
#>    readr                 2.1.2      2022-01-30 [1] CRAN (R 4.1.1)
#>    remotes               2.4.2      2021-11-30 [1] CRAN (R 4.1.1)
#>    reshape2              1.4.4      2020-04-09 [1] CRAN (R 4.1.0)
#>    rlang                 1.0.2      2022-03-04 [1] CRAN (R 4.1.1)
#>    rmarkdown             2.13.7     2022-04-21 [1] Github (rstudio/rmarkdown@3440bbf)
#>    rncl                  0.8.6      2022-03-18 [1] CRAN (R 4.1.1)
#>    RNeXML                2.4.6      2022-02-09 [1] CRAN (R 4.1.1)
#>    rprojroot             2.0.3      2022-04-02 [1] CRAN (R 4.1.1)
#>    rstudioapi            0.13       2020-11-12 [1] CRAN (R 4.1.0)
#>    s2                    1.0.7      2021-09-28 [1] CRAN (R 4.1.1)
#>    scales                1.2.0      2022-04-13 [1] CRAN (R 4.1.1)
#>    SciViews              0.9-13.1   2019-11-16 [1] CRAN (R 4.1.0)
#>    seqinr                4.2-8      2021-06-09 [1] CRAN (R 4.1.0)
#>    sessioninfo           1.2.2      2021-12-06 [1] CRAN (R 4.1.1)
#>    sf                    1.0-7      2022-03-07 [1] CRAN (R 4.1.1)
#>    shiny                 1.7.1      2021-10-02 [1] CRAN (R 4.1.1)
#>    sp                    1.4-7      2022-04-20 [1] CRAN (R 4.1.1)
#>    spData                2.0.1      2021-10-14 [1] CRAN (R 4.1.1)
#>    spdep                 1.2-4      2022-04-18 [1] CRAN (R 4.1.1)
#>    stringi               1.7.6      2021-11-29 [1] CRAN (R 4.1.1)
#>    stringr               1.4.0      2019-02-10 [1] CRAN (R 4.1.0)
#>    systemfonts           1.0.4      2022-02-11 [1] CRAN (R 4.1.1)
#>    terra                 1.5-21     2022-02-17 [1] CRAN (R 4.1.1)
#>    testthat              3.1.3      2022-03-29 [1] CRAN (R 4.1.1)
#>    tibble                3.1.6      2021-11-07 [1] CRAN (R 4.1.1)
#>    tidyr                 1.2.0      2022-02-01 [1] CRAN (R 4.1.1)
#>    tidyselect            1.1.2      2022-02-21 [1] CRAN (R 4.1.1)
#>    tzdb                  0.3.0      2022-03-28 [1] CRAN (R 4.1.1)
#>    units                 0.8-0      2022-02-05 [1] CRAN (R 4.1.1)
#>    usethis               2.1.5      2021-12-09 [1] CRAN (R 4.1.1)
#>    utf8                  1.2.2      2021-07-24 [1] CRAN (R 4.1.0)
#>    uuid                  1.1-0      2022-04-19 [1] CRAN (R 4.1.2)
#>    vctrs                 0.4.1      2022-04-13 [1] CRAN (R 4.1.1)
#>    vegan                 2.5-7      2020-11-28 [1] CRAN (R 4.1.0)
#>    withr                 2.5.0      2022-03-03 [1] CRAN (R 4.1.1)
#>    wk                    0.6.0      2022-01-03 [1] CRAN (R 4.1.1)
#>    xfun                  0.30       2022-03-02 [1] CRAN (R 4.1.1)
#>    XML                   3.99-0.9   2022-02-24 [1] CRAN (R 4.1.1)
#>    xml2                  1.3.3      2021-11-30 [1] CRAN (R 4.1.1)
#>    xtable                1.8-4      2019-04-21 [1] CRAN (R 4.1.0)
#>    yaml                  2.3.5      2022-02-21 [1] CRAN (R 4.1.1)
#>    zip                   2.2.0      2021-05-31 [1] CRAN (R 4.1.0)
#> 
#>  [1] /Library/Frameworks/R.framework/Versions/4.1-arm64/Resources/library
#> 
#>  P ── Loaded and on-disk path mismatch.
```
