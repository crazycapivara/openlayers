#' @export
add_select <- function(ol, condition = "singleClick") {
  invoke_method(ol, "addSelect", condition)
}
