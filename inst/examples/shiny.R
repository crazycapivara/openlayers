library(shiny)
library(geojsonio)

view <- fluidPage(
  h1("openleayers"),
  olOutput("map")
)

server <- function(input, output) {
  output$map <- renderOl({
    ol() %>% add_stamen_tiles() %>%
      add_vector_data(us_cities[1:10, ], style = circle_style())
  })
}

shinyApp(view, server)
