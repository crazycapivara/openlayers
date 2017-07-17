# issues

* use nodejs and browsify
  - to test javascript code use nodjs
  - use grunt and browsify to create `ol.js`

* add possibility to pass resolution parameter for styles
  - style should only be applied at a given resolution (already a js parameter)

* add `url` parameter to `add_geojson`
  - so that data do not need to be passed to the widget
  - check how pass filenames as well
  
* shiny integration
  - add event listeners
  - add ol proxy (like leaflet proxy in leaflet (for R) package)

* add `add_vector` R function
  - convert data objects with `geojsonio::geojson_json` and read files (shp, etc) via `sf::st_read`
  - throw error message when packages are not available, because they should not be dependencies
  - pass data to `add_geojson`
  
* ol options
  - add `ol_options` parameter to `ol()` for setting up values like max zoom etc.
  - maybe also stlye funcs could be passed `htmltools` (check `dependencies` funcs)

* add layer switcher
  - use plugin from github
  - https://github.com/walkermatt/ol3-layerswitcher
  
* add popups
  - use plugin from github
  - https://github.com/walkermatt/ol3-popup
  
