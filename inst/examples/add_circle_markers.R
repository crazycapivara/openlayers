library(openlayers)
library(geojsonio)

quason <- geojson_json(quakes[1:20, ])

style <- circle_style(
  stroke = stroke_style(color = "yellow"),
  fill = fill_style(),
  radius = 15
)

map <- ol() %>% add_stamen_tiles("toner") %>%
  add_geojson(quason, style = style)

map

style <- style + text_style(property = "mag", scale = 1.0)

map <- ol() %>% add_stamen_tiles("toner") %>%
  add_geojson(quason, style = style)

map
