library(openlayers)

data <- geojsonio::geojson_json(quakes[1:10, ])
data2 <- geojsonio::geojson_json(quakes[21:25, ])


# default style
ol() %>% add_osm_tiles() %>% add_geojson_(data)

# custom style
style <- stroke_style(color = "green", width = 2) %+% fill_style()
style <- c(stroke_style(color = "green", width = 2), fill_style())
style <- style_that(fill_color = "green")
style <- style_that(stroke_width = 5)
style <- stroke_style()
style <- stroke_style() + fill_style()

ol() %>% add_osm_tiles() %>% add_geojson_(filename = "inst/geojson/nc.geojson",
                                          style = style, opacity = 0.5)

ol() %>% add_osm_tiles() %>% add_geojson_(data, style = circle_style(radius = 15)) %>%
  add_geojson_(data2, style = circle_style(fill = fill_style(color = "red")))

# pass radius array
radius = seq(10, 55, 5)
ol() %>% add_osm_tiles() %>% add_geojson_(data, style = circle_style(radius = radius))

style = circle_style(radius = radius)

text = as.character(quakes[1:10, ]$mag)
style = circle_style(radius = radius) + text_style(text)
style = circle_style(radius = radius) + text_style(property = "stations")

ol() %>% add_osm_tiles() %>% add_geojson_(data, style = style)

# markers
icon <- "http://openlayers.org/en/v4.2.0/examples/data/icon.png"
icon = "http://www.osgeo.org/sites/all/themes/osgeo/logo.png"
ol() %>% add_osm_tiles() %>% add_geojson_(data, style = marker_style(icon))

# use cutom js function
js_func <- "inst/javascript/style_function.js"
ol() %>% add_osm_tiles() %>% add_geojson_(data, style = js_style_function(js_func))
