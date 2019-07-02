#' Add interactions to the map
#'
#' @param ol map widget
#'
#' @name interactions
NULL

#' @describeIn interactions Add select interaction to the map
#'
#' @param condition event condition like \code{singleClick}, \code{pointerMove}, ...
#' @param display_properties display feature properties on select?
#'
#' @export
add_select <- function(ol, condition = "singleClick", display_properties = FALSE) {
  options <- list(condition = condition, displayProperties = display_properties)
  invoke_method(ol, "addSelect", options)
}

#' @describeIn interactions Add drag and drop interaction to the map
#'
#' @export
add_drag_and_drop <- function(ol) {
  ol$x$enable_drag_and_drop <- TRUE
  ol
}

#' Add draw interaction to the map
#' @param ol map widget
#' @param type feature type; one of \code{Circle}, \code{Polygon}, \code{Point}, \code{LineString}
#' @param freehand logical; specifying whether or not freehand mode should be used
#' @export
add_draw <- function(ol, type = "Circle", freehand = FALSE) {
  ol$x$draw <- TRUE
  invoke_method(ol, "addDraw", type, freehand)
}
