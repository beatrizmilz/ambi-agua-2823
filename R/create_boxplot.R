create_boxplot <-
  function(dados = sampling_data,
           variavel_y,
           legenda_y = "Concentration (μg/L)",
           esconder_legenda_x = TRUE,
           esconder_legenda_fill = TRUE,
           esconder_legenda_y = FALSE) {
    grafico <- dados %>%
      dplyr::filter(variable %in% c(variavel_y)) %>%

      ggplot2::ggplot() +
      ggplot2::geom_boxplot(ggplot2::aes(x = season,
                       y = result_variable,
                       fill = sampling_point)) +
      ggplot2::scale_fill_brewer(palette = "Greys", direction = -1) +
      ggplot2::labs(fill = "Sampling point",
           y = legenda_y,
           x = "Season") +
      ggplot2::facet_wrap( ~ variable_name_abrev, scales = "free_y") +
      ggplot2::theme_bw() +
      ggplot2::theme(plot.title = ggplot2::element_text(hjust = 0.5))

    if (esconder_legenda_x == TRUE) {
      grafico <- grafico +
        ggplot2::theme(axis.title.x = ggplot2::element_blank())
    }

    if (esconder_legenda_fill == TRUE) {
      grafico <- grafico +
        ggplot2::theme(legend.position = "none")
    }

    if (esconder_legenda_fill == FALSE) {
      grafico <- grafico +
        ggplot2::theme(legend.position = "bottom")
    }

    if (esconder_legenda_y == TRUE) {
      grafico <- grafico +
        ggplot2::theme(axis.title.y = ggplot2::element_blank())
    }

    grafico
  }
