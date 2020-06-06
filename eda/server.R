# server
#server


library(shiny)
library(ggplot2)
source("causes.R")

server <- function(input, output) {
  output$cause_hist <- renderPlot(common_causes)
  output$cause_prop <- renderPlotly(fig)
}