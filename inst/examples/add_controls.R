library(openlayers)

# add scale line and mouse position control
map <- ol() %>% add_stamen_tiles() %>%
  add_scale_line() %>% add_mouse_position()

map

# add overview map
map <- ol() %>% add_osm_tiles() %>%
  add_overview_map(collapsed = FALSE)

map
