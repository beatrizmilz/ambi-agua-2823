generate_pca_plot <- function(dados,
                              autovecs,
                              pc_x = 1,
                              pc_y = 2) {
  autovecs <- as.data.frame(autovecs)
  autovecs_pc <- autovecs[, c(pc_x, pc_y)]

  autovecs_filter <- autovecs_pc %>%
    dplyr::rename_all( ~ stringr::str_remove(. , "A")) %>%
    dplyr::mutate(filtro = dplyr::case_when(abs(.[[1]]) > .7 |
                                              abs(.[[2]]) > .7  ~ TRUE,
                                            TRUE ~ FALSE)) %>%
    dplyr::filter(filtro == TRUE) %>%
    dplyr::select(-filtro) %>%
    tibble::rownames_to_column("var") %>%
    dplyr::mutate(
      var = dplyr::case_when(
        var == "water_temperature" ~ "WT",
        var == "dissolved_oxygen" ~ "DO",
        var == "electrical_conductivity" ~ "EC",
        is.na(var) ~ " ",
        TRUE ~ var
      )
    )



  nome_eixo_x <- paste0("PC", pc_x)
  nome_eixo_y <- paste0("PC", pc_y)


  dados %>%
    ggplot2::ggplot() +
    ggplot2::geom_point(ggplot2::aes(
      x = .data[[nome_eixo_x]],
      y = .data[[nome_eixo_y]],
      color = season,
      shape = sampling_sites,
      size = 1.5
    )) +
    ggplot2::scale_color_viridis_d(begin = 0.4, end = 0.8) +
    ggplot2::scale_shape_manual(values = c(15, 16, 17, 18)) +
    ggplot2::scale_size(guide = "none") +
    ggplot2::theme_light() +
    ggplot2::labs(
      x = paste(nome_eixo_x, " (", round(p.exp_PCA[pc_x], 2), "%)", sep = ""),
      y = paste(nome_eixo_y, " (", round(p.exp_PCA[pc_y], 2), "%)", sep = ""),
      color = "Season",
      shape = "Sampling points"
    ) +
    ggplot2::geom_hline(yintercept = 0, linetype = "dashed") +
    ggplot2::geom_vline(xintercept = 0, linetype = "dashed") +

    ggplot2::geom_segment(
      data = autovecs_filter,
      ggplot2::aes(
        x = 0,
        y = 0,
        xend = (.data[[nome_eixo_x]] * 2),
        yend = (.data[[nome_eixo_y]] * 2)

      ),
      arrow = arrow(length = unit(1 / 2, "picas")),
      color = "black"
    ) +
    ggplot2::annotate(
      "text",
      x = (autovecs_filter[[2]] * 2.5),
      y = (autovecs_filter[[3]] * 2.5),
      label = autovecs_filter$var
    ) #+
  #theme(legend.position = "none")
}
