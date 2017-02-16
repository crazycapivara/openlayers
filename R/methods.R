parse_to_json <- function(data){
  jsonlite::toJSON(data, auto_unbox = TRUE)
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
add_xyz_tiles <- function(ol, xyz_url = "http://{1-4}.basemaps.cartocdn.com/light_all/{z}/{x}/{y}.png"){
  ol$x$xyz_url <- parse_to_json(xyz_url)
  ol
}
