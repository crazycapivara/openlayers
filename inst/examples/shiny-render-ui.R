library(shiny)
library(geojsonio)
library(openlayers)

view <- fluidPage(
  h1("openlayers"),
  uiOutput("ui")
)

server <- function(input, output) {
  output$map <- renderOl({
    ol(options = ol_options(debug = TRUE)) %>%
      add_stamen_tiles() %>%
      add_features(us_cities[1:10, ], style = circle_style()) %>%
      add_select() %>%
      add_drag_and_drop()
  })

  output$ui <- renderUI({
    olOutput("map", height = "800px")
  })
}

shinyApp(view, server)
