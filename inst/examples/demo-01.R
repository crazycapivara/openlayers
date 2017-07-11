library(openlayers)

data <- geojsonio::geojson_json(quakes[1:10, ])

# default style
ol() %>% add_osm_tiles() %>% add_geojson_(data)

# custom style
style <- stroke(color = "green", width = 2) + fill()

ol() %>% add_osm_tiles() %>% add_geojson_(data, style = style)

# markers
ol() %>% add_osm_tiles() %>% add_geojson_(data, style = marker())
