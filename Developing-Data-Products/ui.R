library(shiny)

# Rely on the 'iris' dataset in the datasets
# package (which generally comes preloaded).
library(datasets)

shinyUI(pageWithSidebar(
    headerPanel('Hierachical clustering on the Iris data set'),
    sidebarPanel(
        selectInput('xcol', 'X Variable', names(iris)[1:4]),
        selectInput('ycol', 'Y Variable', names(iris)[1:4], selected=names(iris)[[2]]),
        tags$h3("Documentation"),
        tags$p("This is a simple application for exploring the iris-dataset, which is part of the datasets installed in R by default."),
        tags$p("Select input variables using the drop down menus and then observe the distribution of the flower types in the right-hand side plot, colored by species."),
        tags$p("The chosen input variables are used as a distance metric for hierarchical clustering. Check out the sizes of the resulting clusters and compare them to the correct (50, 50, 50) sizes."),
        tags$p("How close can you get to the correct clusters using only 2 input variables?"),
        "See code ",
        tags$a(href="https://github.com/npillmayer/datasciencecoursera/tree/master/Developing-Data-Products", "at github")
    ),
    mainPanel(
        plotOutput('plot'),
        "Cluster sizes using hierarchical clustering on these 2 variables: ", textOutput('table')
    )
))
