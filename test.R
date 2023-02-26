library(shiny)
library(leaflet)
library(plotly)

# Define UI
ui <- fluidPage(
  sidebarPanel(),
  leafletOutput("map"),
  plotlyOutput("pie")
)

# Define server
server <- function(input, output, session) {

  # Initialize a counter for the number of clicks in each hemisphere
  north_count <- 0
  south_count <- 0

  # Create a leaflet map
  output$map <- renderLeaflet({
    leaflet() %>%
      addTiles() %>%
      setView(lng = -95.7129, lat = 37.0902, zoom = 4)
  })

  # Add click event to the map
  observeEvent(input$map_click, {
    # Get the latitude of the clicked point
    lat <- input$map_click$lat

    # Increment the counter for the appropriate hemisphere
    if (lat >= 0) {
      north_count <- north_count + 1
    } else {
      south_count <- south_count + 1
    }

    # Display the latitude and longitude in the info box
    output$info <- renderPrint({
      paste("Latitude:", lat, "Hemisphere:", ifelse(lat >= 0, "North", "South"))
    })

    # Create a pie chart of the number of clicks in each hemisphere
    output$pie <- renderPlotly({
      plot_ly(
        labels = c("North", "South"),
        values = c(north_count, south_count),
        type = "pie"
      )
    })
  })
}

# Run app
shinyApp(ui, server)



library(shiny)
library(leaflet)
library(plotly)

# Define UI
ui <- fluidPage(
  sidebarPanel(),
  splitLayout(
    leafletOutput("map"),
    plotlyOutput("pie")
  )
)

# Define server
server <- function(input, output, session) {

  # Initialize a counter for the number of clicks in each hemisphere
  north_count <- 0
  south_count <- 0

  # Create a leaflet map
  output$map <- renderLeaflet({
    leaflet() %>%
      addTiles() %>%
      setView(lng = -95.7129, lat = 37.0902, zoom = 4)
  })

  # Add click event to the map
  observeEvent(input$map_click, {
    # Get the latitude of the clicked point
    lat <- input$map_click$lat

    # Increment the counter for the appropriate hemisphere
    if (lat >= 0) {
      north_count <- north_count + 1
    } else {
      south_count <- south_count + 1
    }

    # Display the latitude and longitude in the info box
    output$info <- renderPrint({
      paste("Latitude:", lat, "Hemisphere:", ifelse(lat >= 0, "North", "South"))
    })

    # Create a pie chart of the number of clicks in each hemisphere
    output$pie <- renderPlotly({
      plot_ly(
        labels = c("North", "South"),
        values = c(north_count, south_count),
        type = "pie"
      )
    })
  })
}

# Run app
shinyApp(ui, server)

