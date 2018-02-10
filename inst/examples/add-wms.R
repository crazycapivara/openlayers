ol() %>%
  add_stamen_tiles() %>%
  add_wms_tiles("http://ows.terrestris.de/osm/service",
                layers = "TOPO-WMS",
                attribution = "Do not forget to insert the attribution!",
                options = layer_options(opacity = 0.5))
