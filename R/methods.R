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
add_tiles <- function(ol){
  ol$x$tiles <- parse_to_json(TRUE)
  ol
}
