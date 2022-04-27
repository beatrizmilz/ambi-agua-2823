## code to prepare `dataset_pca_sti` dataset goes here
devtools::load_all()

dataset_pca_sti <- sampling_data_long %>%

  # Deixando a variável de estação/season como factor
  dplyr::mutate(season = forcats::as_factor(season)) %>%

  # substituindo texto com números
  dplyr::mutate(season_numeric = forcats::fct_recode(season,
                                                     "1" = "rainy",
                                                     "2" = "dry")) %>%
  # transformando a variável em numérico
  dplyr::mutate(season_numeric = as.numeric(season_numeric)) %>%

  # arredondando resultados
  dplyr::mutate(result_variable = round(result_variable, digits = 2)) %>%

  # substituindo os NA's (que são os valores abaixo de LD e LQ com 0)
  dplyr::mutate(result_variable = dplyr::case_when(
    !is.na(result_variable) ~ result_variable,

    is.na(result_variable) ~ 0
  ))  %>%
  # transformando a tabela em wide
  tidyr::pivot_wider(names_from = variable,
                     values_from = result_variable) %>%
  # transformando em data_frame
  as.data.frame()


# deixa o ID da amostra como número da linha
rownames(dataset_pca_sti) <- dplyr::pull(dataset_pca_sti, id)


usethis::use_data(dataset_pca_sti, overwrite = TRUE)
