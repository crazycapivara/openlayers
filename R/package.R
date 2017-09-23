#' openlayers
#'
#' Makes the open-source JavaScript library \href{https://openlayers.org/}{OpenLayers}
#' available within R via the \pkg{htmlwidgets} package.
#'
#' @docType package
#' @name openlayers
#'
#' @examples \dontrun{
#'   ol() %>% add_osm_tiles()
#'
#'   ol() %>% add_stamen_tiles() %>%
#'     add_features(geojsonio::us_cities[1:5, ])
#' }
#'
#' @importFrom magrittr %>%
#' @export %>%
NULL

#' Pipe operator
#'
#' imported from \pkg{magrittr}
#'
#' @name pipe
#' @aliases %>%
NULL
