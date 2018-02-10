# resolution example

ol(options = list(debug = TRUE)) %>%
  add_stamen_tiles() %>%
  add_stamen_tiles("terrain-labels", options = layer_options(maxResolution = 13000))
