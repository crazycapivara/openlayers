## TODO: obsolete, because stamen tiles can be added via 'add_stamen_tiles'
## only useful, because 'https' layers sometimes do not show up in RStudio
get_stamen_xyz_url <- function(layer = "toner"){
  sprintf("http://{a-c}.tile.stamen.com/%s/{z}/{x}/{y}.png", layer)
}

#' Get cartodb xyz url
#'
#' for available layers please
#' check \href{https://carto.com/location-data-services/basemaps/}{cartodb-basemaps}
#'
#' @param layer cartodb layer name
#'
#' @return cartodb xyz url for given layer
#'
#' @export
get_cartodb_xyz_url <- function(layer = "dark_all"){
  sprintf("https://cartodb-basemaps-{a-c}.global.ssl.fastly.net/%s/{z}/{x}/{y}.png", layer)
}

#' Cartodb attribution.
#'
#' @export
cartodb_attribution <- function(){
  c('&copy; <a href="http://www.openstreetmap.org/copyright">OpenStreetMap</a>, ',
    '&copy;<a href="https://carto.com/attribution">CARTO</a>')
}

#' Set the view of the map (geographical center and zoom).
#'
#' @param ol map widget
#' @param lon longitude of center
#' @param lat latitude of center
#' @param zoom zoom level
#'
#' @export
set_view <- function(ol, lon = 9.5, lat = 51.31667, zoom = 4){
  invoke_method(ol, "setView", lon, lat, zoom)
}

#' Add tile layers to map.
#'
#' @name add_tiles
#'
#' @param ol map widget
NULL

#' @describeIn add_tiles Add osm tile layer to map
#'
#' @export
add_osm_tiles <- function(ol){
  invoke_method(ol, "addOSMTiles")
}

#' @describeIn add_tiles Add stamen tile layer to map
#'
#' @param layer stamen layer name
#'
#' @export
add_stamen_tiles <- function(ol, layer = "watercolor"){
  invoke_method(ol, "addStamenTiles", layer)
}

#' @describeIn add_tiles Add custom tile layer to map
#'
#' @param xyz_url xyz url
#' @param attribution attribution (character vector)
#' @param opacity layer opacity
#'
#' @examples \dontrun{
#'   xyz_url <- get_cartodb_xyz_url()
#'   attribution <- cartodb_attribution()
#'   ol() %>% add_xyz_tiles(xyz_url, attribution)
#' }
#'
#' @export
add_xyz_tiles <- function(ol, xyz_url, attribution = NULL, opacity = 1){
  invoke_method(ol, "addXYZTiles", xyz_url, attribution, opacity)
}

# TODO: obsolete ? remove : export
add_earthquakes <- function(ol){
  ol$x$earthquakes_url <- "https://earthquake.usgs.gov/earthquakes/feed/v1.0/summary/1.0_week.geojson"
  ol
}

# TODO: useful ? export : remove
add_geojson_ds <- function(ol, url){
  invoke_method(ol, "addGeojsonFromUrl", url)
}

#' Add vector layer to map
#'
#' @param ol map widget
#' @param data geojson, ignored if \code{filename} is given
#' @param filename filename or url to read geojson from
#' @param style style object or \code{NULL} (use default style)
#' @param opacity layer opacity
#'
#' @examples \dontrun{
#'   geojson <- geojsonio::geojson_json(quakes[1:10, ])
#'   ol() %>% add_geojson(geojson)
#' }
#'
#' @export
add_geojson <- function(ol, data = NULL, filename = NULL, style = NULL, opacity = 1){
  if(!is.null(filename)){
    data <- readr::read_file(filename)
  }
  invoke_method(ol, "addGeojson", data, style, opacity)
}
