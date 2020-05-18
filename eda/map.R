library("gdata") 
library(tidyverse)
library(maps)
library("rworldmap")
library("classInt")

water_data <- read.csv("water2.csv", stringsAsFactors = FALSE)

water_data_map <- data.frame(water_data$Geographic.Area, water_data$X2017_Proportion.of.population.using.unimproved.drinking.water.sources)

water_data_map <-water_data_map %>% 
  rename(
    Country = water_data.Geographic.Area,
    `Proportion Using Unimproved Sources of Drinking Water` = water_data.X2017_Proportion.of.population.using.unimproved.drinking.water.sources
  )

water_data_map <- remove_missing(water_data_map)

water_data_map_joined <- joinCountryData2Map(water_data_map
                                             , joinCode = "NAME"
                                             , nameJoinColumn = "Country")
#getting class intervals using a ✬jenks✬ classification in classInt package
classInt <- classInt::classIntervals( water_data_map_joined[["Proportion Using Unimproved Sources of Drinking Water"]], n=5, style="jenks")
catMethod = classInt[["brks"]]
#getting a colour scheme from the RColorBrewer package
colourPalette <- RColorBrewer::brewer.pal(5,'BuGn')
#calling mapCountryData with the parameters from classInt and RColorBrewer

mapParams <- mapCountryData( water_data_map_joined
                             , nameColumnToPlot="Proportion Using Unimproved Sources of Drinking Water"
                             , addLegend=FALSE
                             , catMethod = catMethod
                             , colourPalette = colourPalette )
do.call( addMapLegend , c( mapParams
                           , legendLabels="all"
                           , legendWidth=0.5
                           , legendIntervals="data" , legendMar = 2 ) )
