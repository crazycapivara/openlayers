library(openlayers)
library(sf)
library(geojsonio)

nc = st_read(system.file("gpkg/nc.gpkg", package = "sf"), quiet = TRUE)
nc_json <- geojson_json(nc)

# default style
ol() %>% add_osm_tiles() %>% add_geojson_(nc_json)

url_ <- "http://tile.stamen.com/watercolor/{z}/{x}/{y}.png"
ol() %>% add_xyz_tiles(url_)

ol() %>% add_osm_tiles() %>% add_xyz_tiles(url_, opacity = 0.3)

ol() %>% add_osm_tiles() %>% add_xyz_tiles(url_, opacity = 0.3) %>%
  add_geojson_(nc_json)

ol() %>% add_osm_tiles() %>% add_xyz_tiles(url_, opacity = 0.3) %>%
  add_geojson_(nc_json, style = fill_style() + stroke_style(width = 1.5))
