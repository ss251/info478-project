#ui 

library(shiny)
library(ggplot2)
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
        )),
    fluidRow(
      column(
        10, 
        mainPanel(h3("Parameters of Clean Water", style = "padding-bottom: 0.5em"),
                  selectInput("param", "Parameter:", 
                              choices=c('Unimproved Sources of Drinking Water',
                                        'Improved Sources of Drinking Water',
                                        'Using Handwashing Facility at Home',
                                        'Using Safely Managed Drinking Water Service',
                                        'Using Surface Water')),
                  hr(),
                  helpText(a("Data", href="https://data.unicef.org/topic/water-and-sanitation/drinking-water/", target="_blank"), "from UNICEF")
        )
      )
    ),
    fluidRow(
      column(
        10, 
        mainPanel(
          plotOutput("MainPlot1")
        )
      )
    )
), 
  
# Analysis Tab  
  tabPanel(
    "Analysis",
    
    mainPanel(
      tabsetPanel(
        tabPanel("Analysis1",
                 p("The plot below is a histogram of the most frequent diseases found in the bottom 10% of countries with the lowest access to clean drinking water. Countries were ranked based on the proportion of their population that is reliant on an unimproved water source. For each of the countries within the bottom 10%, the top 10 causes which contributed the most to their DALYs were selected and aggregated to create a count of significant causes of health burden among countries with low access to clean drinking water."),
                 plotOutput("cause_hist"),
                 p("From the histogram we learn that the most significant cause of health burden among regions without access to clean water are diseases relating to newborn children. Other frequent causes of health burden include STDs, malaria, and nutritional diseases. Identifying the frequent causes of health burden can help us understand how poor access to clean drinking water greatly affects the lives of children, and parents. This makes reproduction difficult for people in such countries, because they're risk of health burden is much higher.  Countries with such problems may have trouble in the future, if they're is difficult to keep young children healthy. It is important to assist such countries in acquiring better access to clean water so that their populations can more independently support themselves in the future."), 
                 plotlyOutput("cause_prop")),
        tabPanel("Analysis2", plotOutput("")),
        tabPanel("Analysis3", plotOutput("diseasePlot"), titlePanel("Relationship between most frequently occuring causes & water access measured by DALYS"),
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
  
