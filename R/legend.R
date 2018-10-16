#' Add legend to the map
#'
#' @param ol map widget
#' @param colors vector of colors
#' @param labels vector of text labels corresponding to the colors
#' @param title title of the legend or \code{NULL} (no title)
#' @param style list of css style definition applied to the legend (container)
#' @param overlay display on top of the map or below?
#'
#' @export
add_legend <- function(ol, colors, labels, title = NULL, style = NULL, overlay = TRUE) {
  invoke_method(ol, "addLegend", colors, labels, title, style, overlay)
}
