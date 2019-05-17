library(shiny)

view <- fluidPage(
  h1("openlayers"),
  olOutput("map")
)

server <- function(input, output) {
  observeEvent(input$map_draw, {
    print(lapply(input$map_draw, jsonlite::fromJSON))
  })

  output$map <- renderOl({
    ol(options = ol_options(debug = FALSE)) %>%
      add_stamen_tiles() %>%
      add_draw("Polygon")
  })
}

shinyApp(view, server)
