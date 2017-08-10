#' @export
layer_options <- function(opacity = 1, ...) {
  x <- list(
    opacity = opacity
  )
  c(x, ...)
}
