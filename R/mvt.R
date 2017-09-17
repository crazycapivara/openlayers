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
#'   # mapbox
#'   key <- "your_access_token"
#'   url <- paste0(
#'     "https://{a-d}.tiles.mapbox.com/v4/",
#'     "mapbox.mapbox-streets-v7/",
#'     "{z}/{x}/{y}.vector.pbf",
#'     "?access_token=", key
#'   )
#'   attribution <- "Add mapbox attribution here"
#'
#'   ol() %>%
#'     add_mapbox_vector_tiles(url, attribution)
#'
#'   # style the tiles
#'   ol() %>%
#'     add_mapbox_vector_tiles(
#'       url,
#'       attribution,
#'       style = stroke_style(color = "green") + fill_style()
#'     ) %>%
#'     set_view(zoom = 14)
#' }
#'
#' @export
add_mapbox_vector_tiles <- function(ol, url, attribution = NULL, style = NULL, options = layer_options()) {
  invoke_method(ol, "addVectorTiles", url, attribution, style, options, "MVT")
}

#' Mapbox attribution
#'
#' @export
mapbox_attribution <- function() {
  c("&copy; <a href='https://www.mapbox.com/about/maps/'>Mapbox</a>, ",
    "&copy; <a href='http://www.openstreetmap.org/copyright'>OpenStreetMap</a>")
}
