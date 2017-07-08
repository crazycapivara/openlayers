
<!-- README.md is generated from README.Rmd. Please edit that file -->
An R Interface to OpenLayers
============================

[OpenLayers](https://openlayers.org/) is an open-source JavaScript library "making it easy to put a dynamic map in any web page". The goal of this R Package is to make its functionalty available within R. The documentation of the package is still under development and the package itself in an early beta stage. It wraps OpenLayers v4.2.0.

Installation
------------

You can install openlayers from github with:

``` r
# install.packages("devtools")
devtools::install_github("crazycapivara/openlayers")
```

Examples
--------

This are basic examples showing you how to use the package:

``` r
library(openlayers)

ol() %>% add_stamen_tiles() %>% set_view(9.5, lat = 51.31667, zoom = 10)

library(sf)

nc = st_read(system.file("gpkg/nc.gpkg", package = "sf"), quiet = TRUE)

ol() %>% add_stamen_tiles("terrain") %>%
  add_geojson(geojsonio::geojson_json(nc))
```
