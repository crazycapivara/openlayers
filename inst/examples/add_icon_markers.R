library(openlayers)
library(geojsonio)

features <- us_cities[1:10, ]
colors = ifelse(features$capital, "red", "blue")

ol() %>% add_stamen_tiles() %>% add_stamen_tiles("terrain-labels") %>%
  add_vector_data(features,
                  style = marker_style(icon_color = colors),
                  popup = features$name) #%>% add_select(display_properties = TRUE)
