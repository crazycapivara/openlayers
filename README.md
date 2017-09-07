
<!-- README.md is generated from README.Rmd. Please edit that file -->
An R Interface to OpenLayers
============================

[![Travis-CI Build Status](https://travis-ci.org/crazycapivara/openlayers.svg?branch=master)](https://travis-ci.org/crazycapivara/openlayers) [![Travis-CI Build Status](https://travis-ci.org/crazycapivara/openlayers.svg?branch=develop)](https://travis-ci.org/crazycapivara/openlayers)

[OpenLayers](https://openlayers.org/) is an open-source JavaScript library *making it easy to put a dynamic map in any web page*. The goal of the openlayers R package is to make this functionality available within R via the [htmlwidgets](https://github.com/ramnathv/htmlwidgets) package. Please note this package is still a beta version (check [NEWS](NEWS.md) file for available functionality).

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
#> openlayers 0.4.4 wrapping openlayersjs v4.3.1
```

``` r
ol() %>%
  add_stamen_tiles() %>%
  set_view(9.5, 51.31667, zoom = 10)

require("geojsonio")

features <- us_cities[1:5, ]

ol()  %>%
  add_stamen_tiles() %>%
  add_geojson(
    geojson_json(features),
    style = icon_style(),
    popup = features$name
  )

require("sf")

nc = st_read(system.file("gpkg/nc.gpkg", package = "sf"), quiet = TRUE)

ol() %>%
  add_stamen_tiles("watercolor") %>%
  add_stamen_tiles("terrain-labels") %>%
  add_features(nc) %>%
  add_overview_map()
```

Documentation
-------------

A detailed documentation of the package is still under development, but all functions are documented, so that you can use the build in help functionality of R. Furthermore, check the example scripts in [inst/examples/](inst/examples/) to get an idea about how to use this package.

Code coverage
-------------

``` r
package_coverage(function_exclusions = c(
  "layerswitcher_dependencies",
  "make_icon"))
#> openlayers Coverage: 41.44%
#> R/plugin-layerswitcher.R: 0.00%
#> R/methods.R: 9.09%
#> R/styles.R: 21.74%
#> R/ol.R: 75.00%
#> R/options.R: 87.50%
#> R/controls.R: 100.00%
#> R/interactions.R: 100.00%
#> R/utils.R: 100.00%
```
