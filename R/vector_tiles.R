#' @export
guess_vt_format <- function(url) {
  if (grepl("\\.json", url)) {
    return("GeoJSON")
  }
  if (grepl("\\.topojson", url)) {
    return("TopoJSON")
  }
  "MVT"
}

#' Add vector tiles to the map
#'
#' If you want to create and serve your own vector tiles
#' you may check \href{http://t-rex.tileserver.ch/}{t-rex}.
#'
#' @name add_vector_tiles
#'
#' @examples \dontrun{
#'   # osrm
#'   osrm_url <- "http://router.project-osrm.org/tile/v1/car/tile({x},{y},{z}).mvt"
#'
#'   ol() %>%
#'     add_osm_tiles() %>%
#'     add_vector_tiles(osrm_url, "Add attribution") %>%
#'     set_view(zoom = 16)
#' }
#'
#' @export
add_vector_tiles <- function(ol, url, attribution = NULL, style = NULL,
                             options = layer_options(), format = NULL) {
  if (is.null(format)) {
    format <- guess_vt_format(url)
  }
  invoke_method(ol, "addVectorTiles", url, attribution, style, options, format)
}

#' @describeIn add_vector_tiles Add topojson vector tiles to the map
#'
#' @examples \dontrun{
#'   # mapzen
#'   key <- "api_key"
#'   url <- paste0(
#'     "https://tile.mapzen.com/mapzen/vector/v1/",
#'     "roads/{z}/{x}/{y}.topojson",
#'     "?api_key=", key)
#'   )
#'
#'   ol() %>%
#'     add_topojson_vector_tiles(url, "Add mapzen attribution") %>%
#'     set_view(zoom = 16)
#' }
#'
#' @export
add_topojson_vector_tiles <- function(ol, url, attribution = NULL, style = NULL, options = layer_options()) {
  invoke_method(ol, "addVectorTiles", url, attribution, style, options, "TopoJSON")
}

#' @describeIn add_vector_tiles Add geojson vector tiles to the map
#'
#' @export
add_geojson_vector_tiles <- function(ol, url, attribution = NULL, style = NULL, options = layer_options()) {
  invoke_method(ol, "addVectorTiles", url, attribution, style, options, "GeoJSON")
}
