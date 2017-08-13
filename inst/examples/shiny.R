library(shiny)
library(geojsonio)

view <- fluidPage(
  h1("openleayers"),
  olOutput("map")
)

server <- function(input, output) {
  observeEvent(input$map_click, {
    print(input$map_click)
  })

  output$map <- renderOl({
    ol(options = ol_options(debug = TRUE)) %>% add_stamen_tiles() %>%
      add_vector_data(us_cities[1:10, ], style = circle_style())
  })
}

shinyApp(view, server)
