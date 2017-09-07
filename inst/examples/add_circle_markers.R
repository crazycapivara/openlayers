library(openlayers)
library(geojsonio)

style <- circle_style(
  stroke = stroke_style(color = "yellow"),
  fill = fill_style(),
  radius = 15
)

data <- us_cities[1:10, ]

map <- ol() %>% add_stamen_tiles("toner")

map %>% add_geojson(geojson_json(data), style = style)

style_ <- style + text_style(property = "capital", scale = 2.5)

map  %>% add_features(data, style = style_)
