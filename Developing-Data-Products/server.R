library(shiny)

# Rely on the 'iris' dataset in the datasets
# package (which generally comes preloaded).
library(datasets)

# Define a server for the Shiny app
shinyServer(function(input, output) {
    
    # Create a simple plot
    output$plot <- renderPlot({
        plot(iris[, input$ycol] ~ iris[, input$xcol],
             col=iris$Species,
             main="Iris characteristica",
             xlab=input$xcol, ylab=input$ycol)
        legend("topright", legend=unique(iris$Species), pch=1,
               col=c('black', 'red', 'green'))
        
    })
})