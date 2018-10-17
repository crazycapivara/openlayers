
<!-- README.md is generated from README.Rmd. Please edit that file -->
An R Interface to OpenLayers
============================

[![Travis-CI Build Status](https://travis-ci.org/crazycapivara/openlayers.svg?branch=master)](https://travis-ci.org/crazycapivara/openlayers) [![Travis-CI Build Status](https://travis-ci.org/crazycapivara/openlayers.svg?branch=develop)](https://travis-ci.org/crazycapivara/openlayers)

[OpenLayers](https://openlayers.org/) is an open-source JavaScript library *making it easy to put a dynamic map in any web page*. The goal of the openlayers R package is to make this functionality available within R via the [htmlwidgets](https://github.com/ramnathv/htmlwidgets) package. Check [NEWS](NEWS.md) file for available functionality.

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
#> openlayers 0.5.0 wrapping openlayersjs v4.6.4
```

``` r
ol() %>%
  add_stamen_tiles() %>%
  set_view(9.5, 51.31667, zoom = 10)

## Points
library("geojsonio")

cities <- us_cities[1:5, ]

ol()  %>%
  add_stamen_tiles() %>%
  add_features(cities, style = icon_style(),
               popup = cities$name)

## Polygons
library("sf")

nc <- st_read(system.file("gpkg/nc.gpkg", package = "sf"),
             quiet = TRUE)

ol() %>%
  add_stamen_tiles("watercolor") %>%
  add_stamen_tiles(
    "terrain-labels",
    options = layer_options(max_resolution = 13000)
  ) %>%
  add_features(
    data = nc,
    style = fill_style("yellow") + stroke_style("blue", 1),
    popup = nc$AREA  
  ) %>%
  add_overview_map()
```

Documentation
-------------

A detailed documentation of the package is still under development, but all functions are documented, so that you can use the build in help functionality of R. Furthermore, check the example scripts in [inst/examples/](https://github.com/crazycapivara/openlayers/blob/master/inst/examples) to get an idea about how to use this package.

Code coverage
-------------

``` r
package_coverage()
#> openlayers Coverage: 61.90%
#> R/legend.R: 0.00%
#> R/styles.R: 22.22%
#> R/vector_tiles.R: 50.00%
#> R/methods.R: 60.00%
#> R/wms.R: 66.67%
#> R/options.R: 90.00%
#> R/controls.R: 100.00%
#> R/dependencies.R: 100.00%
#> R/interactions.R: 100.00%
#> R/ol.R: 100.00%
#> R/plugin-layerswitcher.R: 100.00%
#> R/utils.R: 100.00%
```
