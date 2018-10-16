#' @export
add_legend <- function(ol, colors, labels, title = NULL, style = NULL, overlay = TRUE) {
  invoke_method(ol, "addLegend", colors, labels, title, style, overlay)
}
