#' Add wms tile layer to the map
#'
#' @param ol map widget
#' @param url url of the wms
#' @param layers layers
#' @param attribution attribution
#' @param wms_options named list of wms options like \code{STYLES}, ...
#' @param options layer options
#'
#' @examples \dontrun{
#'   wms_url <- "https://ahocevar.com/geoserver/wms"
#'   layers <- c("ne:NE1_HR_LC_SR_W_DR", "topp:states")
#'
#'   ol() %>%
#'     add_wms_tiles(wms_url, layers) %>%
#'     set_view(-99.74, 32.45, zoom = 3)
#'
#'   ol() %>%
#'     add_stamen_tiles() %>%
#'     add_wms_tiles("http://ows.terrestris.de/osm/service",
#'                   layers = "TOPO-WMS",
#'                   attribution = "Do not forget to insert the attribution!",
#'                   options = layer_options(opacity = 0.5))
#' }
#'
#' @export
add_wms_tiles <- function(ol, url, layers,
                          attribution = NULL,
                          wms_options = NULL,
                          options = layer_options()) {
  wms_options <- c(list(LAYERS = layers), wms_options)
  invoke_method(ol, "addWMSTiles", url, wms_options, attribution, options)
}

## wms image layer (for wms servers providing single images)
## not used at the moment
add_wms <- function(ol, wms_url, layers, attribution = NULL) {
  invoke_method(ol, "addWMS", wms_url, list(LAYERS = layers), attribution)
}
