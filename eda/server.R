# server
#server

library(plotly)
library(shiny)
library(ggplot2)
library("gdata") 
library(tidyverse)
library(maps)
library("rworldmap")
library("classInt")
library("plotly")

source("ui.R")
source("causes.R")
source("dalys.R")

ihme <- read.csv('IHME.csv', header = T)
water <- read.csv('water2.csv', header = T)
names(water)[names(water) == "Geographic.Area"] <- "location"

map_server <- function(input, output) {
  rundefault <- function(param) {
    water_data <- read.csv("water2.csv", stringsAsFactors = FALSE)
    water_data_map <- data.frame(water_data$Geographic.Area, water_data[[param]])
    if (param == "X2017_Proportion.of.population.using.unimproved.drinking.water.sources") {
      param <- "Proportion using Unimproved Sources of Drinking Water"
    }
    else if (param == "X2017_Proportion.of.population.using.improved.drinking.water.sources") {
      param <- "Proportion using Improved Sources of Drinking Water"
    }
    else if (param == "X2017_Proportion.of.population.with.a.handwashing.facility.with.soap.and.water.available.at.home"){
      param <-  "Proportion with a Handwashing Facility with Soap and Water at Home"
    }
    else if (param == "X2017_Proportion.of.population.using.safely.managed.drinking.water.services"){
      param <- "Proportion using Safely Managed Drinking Water Service"
    }
    else if (param == "X2017_Proportion.of.population.using.surface.water"){
      param <- "Proportion using surface water"
    }
    names(water_data_map)[1] <- "Country"
    names(water_data_map)[2] <- param
    water_data_map <- remove_missing(water_data_map)
    
    water_data_map_joined <- joinCountryData2Map(water_data_map
                                                 , joinCode = "NAME"
                                                 , nameJoinColumn = "Country")
    #getting class intervals using a ✬jenks✬ classification in classInt package
    classInt <- classInt::classIntervals( water_data_map_joined[[param]], n=5, style="jenks")
    catMethod = classInt[["brks"]]
    #getting a colour scheme from the RColorBrewer package
    colourPalette <- RColorBrewer::brewer.pal(5,'BuGn')
    output$MainPlot1 <- renderPlot({
      mapParams <- mapCountryData( water_data_map_joined
                                   , nameColumnToPlot=param
                                   , addLegend=FALSE
                                   , catMethod = catMethod
                                   , colourPalette = colourPalette )
      do.call( addMapLegend , c( mapParams
                                 , legendLabels="all"
                                 , legendWidth=0.5
                                 , legendIntervals="data" , legendMar = 2 ))
    })
  }
  
  rundefault("X2017_Proportion.of.population.using.safely.managed.drinking.water.services")
  observeEvent({input$param}, {
    if (input$param == 'Unimproved Sources of Drinking Water') {
      param <- "X2017_Proportion.of.population.using.unimproved.drinking.water.sources"
      rundefault(param)
    }
    else if (input$param == 'Improved Sources of Drinking Water') {
      param <- "X2017_Proportion.of.population.using.improved.drinking.water.sources"
      rundefault(param)
    }
    else if (input$param == 'Using Handwashing Facility at Home') {
      param <- "X2017_Proportion.of.population.with.a.handwashing.facility.with.soap.and.water.available.at.home"
      rundefault(param)
    }
    else if (input$param == 'Using Safely Managed Drinking Water Service'){
      param <- "X2017_Proportion.of.population.using.safely.managed.drinking.water.services"
      rundefault(param)
    }
    else if (input$param == 'Using Surface Water'){
      param <- "X2017_Proportion.of.population.using.surface.water"
      rundefault(param)
    }
  })
}

server <- function(input, output) {
  output$cause_hist <- renderPlot(common_causes)
  output$cause_prop <- renderPlotly(fig)
  map_server(input, output)
  output$diseasePlot <- renderPlot({
    # generate bins based on input$bins from ui.R
    z <- ihme %>% 
      filter(cause == input$cause & metric == "Rate")
    wd <- merge(z, water, by = "location")
    wd_dalys <- wd %>% 
      filter(measure == "DALYs (Disability-Adjusted Life Years)")
    # draw the histogram with the specified number of bins
    ggplot(wd_dalys, aes(x= val, y=X2017_Proportion.of.population.using.limited.drinking.water.services)) + 
      geom_point()+ labs(title = "Rate of Selected Cause vs. 
          Proportion of Population using limited drinking water",
                         x = "DALYs due to Cause", y = " Proportion of Population using 
        limited drinking water")+
      geom_smooth(method="loess", se=F)
  })
  
  output$dalys <- renderPlot({
    
    if(input$dalys_plot == 1){
      title <- paste0("Limited water sources vs. DALYs Percent")
      plot <- plot(limited_dalys)
    }
    
    if(input$dalys_plot == 2){
      title <- paste0("Unimproved water sources vs. DALYs Percent")
      plot <- plot(unimproved_dalys)
    }
    plot
  })
  
  
  }
