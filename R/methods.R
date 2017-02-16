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
  ol$x$view <- list(lon = lon, lat = lat, zoom = zoom) %>%
    parse_to_json()
  ol
}

#' @export
#'
add_osm_tiles <- function(ol){
  ol$x$osm_tiles <- parse_to_json(TRUE)
  ol
}

#' @export
#'
add_xyz_tiles <- function(ol, xyz_url = get_stamen_xyz_url("terrain")){
  ol$x$xyz_url <- parse_to_json(xyz_url)
  ol
}
