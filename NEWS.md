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
