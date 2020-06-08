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
            p("Access to clean water across the globe is still far from equitable. There are plenty of places which are still reliant on unclean sources of drinking water, and these places end up being subject to health burdens which impact them more than they do other countries in the world. In this study we hope to further understand the impact of lacking a clean source of water has on a population's health.", br(),
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
            p("By further studying this data, we hope to shine a light on why a disparity in access to clean water matters, and how it specifically affects the groups of people who are subject to these types of conditions. In doing so we urge those in charge of public policy to find ways to enable for global access to clean drinking water so that people around the globe have a higher standard for basic health.", br(),
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
                 h1("Question: Which causes of health burden affect countries with poor access to water the most, and how significant is their impact on DALYs?"),
                 h2("Most Prevalent Causes of Health Burden"),
                 p("The plot below is a histogram of the most frequent diseases found in the bottom 10% of countries with the lowest access to clean drinking water. Countries were ranked based on the proportion of their population that is reliant on an unimproved water source. For each of the countries within the bottom 10%, the top 10 causes which contributed the most to their DALYs were selected and aggregated to create a count of significant causes of health burden among countries with low access to clean drinking water."),
                 plotOutput("cause_hist"),
                 h3("Interpretation"),
                 p("From the histogram we learn that the most significant cause of health burden among regions without access to clean water are diseases relating to newborn children. Other frequent causes of health burden include STDs, malaria, and nutritional diseases. Identifying the frequent causes of health burden can help us understand how poor access to clean drinking water greatly affects the lives of children, and parents. This makes reproduction difficult for people in such countries, because they're risk of health burden is much higher.  Countries with such problems may have trouble in the future, if they're is difficult to keep young children healthy. It is important to assist such countries in acquiring better access to clean water so that their populations can more independently support themselves in the future."), 
                 h2("A Closer Look at the Causes of Health Burden"),
                 p("Looking into these 23 individual causes of health burden that heavily affect the 20 countries with the lowest access to clean water, we've identified a subset of these causes of health burden that are directly related to a lack of clean drinking water. Particularly by looking at the individual diseases, we learned that Arsenic which is often found in contaminated water sources can lead to health burdens such as diabetes, cardiovascular disease, and respiratory disorders. Additionally, a lack of clean drinking water can often lead to neonatal diseases, enteric infections, diarrheal diseases, and malaria."),
                 plotlyOutput("cause_prop"),
                 h3("Interpretation"), 
                 p("Plotting the percentage contribution that common water related causes of health burden have on these countries allows us to better understand the scale of the impact they have. For the bottom 20 countries with the worst access to clean water, they all have water related causes of health burden contributing for at least 30% of their DALYs. This shows the impact that lacking clean water can have on public health. Although we cannot assume that all of these DALYs could be avoided by introducing clean water, doing so would likely help alleviate the health burden by a significant amount. "),
                 p("A specific type of disease which causes disproportionate burden in countries with poor access to water are those related to birth. For most of these countries causes related to birth such as  communicable neonatal and nutritional disorders have a larger impact on their DALYs than most other water related causes. In many of these countries birth related issues end up accounting for nearly 20% of the countries total DALYS. This is concerning, because struggles revolving around raising children can impact the speed at which a country is able to grow. Without outside intervention it may be difficult for these countries to acquire access to clean water independently. ")
        ), 
      

        tabPanel("Disease Relationship Analysis", 
                 h1("Question: Which diseases are related to poor access to water, and how significant is their impact on DALYs?"),
                 titlePanel("Relationship Between the Most Frequently Occuring Causes & Water Access Measured by DALYS"),
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
                 ),p("These graphs allow the user to select a cause as an input and the graph will reflect that cause's relationship with DALYs.
                     The choices for inputs were determined by the top causes as measured by the number of countries with data on those causes."),
                    p("Some of the causes that follow a near linear trend are neonatal disorders, maternal disorders and diarrheal diseases. Additionally,
                     respiratory infections and tuberculosis show a strong linear trend which may be surprising as those are not normally
                     thought of as affected by water. This graph shows correlation not causation, however, which could account for that trend.
                     Malaria was another cause that might be expected to follow a strong linear trend but there was a shortage of data points, as it has been 
                     eradicated or near eradicated in many countries."), 
                    p("These graphs provide the starting point for further investigation into the health
                     burden that lack of access to drinking water creates. To establish causation, pre-existing studies can be looked into as many of these
                     causes have had extensive research done concerning them. In combination with the map visual, these can provide a good resource for starting to 
                     look at where to fund certain disease prevention measures, such as providing mothers of young children access to clean water as a priority.")
                 )
      )
      )),
  
  tabPanel(
    "Conclusion",
    
    fluidRow(h1("Conclusion"), wellPanel(
              p("Our goal with this data analysis was to determine the effects of water
               quality on health outcomes. Finding meaningful relationships between
               water quality and health outcomes would allow us to inform research and funding. 
               This yielded insights that could
               prove valuable when considering how important funding and improving water quality
               is in a region. Some of the relationships were somewhat expected, for example
               diarrheal diseases and malaria which spread through or require unclean water sources
               while some were less obvious."),
             p("For instance, water quality had a large impact on disease
               related to newborn children. Additionally, DALYs overall did not directly increase
               in the linear fashion we expected with limited access to water. Broken down by disease
               the relationships become more apparent but the noise when looking at all the causes at one
               time the data became too noisy to draw insights from."))
      
    )
    
  )

)
  
