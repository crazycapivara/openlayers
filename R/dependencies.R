layerswitcher_dependencies <- function() {
  list(
    htmltools::htmlDependency(
      "ol-layerswitcher",
      version = "1.1.2",
      src = system.file("htmlwidgets/plugins/ol-layerswitcher", package = "openlayers"),
      script = c("ol3-layerswitcher.js", "ol-layerswitcher-bindings.js"),
      stylesheet = "ol3-layerswitcher.css"
    )
  )
}

#' @export
add_layer_switcher <- function(ol) {
  ol$dependencies <- c(
    ol$dependencies,
    layerswitcher_dependencies()
  )
  invoke_method(ol, "addLayerSwitcher")
}
