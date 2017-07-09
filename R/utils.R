invoke_method <- function(ol, method_name, ...){
  n <- length(ol$x$calls)
  ol$x$calls[[n+1]] <- list(
    method = method_name,
    args = list(...)
  )
  ol
}
