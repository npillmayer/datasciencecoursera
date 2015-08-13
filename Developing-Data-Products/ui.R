library(shiny)

# Rely on the 'iris' dataset in the datasets
# package (which generally comes preloaded).
library(datasets)

shinyUI(pageWithSidebar(
    headerPanel('Iris data set'),
    sidebarPanel(
        selectInput('xcol', 'X Variable', names(iris)[1:4]),
        selectInput('ycol', 'Y Variable', names(iris)[1:4], selected=names(iris)[[2]]),
        tags$h3("Documentation"),
        tags$p("This is a simple application for exploring the iris-dataset, which is part of the datasets installed in R by default."),
        tags$p("Select input variables using the drop down menus and then observe clustering of the flower types in the right-hand side plot.")
    ),
    mainPanel(
        plotOutput('plot')
    )
))
