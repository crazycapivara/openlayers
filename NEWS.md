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
