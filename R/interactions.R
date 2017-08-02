#' @export
add_select <- function(ol, condition = "singleClick") {
  invoke_method(ol, "addSelect", condition)
}

#' @export
select_interaction <- function(condition = "singleClick") {
  list(select = list(
    condition = condition
  ))
}
