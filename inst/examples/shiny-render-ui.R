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
      add_features(
        us_cities[1:10, ],
        style = circle_style(),
        options = layer_options(name = "us_cities")) %>%
      add_select(display_properties = TRUE) %>%
      add_drag_and_drop() %>%
      add_layer_switcher()
  })

  output$ui <- renderUI({
    olOutput("map", height = "600px")
  })
}

shinyApp(view, server)
