#' Guess format of vector tiles
#'
#' @param url url of the vt service
#'
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

#' Add vector tile layer to the map
#'
#' If you want to create and serve your own vector tiles
#' you may check \href{http://t-rex.tileserver.ch/}{t-rex}.
#'
#' @inheritParams add_geojson
#' @param url url of the vector tiles service
#' @param attribution attribution
#' @param format format of the vector tiles, \code{MVT} (mapbox vector tiles),
#'   \code{TopoJSON}, \code{GeoJSON} or \code{NULL} (guess format)
#' @examples \dontrun{
#'   # osrm
#'   osrm <- "http://router.project-osrm.org/tile/v1/car/tile({x},{y},{z}).mvt"
#'
#'   ol() %>%
#'     add_osm_tiles() %>%
#'     add_vector_tiles(osrm, "Add osrm attribution") %>%
#'     set_view(zoom = 16)
#'
#'   # mapzen
#'   key <- "your_api_key"
#'   mapzen <- paste0(
#'     "https://tile.mapzen.com/mapzen/vector/v1/",
#'     "roads/{z}/{x}/{y}.topojson",
#'     "?api_key=", key)
#'   )
#'
#'   ol() %>%
#'     add_vector_tiles(mapzen, "Add mapzen attribution") %>%
#'     set_view(zoom = 16)
#'
#'   # mapbox
#'   key <- "your_access_token"
#'   mapbox <- paste0(
#'     "https://{a-d}.tiles.mapbox.com/v4/",
#'     "mapbox.mapbox-streets-v7/",
#'     "{z}/{x}/{y}.vector.pbf",
#'     "?access_token=", key
#'   )
#'   attribution <- "Add mapbox attribution"
#'
#'   ol() %>%
#'     add_vector_tiles(mapbox, attribution)
#'
#'   # style the tiles
#'   ol() %>%
#'     add_vector_tiles(
#'       mapbox,
#'       attribution,
#'       style = stroke_style(color = "green") + fill_style()
#'     ) %>%
#'     set_view(zoom = 14)
#'
#'   # use javascript style function
#'   mapbox_style <- system.file("javascript/mvt_style_function.js", package = "openlayers") %>%
#'     read_js_function()
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
