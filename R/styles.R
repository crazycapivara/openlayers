#' @export
#'
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
