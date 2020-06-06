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
          h4("For this project, we use "),
          wellPanel(
            style = "background: white",
            p("The data that we're most interested in is data about the percentage of a regions population that is using unimproved drinking water.

Analyzing the data collected from UNICEF we can see that the mean proportion of people using unimproved drinking water sources is rather low, at 4.85%. Although this value is low it's important to note that 25% of countries have between 5.85 % of their population and 38.72% of their population using unimproved water sources. This is likely because despite most of the world having very low usage of unimproved water sources, there still exist countries with very high usage of unimproved water sources. This becomes more obvious when we note that despite the median being 1.1% the mean percentage of people using unimproved water is 5.85%.

At further inspection we can see that the standard deviation of the proportion of populations using unimproved drinking water is 7.513%. This supports our analysis that there exist countries which use unimproved water at significantly higher rates than the other regions in the world.", br(),
              style = "font-size:18px")
          ),
        ))),
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
    ),
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
        tabPanel("Analysis3", plotOutput("")),
        tabPanel("Analysis4", plotOutput(""))
      ),
      fluidRow(
        column(
          10,
          mainPanel(
            h2("Specific Quantitative Analysis"),
            h4("Explain what questions we have"),
            tabsetPanel(
              tabPanel("Plot", plotOutput(""))
              ),
            wellPanel(
              style = "background: white",
              p("Explaination goes here if needed", br(),
                style = "font-size:18px")
              ),
            ),
          )),
      
      fluidRow(
        column(
          10,
          mainPanel(
            h2("Exploratory Analysis: Understanding DALYs rate and Water quality"),
            h4("DALYs rate versus Water quality over countries"),
            tabsetPanel(
              tabPanel("Plot", plotOutput(""))
            ),
            wellPanel(
              style = "background: white",
              p("DALYs is disability adjusted life year which is the sum of years of potential life 
              lost due to premature death and the years of productive life lost due to disability.
              The importance of DALYs is that it measure the combined quantity and quality of life of a population.
              The plots indicate top 8 DALYs rate countries of limited and unimproved water quality, and to compare
              limited and unimproved water quality of top 8 countries. All of top 8 countries of DALYs rate are from
                Africa where have lack of necessary monetary lead to utilize water sources.", br(),
              p("Differences between limited and unimproved water quality is unimproved water sources are
                mainly Unprotected spring, cart with small tank or drum, tanker truck-provided water, surface water. 
                On the other hand, limited drinking water is that water sources is limited to proportion of people
                demand for drinking water."), br(),
              p("From the plots above, Somalia has the highest risk of both limited and unimproved water quality. 
              The main reason that Somalia has the highest risk is that their groundwater is mainly from boreholes, 
                shallow wells and springs, and current facing water scarcity as a result of successive droughts."), br(),
                style = "font-size:18px")
            ),
          ),
        )),
      
      fluidRow(
        column(
          10,
          mainPanel(
            h2("Exploratory Analysis"),
            h4(""),
            tabsetPanel(
              tabPanel("Plot", plotOutput("")),
              tabPanel("Plot2", plotOutput(""))
            ),
            wellPanel(
              style = "background: white",
              p("Explaination goes here if needed", br(),
                style = "font-size:18px")
            ),
          ),
        ))
      
      )),
  
  tabPanel(
    "Conclusion",
    
    fluidRow(
      
    )
    
  )

)
  
