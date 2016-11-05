# dependencies =================================================================
library(shiny)
library(dplyr)
library(ggplot2)
library(plotly)
source("data.R")


# shiny app=====================================================================

ui <- fluidPage(

    titlePanel(
        h1("Week 9 NFL Scoring Projections (November 6, 2016)")
        ),
    
    hr(),

    sidebarPanel(
        selectInput("pos", 
                    label = "Position:",
                    choices = list("QB", "RB",
                                   "WR", "TE"),
                    selected = "QB"),
        sliderInput("num", "Number of Players:",
                    min = 0, max = 40, value = 30
        ),
        width = 2
    ),
    
    # Show a plot of the generated distribution
    mainPanel(
        plotlyOutput("plot", width = "95%", height = "500px"),
        width = 10
    )
    
)

server <- function(input, output) {
    
    # renderPlotly() understands ggplot2 objects!
    output$plot <- renderPlotly({
        plot_projections(pos = input$pos, num = input$num)
    })
}

shinyApp(ui, server)


