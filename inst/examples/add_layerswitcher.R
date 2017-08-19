library(openlayers)

ol(options = list(debug = TRUE)) %>%
  add_stamen_tiles() %>%
  add_stamen_tiles("terrain-labels") %>%
  add_vector_data(us_cities[1:10, ],
                  style = marker_style(anchor = c(0.5, 1.1)) + text_style(property = "name", stroke = stroke_style(color = "white"))) %>%
  add_layer_switcher() %>% add_drag_and_drop()
