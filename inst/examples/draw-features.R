library(shiny)
library(miniUI)
library(openlayers)

# helper
parse_polygons <- function(x) {
  lapply(x, function(y) {
    coords <- jsonlite::fromJSON(y)
    sf::st_polygon(list(coords))
  }) %>% sf::st_sfc(crs = 3857) %>%
    sf::st_transform(4326)
}

# shiny gadget
draw_features <- function(draw_type = "Polygon", freehand = FALSE) {
  # View
  ui <- miniPage(
    gadgetTitleBar("Draw features"),
    miniContentPanel(
      olOutput("map", height = "100%")
    )
  )
  # Controller
  server <- function(input, output, session) {
    output$map <- renderOl({
      ol() %>%
        add_stamen_tiles() %>%
        add_draw(draw_type, freehand)
    })

    observeEvent(input$done, {
      features <- input$map_draw
      if (draw_type == "Polygon") features <- parse_polygons(features)

      stopApp(features)
    })
  }
  # Start gadget in browser mode
  runGadget(ui, server, viewer = browserViewer())
}
