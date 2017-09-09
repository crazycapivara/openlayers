#' Add wms image layer
#'
#' @param ol map widget
#' @param wms_url url of the wms service
#' @param layers layers
#'
#' @examples \dontrun {
#'   wms_url <- "https://ahocevar.com/geoserver/wms"
#'
#'   ol() %>%
#'     add_stamen_tile() %>%
#'     add_wms(wms_url, layers = "topp:states")
#' }
#'
#' @export
add_wms <- function(ol, wms_url, layers) {
  invoke_method(ol, "addWMS", wms_url, list(LAYERS = layers))
}
