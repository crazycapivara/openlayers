#' Map options
#'
#' @param max_zoom_fit max zoom when fitting view to extend of data source
#' @param ... to be added soon
#'
#' @export
ol_options <- function(max_zoom_fit = 16, ...) {
  c(list(maxZoomFit = max_zoom_fit),
    list(...))
}

#' Vector layer options
#'
#' @param opacity opacity
#'
#' @export
vector_options <- function(opacity = 1) {
  list(opacity = opacity)
}
