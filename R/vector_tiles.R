#' @export
add_topojson_vector_tiles <- function(ol, url, attribution = NULL, style = NULL, options = layer_options()) {
  invoke_method(ol, "addVectorTiles", url, attribution, style, options, "TopoJSON")
}
