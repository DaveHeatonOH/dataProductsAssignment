#
# This is the server logic of a Shiny web application. You can run the 
# application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
# 
#    http://shiny.rstudio.com/
#

library(shiny)
library(leaflet)

# Read in the population data
popData <-read.csv("GP Practice Population Data.csv")

# Define server logic required to draw a histogram
shinyServer(function(input, output) {
        
        
        # This changes the selected data as per each selection from drop down
        selectedOrgs <- reactive({
                subset(popData, CCG_NAME == input$CCG)
                
        })

        # Create the map based on selections
        output$map <- renderLeaflet({
          leaflet(selectedOrgs()) %>%
                  addTiles() %>%
                        addCircleMarkers(~longitude, ~latitude, 
                                 radius = ~NUMBER_OF_PATIENTS * 0.001,
                                 popup = ~paste("Practice Code:", CODE, "<br>",
                                        "Practice Name:", PRACTICE_NAME, "<br>",
                                        "Total Patients:", NUMBER_OF_PATIENTS))
                  
        })
        
        # Create a table to show the practice details
        output$table <- DT::renderDataTable({
                DT::datatable({
                selectedOrgs() %>%
                        select("Practice Code" = CODE, 
                                "Practice Name" = PRACTICE_NAME, 
                               "Patients" = NUMBER_OF_PATIENTS) %>%
                        arrange(desc(Patients))
                })
        })
  
  
})
