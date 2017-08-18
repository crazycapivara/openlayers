#' Make icon
#'
#' Encode icon file to base64, so that it can be passed as \code{src} parameter
#' to \code{\link{marker_style}}.
#'
#' @param filename filename of icon
#'
#' @export
make_icon <- function(filename) {
  paste("data:image/png;base64,", base64enc::base64encode(filename))
}
