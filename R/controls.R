## Controls ##

#' Add controls to map
#'
#' @param ol map widget
#'
#' @name controls
NULL

#' @describeIn controls Add scaleline to map
#'
#' @param units units, supported values are
#'   \code{degrees}, \code{imperial}, \code{nautical}, \code{metric} and \code{us}
#'
#' @examples \dontrun{
#'   ol() %>% add_scale_line()
#' }
#'
#' @export
add_scale_line <- function(ol, units = "metric"){
  ol$x$scale_line = list(units = units)
  ol
}

#' @describeIn controls Add mouse position to map
#'
#' @param projection projection used to display coordinates
#'
#' @examples \dontrun{
#'   ol() %>% add_osm_tiles() %>% add_mouse_position("EPSG:3857")
#' }
#'
#' @export
add_mouse_position <- function(ol, projection = "EPSG:4326"){
  ol$x$mouse_position = list(projection = projection)
  ol
}

#' @describeIn controls Add overview map to map
#'
#' @param collapsed start the overview map collapsed?
#'
#' @export
add_overview_map <- function(ol, collapsed = TRUE){
  ol$x$overview_map <- list(collapsed = collapsed)
  ol
}

#' @describeIn controls Add full screen control to map
#'
#' @export
add_full_screen <- function(ol) {
  ol$x$full_screen <- TRUE
  ol
}
