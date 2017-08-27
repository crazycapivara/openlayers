# openlayers 0.1.0

* Added a `NEWS.md` file to track changes to the package.
* Added functions to add vector layers from geojson
  - `sf` objects can be added via `geojsonio` package
* Added functions to style features
  - markers are added by applying an icon style to the features

# openlayers 0.2.0

* Added new approach setting up styles:
  - `style <- stroke(color = "blue") + fill(color = "yellow")`
  - `style <- marker()`
* Added `invoke_method` function to store javascript method calls in `ol`-object
* Added support for multiple vector layers and tile layers

# openlayers 0.2.1

* Added appendix `_style` to all style functions
  - `style <- stroke_style(color = "blue") + fill_style(color = "yellow")`
* Added possibility to pass vectors of length equal to the number of features to style functions
  - `style <- fill_style(color = c("green", "blue", "red"))`
* Added documentation to all style functions and some other functions
* Added opacity parameter to `add_geojson` function
* Added R tests for style functions

# openlayers 0.2.2

* Added missing function docs
* Added functions to add controls to map
  - `add_scale_line`
  - `add_overview_map`
  - `add_mouse_control`
* Added examples to `inst/examples`

# openlayers 0.3.0

* Added full screen control
  - `add_full_screen`
* Added `select_interaction` making features selectable
* Added `ol_options` to set map options like
  - `min_zoom`, `max_zoom`
  - `debug` mode
* Added function `add_vector_data` as a shorthand to `add_geojson` using `geojsonio`
to parse any data to geojson

# openlayers 0.4.0

* Fixed bug in select interaction
* Added more parameters to `icon_style`
* Added drag and drop functionality
  - `add_drag_and_drop`
* Changed default marker icon
* Added `make_icon` function to create marker icons from images, so that they
can be used in `marker_style`
* Improved shiny integration by passing data back to R:
  - feature properties on select event
  - coordinates on map click event

# openlayers 0.4.1

* Added `name` and `type` parameters to `layer_options` 
* Added ol-layerswitcher plugin
  - `add_layer_switcher`
  - to add layers to the menu just set the `name` parameter of the layer
  - set `type` parameter to `"base"` for base layers
  - layer dropped to the map get random names based on the names-generator from _docker_
* Added horizontal and vertical text offset (parameters) to `text_style`
* Added and updated examples
* As hidden option `renderer` parameter can be set to `webgl` in `ol_options`
(does not work fine when displaying directly in RStudio)

# openlayers 0.4.2

* Switched to `OpenLayers` v4.3.1

# openlayers 0.4.3

* Added popup support
