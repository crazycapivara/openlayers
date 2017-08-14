library(shiny)
library(geojsonio)

view <- fluidPage(
  h1("openleayers"),
  olOutput("map"),
  tableOutput("selected")
)

server <- function(input, output) {
  observeEvent(input$map_click, {
    print(input$map_click)
  })

  observeEvent(input$map_select, {
    print(input$map_select %>% as.data.frame())
  })

  df <- eventReactive(input$map_select, {
    input$map_select %>% as.data.frame()
  })

  output$map <- renderOl({
    ol(options = ol_options(debug = TRUE)) %>% add_stamen_tiles() %>%
      add_vector_data(us_cities[1:10, ], style = circle_style()) %>%
      add_select() %>% add_drag_and_drop()
  })

  output$selected <- renderTable({df()})
}

shinyApp(view, server)
