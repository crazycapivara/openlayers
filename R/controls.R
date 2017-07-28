## Controls ##

#' Add controls to map
#'
#' @name controls
#'
#' @param ol map widget
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

#' @name controls
#'
#' @param projection projection used to display coordinates
#'
#' @examples \dontrun{
#'   ol() %>% add_osm_tiles() %>% add_mouse_position("EPSG:3857")
#' }
#'
#' @export
#'
add_mouse_position <- function(ol, projection = "EPSG:4326"){
  ol$x$mouse_position = list(projection = projection)
  ol
}

#' @name controls
#'
#' @param collapsed start the overview map collapsed?
#'
#' @export
#'
add_overview_map <- function(ol, collapsed = TRUE){
  ol$x$overview_map = list(collapsed = collapsed)
  ol
}
