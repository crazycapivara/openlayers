#' Add select interaction to the map
#'
#' Globally add select interaction to the map,
#' which means all layers are selectable.
#'
#' @param ol map widget
#' @param options \code{\link{select_interaction}} object
#'
#' @seealso \code{select} parameter in \code{\link{add_geojson}}
#'
#' @export
add_select <- function(ol, options = select_interaction()) {
  invoke_method(ol, "addSelect", options)
}

#' Select interaction (object)
#'
#' @param condition event condition like \code{singleClick}, \code{pointerMove}, ...
#' @param property feature property, ...
#'
#' @export
select_interaction <- function(condition = "singleClick", property = NULL) {
  list(condition = condition, property = property)
}
