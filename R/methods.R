## TODO: obsolete, because stamen tiles can be added via 'add_stamen_tiles'
## only useful, because 'https' does not show up in RStudio
get_stamen_xyz_url <- function(layer = "toner"){
  sprintf("http://{a-c}.tile.stamen.com/%s/{z}/{x}/{y}.png", layer)
}

#' Get cartodb xyz url.
#'
#' for available layers please
#' check \href{https://carto.com/location-data-services/basemaps/}{cartodb-basemaps}
#'
#' @param layer cartodb layer name
#'
#' @return cartodb xyz url for given layer
#'
#' @export
#'
get_cartodb_xyz_url <- function(layer = "dark_all"){
  sprintf("https://cartodb-basemaps-{a-c}.global.ssl.fastly.net/%s/{z}/{x}/{y}.png", layer)
}

#' Cartodb attribution.
#'
#' @export
#'
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
#'
set_view <- function(ol, lon = 9.5, lat = 51.31667, zoom = 4){
  invoke_method(ol, "setView", lon, lat, zoom)
}

#' Add tile layers to map.
#'
#' @name add_tiles
#'
#' @param ol map widget
#'
NULL

#' @describeIn add_tiles Add osm tiles.
#'
#' @export
#'
add_osm_tiles <- function(ol){
  invoke_method(ol, "addOSMTiles")
}

#' @describeIn add_tiles Add stamen tiles.
#'
#' @param layer stamen layer name
#'
#' @export
#'
add_stamen_tiles <- function(ol, layer = "watercolor"){
  invoke_method(ol, "addStamenTiles", layer)
}

#' @describeIn add_tiles Add custom tiles.
#'
#' @param xyz_url xyz url
#' @param attribution attribution (character vector)
#' @param opacity layer opacity
#'
#' @export
#'
## "https://cartodb-basemaps-{a-c}.global.ssl.fastly.net/dark_all/{z}/{x}/{y}.png"
add_xyz_tiles <- function(ol, xyz_url = get_cartodb_xyz_url(), attribution = cartodb_attribution(), opacity = 1){
  invoke_method(ol, "addXYZTiles", xyz_url, attribution, opacity)
}

## TODO: obsolete ? remove!
add_earthquakes <- function(ol){
  ol$x$earthquakes_url <- "https://earthquake.usgs.gov/earthquakes/feed/v1.0/summary/1.0_week.geojson"
  ol
}

# TODO: useful ? export : remove
add_geojson_ds <- function(ol, url){
  invoke_method(ol, "addGeojsonFromUrl", url)
}

#' Add vector layer to map.
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
#'
add_geojson <- function(ol, data = NULL, filename = NULL, style = NULL, opacity = 1){
  if(!is.null(filename)){
    data <- readr::read_file(filename)
  }
  invoke_method(ol, "addGeojson", data, style, opacity)
}

## Controls ##

#' Add controls to map
#'
#' @name controls
#'
#' @param ol map widget
#' @param units units, supported values are
#'   \code{degrees}, \code{imperial}, \code{nautical}, \code{metric} and \code{us}
#'
#' @examples \dontrun{
#'   ol() %>% add_scale_line()
#' }
#'
#' @export
#'
add_scale_line <- function(ol, units = "metric"){
  ol$x$scale_line = list(units = units)
  ol
}

#' @name controls
#'
#' @param projection projection used to display coordinates
#'
#' @examples \dontrun{
#'   ol() %>% add_osm_tiles() %>% add_mouse_position("EPSG:3857")
#' }
#'
#' @export
#'
add_mouse_position <- function(ol, projection = "EPSG:4326"){
  ol$x$mouse_position = list(projection = projection)
  ol
}

#' @name controls
#'
#' @param collapsed start the overview map collapsed?
#'
#' @export
#'
add_overview_map <- function(ol, collapsed = TRUE){
  ol$x$overview_map = list(collapsed = collapsed)
  ol
}
