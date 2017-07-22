
<!-- README.md is generated from README.Rmd. Please edit that file -->
An R Interface to OpenLayers
============================

[OpenLayers](https://openlayers.org/) is an open-source JavaScript library *making it easy to put a dynamic map in any web page*. The goal of the openlayers R package is to make this functionalty available within R via the [htmlwidgets](https://github.com/ramnathv/htmlwidgets) package. Please note this package is still a beta version (check [NEWS](NEWS.md) file for available functionality). Under the hood it wraps OpenLayers v4.2.0.

Installation
------------

You can install openlayers from github with:

``` r
# install.packages("devtools")
devtools::install_github("crazycapivara/openlayers")

# latest version
devtools::install_github("crazycapivara/openlayers", ref = "develop")
```

Examples
--------

Here we go with some basic examples:

``` r
library(openlayers)

ol() %>% add_stamen_tiles() %>% set_view(9.5, 51.31667, zoom = 10)

ol()  %>% add_stamen_tiles() %>%
  add_geojson(
    geojsonio::geojson_json(quakes[1:10, ]),
    style = marker_style()
  )

library(sf)

nc = st_read(system.file("gpkg/nc.gpkg", package = "sf"), quiet = TRUE)

ol() %>% add_stamen_tiles("terrain") %>%
  add_geojson(geojsonio::geojson_json(nc))
```

Documentation
-------------

The documentation is still under development, so that some function docs are missing.
