#
# This is the user-interface definition of a Shiny web application. You can
# run the application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
# 
#    http://shiny.rstudio.com/
#

library(shiny)
library(leaflet)
library(dplyr)

# Read in the population data
popData <-read.csv("GP Practice Population Data.csv")

ccgList <- popData %>%
        distinct(CCG_NAME) %>%
        arrange(CCG_NAME)

shinyUI(fluidPage(theme = "gpPop.css",
        
  # Application title
  titlePanel("NHS General Practice Population Tool"),
  
  # Sidebar with a slider input for number of bins 
  sidebarLayout(
    sidebarPanel(
            helpText("Allow users to view populations of selected geographic locations"),
            
            tags$a(href="http://rpubs.com/dcheaton/GPPopTool", "Link to documentation"),
            
            tags$br(),
            
            selectInput("CCG",
                        label = "Choose CCG",
                        choices = ccgList,
                        selected = "NHS Darlington CCG")
       
    ),
    
    # Show a plot of the generated distribution
    mainPanel(
       leafletOutput("map"),
       
       DT::dataTableOutput("table")
    )
  )
))
