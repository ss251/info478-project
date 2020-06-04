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
          h4("For this project, we use "),
          wellPanel(
            style = "background: white",
            p("Explaination goes here if needed", br(),
              style = "font-size:18px")
          ),
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
  
