#' Read JavaScript function from a file
#'
#' @param filename filename
#'
#' @export
read_js_function <- function(filename) {
  readr::read_file(filename) %>%
    htmlwidgets::JS()
}

## NEW style approach
## usage: style <- stroke_style() + fill_style()

set_style_class <- function(x){
  structure(x, class = c("list", "style"))
}

style_ <- function(...) {
  list(...) %>% set_style_class()
}

#' @export
`+.style` <- function(lhs, rhs) {
  c(lhs, rhs) %>% set_style_class()
}

#' @rdname style_methods
#'
#' @param width stroke width in pixels
#'
#' @export
stroke_style <- function(color = "green", width = 2){
  style_(stroke = list(
    color = color,
    width = width
  ))
}

#' @rdname style_methods
#'
#' @export
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
circle_style <- function(stroke = stroke_style(), fill = fill_style(), radius = 10){
  style_(circle = c(
    stroke,
    fill,
    list(radius = radius)
  ))
}

#' @rdname style_methods
#'
#' @param src url of the icon, base64 encoded icon (see \code{\link{make_icon}})
#'   or \code{NULL} (use default icon)
#' @param anchor center of the icon relative to its top left corner
#' @param icon_color color to tint the icon or \code{NULL} (keep original)
#'
#' @export
## https://github.com/openstreetmap/map-icons/
marker_style <- function(src = NULL, anchor = c(0.5, 0.8), icon_color = NULL){
  if(is.null(src)){
    src <- system.file("icons/gps.png", package = utils::packageName()) %>%
      make_icon()
  }
  style_(marker = list(
    src = src,
    anchor = anchor,
    color = icon_color
  ))
}

#' @rdname style_methods
#'
#' @export
icon_style <- marker_style

#' @rdname style_methods
#'
#' @param text text content, ignored in case \code{property} parameter is set
#' @param property feature property used as text content
#' @param scale text scale
#' @param offset_xy horizontal and vertical text offset in pixel,
#'   positive offsets will shift the text right and down
#'
#' @export
text_style <- function(text = NULL, property = NULL, scale = 1.5,
                       color = "black", stroke = NULL, offset_xy = c(0, 0)){
  style_(text = c(
      list(
        text = text,
        property = property,
        scale = scale,
        offsetX = offset_xy[1],
        offsetY = offset_xy[2]
      ),
      fill_style(color = color),
      stroke
  ))
}

style_array <- function(style, resolution, default_style = NULL){
  stop("needs to be implemented, just do it")
}

## TODO: obsolete ? remove func : add docs and export it
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
