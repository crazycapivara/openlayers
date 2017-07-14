library(openlayers)

data <- geojsonio::geojson_json(quakes[1:10, ])

# default style
ol() %>% add_osm_tiles() %>% add_geojson_(data)

# custom style
style <- stroke_style(color = "green", width = 2) %+% fill_style()
style <- c(stroke_style(color = "green", width = 2), fill_style())

ol() %>% add_osm_tiles() %>% add_geojson_(filename = "inst/geojson/nc.geojson", style = style)
ol() %>% add_osm_tiles() %>% add_geojson_(data, style = style)

# markers
icon <- "http://openlayers.org/en/v4.2.0/examples/data/icon.png"
icon = "http://www.osgeo.org/sites/all/themes/osgeo/logo.png"
ol() %>% add_osm_tiles() %>% add_geojson_(data, style = marker_style(icon))

# use cutom js function
js_func <- "inst/javascript/style_function.js"
ol() %>% add_osm_tiles() %>% add_geojson_(data, style = js_style_function(js_func))
