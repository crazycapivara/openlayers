#' @export
#'
js_style_function <- function(filename) {
  readr::read_file(filename) %>%
    htmlwidgets::JS()
}

##' @export
##'
. <- function(...) list(...)

# NEW style approach
# usage: style <- stroke_style() + fill_style()

set_style_class <- function(x){
  class(x) <- c("list", "style")
  x
}

style_ <- function(...) {
  list(...) %>% set_style_class()
}

## TODO: decide whether to use %+% or + via style class
#' @export
#'
`%+%` <- function(lhs, rhs) {
  c(lhs, rhs)
}

#' @export
#'
`+.style` <- function(lhs, rhs) {
  c(lhs, rhs) %>% set_style_class()
}

#' @export
#'
stroke_style <- function(color = "green", width = 2){
  style_(stroke = list(
    color = color,
    width = width
  ))
}

#' @export
#'
fill_style <- function(color = "rgba(0, 0, 255, 0.5)"){
  style_(fill = list(
    color = color
  ))
}

#' @export
#'
circle_style <- function(stroke = stroke_style(), fill = fill_style(), radius = 10){
  style_(circle = c(
    stroke,
    fill,
    list(radius = radius)
  ))
}

#' @export
#'
marker_style <- function(src = NULL){
  style_(marker = list(
    src = src
  ))
}

#' @export
#'
text_style <- function(text = NULL, property = NULL){
  style_(text = list(
    text = text,
    property = property
  ))
}

#' @export
#'
style_that <- function(stroke_color = "blue", stroke_width = 1.5, fill_color = NULL, radius = 10){
  stroke <- stroke_style(stroke_color, stroke_width)
  if(!is.null(fill_color)){
    fill <- fill_style(fill_color)
  } else{
    fill = NULL
  }
  circle <- circle_style(stroke, fill, radius)
  c(stroke, fill, circle)
}

# ---------------

##' @export
##'
## OBSOLETE: rename to style_that!? and add parameter fill = TRUE?
default_style <- function(){
  list(
    fill = FALSE,
    stroke = list(
      color = "blue",
      width = 5
    )
  )
}

##' @export
##'
## OBSOLETE
marker <- function(){
  list(
    marker = TRUE
  )
}

## OBSOLETE: all funcs below
##' @export
##'
set_fill <- function(style, color = "rgba(0, 0, 255, 0.5)"){
  style$fill = list(color = color)
  style
}

##' @export
##'
set_radius <- function(style, radius){
  style$radius = radius
  style
}

##' @export
##'
disable_stroke <- function(style){
  style$stroke = FALSE
  style
}
