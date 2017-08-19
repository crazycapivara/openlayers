#' @export
add_layer_switcher <- function(ol) {
  ol$dependencies <- c(
    ol$dependencies,
    layerswitcher_dependencies()
  )
  invoke_method(ol, "addLayerSwitcher")
}
