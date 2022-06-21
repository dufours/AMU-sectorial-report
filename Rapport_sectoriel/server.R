#
# This is the server logic of a Shiny web application. You can run the
# application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
#
#    http://shiny.rstudio.com/
#

library(shiny)
library(htmltools)

# Define server logic required to draw a histogram
shinyServer(function(input, output) {

  selectedPlot <- reactive({
    paste0("Total AMU ",input$Indice,".html")
  })
  
  output$TotalPlot <- renderUI({
    tags$iframe(src= selectedPlot(),
                scrolling = "no", 
                seamless = "seamless",
                frameBorder = "0",
                width=1600,
                height=800
                )
  })

})
