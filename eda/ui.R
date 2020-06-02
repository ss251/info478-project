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
          h2("Exploratory Analysis"),
          h4("Explain what analysis we have"),
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
  
