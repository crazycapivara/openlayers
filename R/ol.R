#' Create OpenLayers map widget
#'
#' @param width map width
#' @param height map height
#' @param elementId explicit element id (usually not needed)
#' @param options see \code{\link{op_options}}
#'
#' @import htmlwidgets
#'
#' @export
ol <- function(width = NULL, height = NULL, elementId = NULL, options = ol_options()) {

  # forward options using x
  x <- list(calls = list(), options = options)

  # create widget
  htmlwidgets::createWidget(
    'ol',
    structure(x),
    width = width,
    height = height,
    package = 'openlayers',
    elementId = elementId
  )
}

#' Shiny bindings for ol
#'
#' Output and render functions for using ol within Shiny
#' applications and interactive Rmd documents.
#'
#' @param outputId output variable to read from
#' @param width,height Must be a valid CSS unit (like \code{'100\%'},
#'   \code{'400px'}, \code{'auto'}) or a number, which will be coerced to a
#'   string and have \code{'px'} appended.
#' @param expr An expression that generates a ol
#' @param env The environment in which to evaluate \code{expr}.
#' @param quoted Is \code{expr} a quoted expression (with \code{quote()})? This
#'   is useful if you want to save an expression in a variable.
#'
#' @name ol-shiny
#'
#' @export
olOutput <- function(outputId, width = '100%', height = '400px') {
  htmlwidgets::shinyWidgetOutput(outputId, 'ol', width, height, package = 'openlayers')
}

#' @rdname ol-shiny
#'
#' @export
renderOl <- function(expr, env = parent.frame(), quoted = FALSE) {
  if (!quoted) { expr <- substitute(expr) } # force quoted
  htmlwidgets::shinyRenderWidget(expr, olOutput, env, quoted = TRUE)
}
