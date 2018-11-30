# openlayers 0.5.2

* Fixed bug [#18](https://github.com/crazycapivara/openlayers/issues/13): Display properties as overlay

# openlayers 0.5.1

* Fixed bug when `ol` widget is rendered in shiny via `renderUI`: [issue #13](https://github.com/crazycapivara/openlayers/issues/13)

# openlayers 0.5.0

* Added legend support
  - `add_legend`

# openlayers 0.4.9

* Upgrade to `OpenLayers` v4.6.4
* Added support for `minResolution`, `maxResolution` and `renderMode` options in `addGeojson`
  - options are passed via the `options` parameter in the R functions `add_geojson` and `add_features`
* Added support for styling vector tiles by property

# openlayers 0.4.8

* Upgrade to `OpenLayers` v4.5.0

# openlayers 0.4.7

* `add_<format>_vector_tiles` functions (as introduced in v0.4.6) were replaced by the generic function `add_vector_tiles`, which by default guesses the `format` parameter 
* the stroke color in `stroke_style` can now also be a vector of length equal to the number of features

# openlayers 0.4.6

* Added support for vector tiles, supported formats:
  - mvt (mapbox vector tiles): `add_mapbox_vector_tiles`
  - topojson: `add_topojson_vector_tiles`
  - geojson: `add_geojson_vector_tiles`

# openlayers 0.4.5

* Added wms support
  - `add_wms_tiles`
* Added more parameters to `ol_options`
  - `collapsible_attribution`: fixed or collapsible attribution
  - `zoom_control`: show or hide zoom control 
                       
# openlayers 0.4.4

* Renamed `add_vector_data` (will be removed in a future release) to `add_features`
* Fixed bug in drag and drop caused by new popup parameter

# openlayers 0.4.3

* Added popup support

# openlayers 0.4.2

* Switched to `OpenLayers` v4.3.1

# openlayers 0.4.1

* Added `name` and `type` parameters to `layer_options` 
* Added `ol-layerswitcher` plugin
  - `add_layer_switcher`
  - in order to add layers to the menu just set the `name` parameter of the layer
  - set `type` parameter to `"base"` for base layers
  - layers dropped to the map get random names based on the names-generator from _docker_
* Added horizontal and vertical text offset (parameters) to `text_style`
* Added and updated examples
* As hidden option `renderer` parameter can be set to `webgl` in `ol_options` (should not be used when displaying directly in RStudio)

# openlayers 0.4.0

* Fixed bug in select interaction
* Added more parameters to `icon_style`
* Added drag and drop functionality
  - `add_drag_and_drop`
* Changed default marker icon
* Added `make_icon` function to create marker icons from images, so that they can be used in `icon_style`
* Improved shiny integration by passing data back to R:
  - feature properties on select event
  - coordinates on map click event

# openlayers 0.3.0

* Added full screen control
  - `add_full_screen`
* Added `select_interaction` making features selectable
* Added `ol_options` to set map options like
  - `min_zoom`, `max_zoom`
  - `debug` mode
* Added function `add_vector_data` as a shorthand to `add_geojson` using `geojsonio` to parse any data to geojson

# openlayers 0.2.2

* Added missing function docs
* Added functions to add controls to the map
  - `add_scale_line`
  - `add_overview_map`
  - `add_mouse_control`
* Added examples to `inst/examples`

# openlayers 0.2.1

* Added appendix `_style` to all style functions
  - `style <- stroke_style(color = "blue") + fill_style(color = "yellow")`
* Added possibility to pass vectors of length equal to the number of features to some style functions
  - `style <- fill_style(color = c("green", "blue", "red"))`
* Added documentation to all style functions and some other functions
* Added opacity parameter to `add_geojson` function
* Added R tests for style functions

# openlayers 0.2.0

* Added new approach setting up styles:
  - `style <- stroke(color = "blue") + fill(color = "yellow")`
  - `style <- marker()`
* Added `invoke_method` function to store javascript method calls in `ol`-object
* Added support for multiple vector layers and tile layers

# openlayers 0.1.0

* Added a `NEWS.md` file to track changes to the package.
* Added functions to add vector layers from geojson
  - `sf` objects can be added via `geojsonio` package
* Added functions to style features
  - markers are added by applying an icon style to the features
