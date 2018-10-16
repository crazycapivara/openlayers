#' @export
add_legend <- function(ol, colors, labels, title = NULL, style = NULL) {
  # invoke_method(ol, "addLegend")
  invoke_method(ol, "addLegend", colors, labels, title, style)
}
