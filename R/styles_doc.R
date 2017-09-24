#' Create styles
#'
#' Style methods to create style objects corresponding to
#' \href{http://openlayers.org/en/latest/apidoc/ol.style.html}{openlayers style classes}.
#'
#' @name style_methods
#'
#' @param color stroke or fill color
#'
#' @return style object
#'
#' @note
#'   \code{color}, \code{icon_color}, \code{radius} and \code{text} can be single values applied to all features
#'   or vectors of length equal to the number of features
#'
#' @examples
#'   style <- stroke_style() + fill_style()
#'
#'   point_style <- circle_style(stroke_style(color = "blue"), fill = NULL)
NULL
