#' @export
ol_options <- function(max_zoom_fit = 16, ...) {
  c(list(maxZoomFit = max_zoom_fit), list(...))
}

#' Layer options
#'
#' @param opacity opacity
#'
#' @export
layer_options <- function(opacity = 1) {
  list(opacity = opacity)
}
