#' Add interactions to the map
#'
#' @param ol map widget
#'
#' @name interactions
NULL

#' @describeIn interactions Add select interaction to the map
#'
#' @param condition event condition like \code{singleClick}, \code{pointerMove}, ...
#' @param property feature property, ...
#'
#' @export
add_select <- function(ol, condition = "singleClick", property = NULL) {
  options <- list(condition = condition, property = property)
  invoke_method(ol, "addSelect", options)
}

#' @describeIn interactions Add drag and drop interaction to the map
#'
#' @export
add_drag_and_drop <- function(ol) {
  ol$x$enable_drag_and_drop <- TRUE
  ol
}
