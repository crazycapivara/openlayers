#' Add wms tile layer
#'
#' @param ol map widget
#' @param url url of the wms service
#' @param layers layers
#' @param attribution attribution
#'
#' @examples \dontrun{
#'   wms_url <- "https://ahocevar.com/geoserver/wms"
#'   layers <- c("ne:NE1_HR_LC_SR_W_DR", "topp:states")
#'
#'   ol() %>%
#'     add_wms_tiles(wms_url, layers) %>%
#'     set_view(-99.74, 32.45, zoom = 3)
#' }
#'
#' @export
add_wms_tiles <- function(ol, url, layers, attribution = NULL) {
  invoke_method(ol, "addWMSTiles", url, list(LAYERS = layers), attribution)
}

## wms image layer (for wms servers providing single images)
## not used at the moment
add_wms <- function(ol, wms_url, layers, attribution = NULL) {
  invoke_method(ol, "addWMS", wms_url, list(LAYERS = layers), attribution)
}
