library(openlayers)

quason <- geojsonio::geojson_json(quakes[1:6, ])

# read custom Javascript style function
style_func <- system.file("javascript/another_style_function.js", package = "openlayers") %>%
  read_js_function()

message(style_func)

# zoom in and out show and hide text information
ol() %>% add_stamen_tiles %>% add_geojson(quason, style = style_func)
