library(openlayers)

tile_url <- get_cartodb_xyz_url()
attribution <- cartodb_attribution()

message(tile_url)
message(attribution)

ol() %>% add_xyz_tiles(tile_url, attribution)
