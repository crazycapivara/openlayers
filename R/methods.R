# TODO: obsolete ? REMOVE!
parse_to_json <- function(data){
  jsonlite::toJSON(data, auto_unbox = TRUE)
}

#' @export
#'
get_stamen_xyz_url <- function(type_ = "toner"){
  sprintf("http://tile.stamen.com/%s/{z}/{x}/{y}.png", type_)
}

#' @export
#'
set_view <- function(ol, lon = 9.5, lat = 51.31667, zoom = 4){
  invoke_method(ol, "setView", lon, lat, zoom)
}

#' @export
#'
add_osm_tiles <- function(ol){
  invoke_method(ol, "addOSMTiles")
}

#' @export
#'
add_stamen_tiles <- function(ol, layer = "watercolor"){
  invoke_method(ol, "addStamenTiles", layer)
}

#' @export
#'
add_xyz_tiles <- function(ol, xyz_url = get_stamen_xyz_url("terrain")){
  ol$x$xyz_url <- xyz_url
  ol
}

#' @export
#'
add_earthquakes <- function(ol){
  ol$x$earthquakes_url <- "https://earthquake.usgs.gov/earthquakes/feed/v1.0/summary/1.0_week.geojson"
  ol
}

#' @export
#'
add_geojson_ds <- function(ol, url, style = default_style()){
  ol$x$ds <- list(url = url, style = style)
  ol
}

#' @export
#'
add_geojson <- function(ol, geojson = NULL, filename = NULL, style = default_style()){
  if(is.null(geojson)){
    geojson <- readr::read_file(filename)
  }
  ol$x$geojson <- list(data = geojson, style = style)
  ol
}

#' @export
#'
add_geojson_ <- function(ol, data = NULL, filename = NULL, style = default_style()){
  if(is.null(data)){
    data <- readr::read_file(filename)
  }
  invoke_method(ol, "addGeojson", data, style)
}

#' @export
#'
add_scale_line <- function(ol, units = "metric"){
  ol$x$scale_line = list(units = units)
  ol
}
