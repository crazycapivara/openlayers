library("openlayers")
library("sf")

nc <- system.file("shape/nc.shp", package = "sf") %>% st_read(quiet = TRUE)
nc$color <- ifelse(nc$AREA > 0.2, "green", "yellow")

map <- ol() %>%
  add_stamen_tiles() %>%
  add_features(
    data = nc,
    style = fill_style(nc$color) + stroke_style("blue", 1),
    popup = nc$AREA
  )

map %>%
  add_legend(
    colors = c("yellow", "green"),
    labels = c("0 - 0.2", "> 0.2"),
    title = "area",
    style = list(bottom = "50px", opacity = 0.7)
  ) %>%
  add_scale_line()

map %>%
  add_legend(
    colors = c("yellow", "green"),
    labels = c("0 - 0.2", "> 0.2"),
    title = "area",
    overlay = FALSE
  ) %>%
  add_overview_map()
