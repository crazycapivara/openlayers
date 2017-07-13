#' @export
#'
style_function <- function(filename) {
  readr::read_file(filename) %>%
    htmlwidgets::JS()
}


##' @export
##'
. <- function(...) list(...)

# NEW style approach
# usage: style <- stroke() + fill()

#' @export
#'
`+.style` <- function(lhs, rhs) {
  c(lhs, rhs)
}

#' @export
#'
stroke <- function(color = "green", width = 2){
  stroke_ <- list(stroke = list(
    color = color,
    width = width
  ))
  class(stroke_) <- c("list", "style")
  stroke_
}

#' @export
#'
fill <- function(color = "rgba(0, 0, 255, 0.5)"){
  fill_ = list(fill = list(
    color = color
  ))
  class(fill_) <- c("list", "style")
  fill_
}

# ---------------

#' @export
#'
## TODO: rename to style_that!? and add parameter fill = TRUE?
default_style <- function(){
  list(
    fill = FALSE,
    stroke = list(
      color = "blue",
      width = 5
    )
  )
}

#' @export
#'
marker <- function(){
  list(
    marker = TRUE
  )
}

#' @export
#'
set_fill <- function(style, color = "rgba(0, 0, 255, 0.5)"){
  style$fill = list(color = color)
  style
}

#' @export
#'
set_radius <- function(style, radius){
  style$radius = radius
  style
}

#' @export
#'
disable_stroke <- function(style){
  style$stroke = FALSE
  style
}
