#' @export
add_select <- function(ol, options = select_interaction()) {
  invoke_method(ol, "addSelect", options)
}

#' Select interaction
#'
#' @param condition event condition like \code{singleClick}, \code{pointerMove}, ...
#' @param property feature property, ...
#'
#' @export
select_interaction <- function(condition = "singleClick", property = NULL) {
  list(condition = condition, property = property)
}
