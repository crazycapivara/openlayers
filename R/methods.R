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
  ol$x$view <- list(lon = lon, lat = lat, zoom = zoom) #%>%
    #parse_to_json()
  ol
}

#' @export
#'
add_osm_tiles <- function(ol){
  ol$x$osm_tiles <- TRUE
  ol
}

#' @export
#'
add_stamen_tiles <- function(ol, layer = "watercolor"){
  ol$x$stamen_tiles <- layer
  ol
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
add_geojson_dsn <- function(ol, dsn){
  ol$x$dsn <- dsn
  ol
}

#' @export
#'
add_geojson <- function(ol, geojson = NULL, filename = NULL, fill = "rgba(0, 0, 255, 0.5)"){
  if(is.null(geojson)){
    geojson <- readr::read_file(filename)
  }
  ol$x$geojson <- list(data = geojson, style = list(fill_color = fill))
  ol
}
