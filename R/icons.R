#' @export
make_icon <- function(src) {
  paste("data:image/png;base64,", base64enc::base64encode(src))
}
