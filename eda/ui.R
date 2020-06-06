#ui 

library(shiny)
library(ggplot2)

source("")

navbarPage("Menu",
  tabPanel(
    "Main",
    titlePanel(""),
    h3("", br(), br(), "")
    ),
  
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
            p("", br(),
              style = "font-size:18px")
          ),
        ))),
    fluidRow(
      column(
        10,
        mainPanel(
          h2("Purpose"),
          h4("Purpose of "),
          wellPanel(
            style = "background: white",
            p("Explaination goes here if needed", br(),
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
            ),br(),
              
              style = "font-size:18px")
          )
        )))
    ),
  
# Analysis Tab  
  tabPanel(
    "Analysis",
    
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
            tabPanel("Plot", plotOutput(""))
          ),
          wellPanel(
            style = "background: white",
            p("Explaination goes here if needed", br(),
              style = "font-size:18px")
          ),
        ),
      ))
    
    ),
  
  tabPanel(
    "Conclusion",
    
    fluidRow(
      
    )
    
  )

)
  
