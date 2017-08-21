library(openlayers)

ol(options = list(debug = TRUE)) %>%
  add_stamen_tiles() %>%
  add_stamen_tiles("terrain-labels", options = list(name = "terrain-labels")) %>%
  add_vector_data(us_cities[1:10, ],
                  style = marker_style() + text_style(offset = c(0, 20), property = "name", stroke = stroke_style(color = "white"))) %>%
  add_layer_switcher() %>% add_drag_and_drop()
