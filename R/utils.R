invoke_method <- function(ol, method_name, arguments){
  n <- length(ol$x$calls)
  ol$x$calls[[n+1]] <- list(
    method = method_name,
    args = arguments
  )
  ol
}
