#' Add wms image layer
#'
#' @param ol map widget
#' @param wms_url url of the wms service
#' @param layers layers
#'
#' @examples \dontrun{
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

#' Add wms tile layer
#'
#' @inheritParams add_wms
#'
#' @examples \dontrun{
#'   wms_url <- "https://ahocevar.com/geoserver/wms"
#'
#'   ol() %>%
#'     add_wms_tiles(wms_url, "ne:NE1_HR_LC_SR_W_DR")
#' }
#'
#' @export
add_wms_tiles <- function(ol, url, layers) {
  invoke_method(ol, "addWMSTiles", url, list(LAYERS = layers))
}
