#----------------------------------------------------------
#
#   Script:  ui.R
#
#----------------------------------------------------------

library(shiny)
library(datasets)

# Get list of mtars variables
data(mtcars)
var.list <- names(mtcars)

shinyUI(fluidPage(
    titlePanel("MPG of Automatic Transmission Cars"),
    
    sidebarLayout(
        sidebarPanel(
            p("Select the desired Y and X axis variable to determine correlations."),
            selectInput("var.y","Select Y Axis:",var.list),
            selectInput("var.x", "select X Axis:",var.list)
        ),
        mainPanel(
            h3(textOutput("caption")),
            p("Do cars with automatic transmission get better gas mileage?  This application can interactively compare the correlation between various charateristics of cars with automatic transmissions."),
            plotOutput("dfPlot"))
    )
))