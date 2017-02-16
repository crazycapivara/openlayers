#' <Add Title>
#'
#' <Add Description>
#'
#' @import htmlwidgets
#'
#' @export
ol <- function(message, width = NULL, height = NULL) {

  # forward options using x
  x = list(
    message = message
  )

  # create widget
  htmlwidgets::createWidget(
    name = 'ol',
    x,
    width = width,
    height = height,
    package = 'openlayers'
  )
}

#' Widget output function for use in Shiny
#'
#' @export
olOutput <- function(outputId, width = '100%', height = '400px'){
  shinyWidgetOutput(outputId, 'ol', width, height, package = 'openlayers')
}

#' Widget render function for use in Shiny
#'
#' @export
renderOl <- function(expr, env = parent.frame(), quoted = FALSE) {
  if (!quoted) { expr <- substitute(expr) } # force quoted
  shinyRenderWidget(expr, olOutput, env, quoted = TRUE)
}
