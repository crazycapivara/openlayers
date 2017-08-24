#' Map options
#'
#' @param min_zoom minimal zoom of the map
#' @param max_zoom maximal zoom of the map or \code{NULL} (no limit)
#' @param max_zoom_fit maximal zoom when fitting the view to the extend of the data source
#' @param ... hidden options, e. g. pass \code{renderer = "webgl"} to use
#'   webgl as display engine (not recommend when viewing output directly in RStudio)
#'
#' @export
ol_options <- function(min_zoom = 0, max_zoom = NULL, max_zoom_fit = 16, ...) {
  x <- list(
    minZoom = min_zoom,
    maxZoom = max_zoom,
    maxZoomFit = max_zoom_fit
  )
  c(x, list(...))
}

## TODO: remove, use layer options instead
vector_options <- function(opacity = 1) {
  list(opacity = opacity)
}

#' Layer options
#'
#' @param opacity layer opacity
#' @param name layer name
#' @param ... hidden options, e. g. pass \code{type = "base"} to set base layers
#'   used by layer-switcher control
#'
#' @export
layer_options <- function(opacity = 1, name = NULL, ...) {
  list(opacity = opacity, name = name, ...)
}
