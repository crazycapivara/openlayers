#' @export
#'
js_style_function <- function(filename) {
  readr::read_file(filename) %>%
    htmlwidgets::JS()
}

## OBSOLETE!
. <- function(...) list(...)

# NEW style approach
# usage: style <- stroke_style() + fill_style()

set_style_class <- function(x){
  structure(x, class = c("list", "style"))
}

style_ <- function(...) {
  list(...) %>% set_style_class()
}

## TODO: decide whether to use %+% or + via style class
##
`%+%` <- function(lhs, rhs) {
  c(lhs, rhs)
}

#' @export
#'
`+.style` <- function(lhs, rhs) {
  c(lhs, rhs) %>% set_style_class()
}

#' @rdname style_methods
#'
#' @param width stroke width in pixels
#'
#' @export
#'
stroke_style <- function(color = "green", width = 2){
  style_(stroke = list(
    color = color,
    width = width
  ))
}

#' @rdname style_methods
#'
#' @export
#'
fill_style <- function(color = "rgba(0, 0, 255, 0.5)"){
  style_(fill = list(
    color = color
  ))
}

#' @rdname style_methods
#'
#' @param radius radius in pixels
#' @param stroke stroke style or \code{NULL} (do not stroke)
#' @param fill fill style or \code{NULL} (do not fill)
#'
#' @export
#'
circle_style <- function(stroke = stroke_style(), fill = fill_style(), radius = 10){
  style_(circle = c(
    stroke,
    fill,
    list(radius = radius)
  ))
}

#' @rdname style_methods
#'
#' @param src icon url or \code{NULL} (use default icon)
#'
#' @export
#'
## https://github.com/openstreetmap/map-icons/
marker_style <- function(src = NULL){
  if(is.null(src)){
    src <- system.file("icons/marker_icon", package = getPackageName()) %>%
      readr::read_file()
  }
  style_(marker = list(
    src = src
  ))
}

#' @rdname style_methods
#'
#' @export
#'
icon_style <- marker_style

#' @rdname style_methods
#'
#' @param text text content, ignored in case \code{property} parameter is set
#' @param property feature property used as text content
#' @param scale text scale
#'
#' @export
#'
text_style <- function(text = NULL, property = NULL, scale = 1.5){
  style_(text = list(
    text = text,
    property = property,
    scale = scale
  ))
}

style_array <- function(style, resolution, default_style = NULL){
  stop("needs to be implemented, just do it")
}

## TODO: OBSOLETE ? remove func or add docs and export it
style_that <- function(stroke_color = "blue", stroke_width = 1.5, fill_color = NULL, radius = 10){
  stroke <- stroke_style(stroke_color, stroke_width)
  if(!is.null(fill_color)){
    fill <- fill_style(fill_color)
  } else{
    fill = NULL
  }
  circle <- circle_style(stroke, fill, radius)
  stroke + fill + circle
}
