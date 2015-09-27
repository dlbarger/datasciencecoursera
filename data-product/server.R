#---------------------------------------------------------------
#
#   Script:  server.R
#
#---------------------------------------------------------------
library(shiny)
library(datasets)
df <- mtcars[mtcars$am==0,]

# Define server to process scatter chart
shinyServer(function(input, output) {
    
    arg.text <- reactive({
        paste("df$",input$var.x, " ~ ", "df$",input$var.y)
    })
    
    caption.text <- reactive({
        paste("Comparison:  Y Axis (",input$var.y,") vs. X Axis (", input$var.x,")")
    })
    
    output$caption <- renderText({
        caption.text()
    })
    
    
    output$dfPlot <- renderPlot({plot(as.formula(arg.text()))})
})