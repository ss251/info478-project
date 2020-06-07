#ui 

library(shiny)
library(ggplot2)
library(plotly)
library("gdata") 
library(tidyverse)
library(maps)
library("rworldmap")
library("classInt")

Map_UI <- function() {
  return (tabPanel("Deterministic Model",
                   sidebarPanel(h3("Parameters of Clean Water", style = "padding-bottom: 0.5em"),
                                selectInput("param", "Parameter:", 
                                            choices=c('Unimproved Sources of Drinking Water',
                                                      'Improved Sources of Drinking Water',
                                                      'Using Handwashing Facility at Home',
                                                      'Using Safely Managed Drinking Water Service',
                                                      'Using Surface Water')),
                                hr(),
                                helpText(a("Data", href="https://data.unicef.org/topic/water-and-sanitation/drinking-water/", target="_blank"), "from UNICEF")
                   )
                   ,
                   
                   mainPanel(
                     plotOutput("MainPlot1")
                   )
  ))
}


navbarPage("Menu",
  # Intro Tab 
  tabPanel(
    "Introduction",
    fluidRow(
      column(
        10,
        mainPanel(
          h2("Introduction"),
          h4(""),
          wellPanel(
            style = "background: white",
            p("Access to clean water across the globe is still far from equitable. There are plenty of places which are still reliant on unclean sources of drinking water, and these places end up being subject to health burdens which impact them more than they do other countries in the world. In this study we hope to further study that the impact of lacking a clean source of water has on health.", br(),
              style = "font-size:18px")
          ),
        ))),
    fluidRow(
      column(
        10,
        mainPanel(
          h2("Purpose"),
          wellPanel(
            style = "background: white",
            p("By further studying this data, we hope to shine light on why a disparity in access to clean water matters, and how it specifically affects the groups of people who are subject to these types of conditions. In doing so we urge those in charge of public policy to find ways to enable for global access to clean drinking water, so that people around the globe have a higher standard for basic health.", br(),
              style = "font-size:18px")
          ),
        ))),
    
    fluidRow(
      column(
        10,
        mainPanel(
          h2("Method"),
          h4("For this project, we use the Clean Water Dataset and the Health Burden Dataset"),
          wellPanel(
            style = "background: white",

          p("The", a("dataset", href="https://data.unicef.org/topic/water-and-sanitation/drinking-water/", target="_blank"),
            "we will be using for measuring the quality of water
                        for each country was collected by WHO and UNICEF as part of their
                        Joint Monitoring Programme. This data set is global, and includes
                        information collected from almost every country. Collection of 
                        this dataset began in 1990. The Joint Monitoring Programme created
                        this dataset by working with governments to set up systems which can
                        gauge the water quality and sanitation levels of the country in
                        standardized ways."),
          p(
            "The", a("dataset", href="http://ghdx.healthdata.org/gbd-2017", target="_blank"), 
            "we will be using for measuring health burden was
                        collected by the Institute for Health Metrics and Evaluation.
                        This data set is global, and includes information collected from
                        195 countries in 2017. The GBD is composed of estimates for different
                        health burdens and outcomes for each country. These estimates are
                        based on a dataset that was created by aggregating over 9000 other
                        datasets regarding health, some of which were made publically available
                        through their country of origin."
          ),br(),style = "font-size:18px")
          ),
        ))
), 
  
# Analysis Tab  
  tabPanel(
    "Analysis",
    
    mainPanel(
      tabsetPanel(
        tabPanel("Location Analysis", 
                 mainPanel(h3("Parameters of Clean Water", style = "padding-bottom: 0.5em"),
                           selectInput("param", "Parameter:", 
                                       choices=c('Unimproved Sources of Drinking Water',
                                                 'Improved Sources of Drinking Water',
                                                 'Using Handwashing Facility at Home',
                                                 'Using Safely Managed Drinking Water Service',
                                                 'Using Surface Water')),
                           hr(),
                           helpText(a("Data", href="https://data.unicef.org/topic/water-and-sanitation/drinking-water/", target="_blank"), "from UNICEF")
                 ), 
                 mainPanel(
                   plotOutput("MainPlot1")
                 )
          
        ),
        
        
        tabPanel("DALYs vs Water quality", 
                 p("Select plot for relationship between proportion of using limited or unimproved drinking water sources 
            and DALYs percentage."),
                 br(),
                 radioButtons(
                   inputId = "dalys_plot",
                   label = "Pick a worse water sources to compare with DALYs percentage.",
                   choices = list(
                     "Limited water sources" = 1,
                     "Unimproved water sources" = 2),
                   selected = 1
                 ), 
                 p("These plots shows the relationship between proportion of water quality sources and DALYs percent.
                 Differences between limited and unimproved water source is that limited drinking water sources 
                 occur countries of water scarcity while demand for water is essential. On the other hand, unimproved drinking
                 water sources occur from lack of water supply such as unprotected dug well and srping, tanker truck, and unfiltered groundwater.
                From these relationships, we can determine how worse water quality can affect to individual's DALYs percentage.
                However, actual relationships do not have strong relationship between water quality and DALYs percentage.
                   First, limited water sources seem not to have strong relationship with DALYs percent which is 
                   quite different from what we expected. Unimproved water sources also seems not to have strong
                   relationship with DALYs percent. These lack of relationships might occur from including all disease causes that are not
                   affected by drinking water sources increasing DALYs percentage."),
                 br(),
                 plotOutput("dalys")
        ),
        
        tabPanel("Disease Distribution Analysis",
                 p("The plot below is a histogram of the most frequent diseases found in the bottom 10% of countries with the lowest access to clean drinking water. Countries were ranked based on the proportion of their population that is reliant on an unimproved water source. For each of the countries within the bottom 10%, the top 10 causes which contributed the most to their DALYs were selected and aggregated to create a count of significant causes of health burden among countries with low access to clean drinking water."),
                 plotOutput("cause_hist"),
                 p("From the histogram we learn that the most significant cause of health burden among regions without access to clean water are diseases relating to newborn children. Other frequent causes of health burden include STDs, malaria, and nutritional diseases. Identifying the frequent causes of health burden can help us understand how poor access to clean drinking water greatly affects the lives of children, and parents. This makes reproduction difficult for people in such countries, because they're risk of health burden is much higher.  Countries with such problems may have trouble in the future, if they're is difficult to keep young children healthy. It is important to assist such countries in acquiring better access to clean water so that their populations can more independently support themselves in the future."), 
                 plotlyOutput("cause_prop")),
      

        tabPanel("Disease Relationship Analysis", 
                 titlePanel("Relationship between most frequently occuring causes & water access measured by DALYS"),
                 sidebarLayout(
                   sidebarPanel(
                     selectInput("cause",
                                 "select a cause",
                                 c("Communicable, maternal, neonatal, and nutritional diseases",
                                   "Oral disorders", "Neonatal disorders", "Maternal and neonatal disorders",
                                   "Respiratory infections and tuberculosis", "Lower respiratory infections",
                                   "Enteric infections", "Neglected tropical diseases and malaria", "Injuries",
                                   "Malaria", "Diarrheal diseases", "Other non-communicable diseases",
                                   "HIV/AIDS and sexually transmitted infections", "HIV/AIDS"))
                   ),
                   mainPanel(
                     plotOutput("diseasePlot")
                   )
                 ))
      )
      )),
  
  tabPanel(
    "Conclusion",
    
    fluidRow(
      
    )
    
  )

)
  
