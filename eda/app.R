# APP


# Load libraries so they are available
library("shiny")

# use source() to execute ui.r and server.r

source("ui.R")
source("server.R")

shinyApp(ui = ui, server = server)