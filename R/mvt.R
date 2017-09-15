## mapbox vector tiles format

#' Add mapbox vector tiles (mvt) to the map
#'
#' If you want to create and serve your own vector tiles
#' you may check \href{http://t-rex.tileserver.ch/}{t-rex}.
#'
#' @param ol map widget
#' @param url url of the mvt service
#' @param attribution attribution
#' @inheritParams add_geojson
#'
#' @examples \dontrun{
#'   url <- "http://tile.mapzen.com/mapzen/vector/v1/water/{z}/{x}/{y}.mvt?api_key=<api_key>"
#'   attribution <- "&copy; <a href='https://mapzen.com/'>Mapzen</a>"
#'
#'  ol() %>%
#'    add_mapbox_vector_tiles(url, attribution)
#' }
#'
#' @export
add_mapbox_vector_tiles <- function(ol, url, attribution = NULL, style = NULL) {
  invoke_method(ol, "addMVT", url, attribution, style)
}
