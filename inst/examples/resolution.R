# resolution example

# TODO: parse options parameters so that 'max_resoltion' can be used!
ol(options = list(debug = TRUE)) %>%
  add_stamen_tiles() %>%
  add_stamen_tiles("terrain-labels", options = layer_options(max_resolution = 13000))

library(geojsonio)

cities <- us_cities[1:5, ]

# zoom in and out to show text or icons
ol(options = list(debug = TRUE)) %>%
  add_stamen_tiles() %>%
  add_features(cities, style = icon_style(),
               options = list(min_resolution = 5000)) %>%
  add_features(cities, style = text_style(property = "name"),
               options = list(max_resolution = 5000))
