library(openlayers)
library(sf)

nc <- st_read(system.file("gpkg/nc.gpkg", package = "sf"),
              quiet = TRUE)

nc$color <- ifelse(nc$AREA > 0.2, "yellow", "blue")

ol() %>%
  add_stamen_tiles("watercolor") %>%
  add_features(
    data = nc,
    style = fill_style(nc$color) + stroke_style("#efefef", 1),
    popup = paste("<b>NAME:</b>", nc$AREA)
  )
