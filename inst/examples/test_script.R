library(openlayers)
library(sf)
library(geojsonio)

# get some data
nc = st_read(system.file("gpkg/nc.gpkg", package = "sf"), quiet = TRUE)
nc_json <- geojson_json(nc)

qu <- quakes[1:10, ]
qu_json <- geojsonio::geojson_json(qu)

# default style
ol() %>% add_osm_tiles() %>% add_geojson(nc_json)

url_ <- "http://tile.stamen.com/watercolor/{z}/{x}/{y}.png"
ol() %>% add_xyz_tiles(url_)

ol() %>% add_osm_tiles() %>% add_xyz_tiles(url_, opacity = 0.3)

ol() %>% add_osm_tiles() %>% add_xyz_tiles(url_, opacity = 0.3) %>%
  add_geojson(nc_json)

ol() %>% add_xyz_tiles(url_, opacity = 0.3) %>%
  add_geojson(nc_json, style = fill_style() + stroke_style(width = 1.5))

# multiple colors
colors <- substr(rainbow(100), 1, 7)
ol() %>% add_xyz_tiles(url_) %>% add_geojson(nc_json, style = fill_style(color = colors))

# circle markers
ol() %>% add_xyz_tiles(url_) %>% add_geojson(qu_json)

ol() %>% add_xyz_tiles(url_) %>% add_geojson(qu_json, style = icon_style())

# multiple radii
colors <- substr(rainbow(10), 1, 7)
style <- circle_style(radius = seq(10, 55, 5), fill = fill_style(colors))
ol() %>% add_xyz_tiles(url_) %>% add_geojson(qu_json, style = style, opacity = 0.5)

style <- style + text_style(property = "stations")
ol() %>% add_xyz_tiles(url_) %>% add_geojson(qu_json, style = style, opacity = 0.5)

# use geojson url
colors <- substr(rainbow(176), 1, 7)
geojson_url = "https://raw.githubusercontent.com/datasets/geo-boundaries-world-110m/master/countries.geojson"
ol() %>% add_xyz_tiles(url_) %>% add_geojson(filename = geojson_url, style = fill_style(colors))
