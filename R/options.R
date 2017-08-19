#' Map options
#'
#' @param min_zoom minimal zoom of map
#' @param max_zoom maximal zoom of map or \code{NULL} (no limit)
#' @param max_zoom_fit maximal zoom when fitting view to extend of data source
#' @param ... to be added soon
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

#' Vector layer options
#'
#' @param opacity opacity
#'
#' @export
vector_options <- function(opacity = 1) {
  list(opacity = opacity)
}

#' @export
layer_options <- function(name = NULL, ...) {
  list(name = name, ...)
}
