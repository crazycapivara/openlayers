invoke_method <- function(ol, method_name, ...) {
  n <- length(ol$x$calls)
  ol$x$calls[[n+1]] <- list(
    method = method_name,
    args = list(...)
  )
  ol
}

camel_case <- function(x) {
  gsub("_(\\w?)", "\\U\\1", x, perl = TRUE)
}
