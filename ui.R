library(shiny)
library(dygraphs)

sp500_data <- read.csv("data/sp500_info_big.csv", stringsAsFactors = FALSE)
choices <- sp500_data$ticker

shinyUI(fluidPage(
    titlePanel("stockVis"),
    
    sidebarLayout(
        sidebarPanel(
            helpText("Select a stock to examine. 
                     Information will be collected from yahoo finance."),
            
            #textInput("symb", "Symbol", "SPY"),
            
            selectizeInput("symb", "Symbol", choices, selected = NULL),
            dateRangeInput("dates", 
                           "Date range",
                           start = "2013-01-01", 
                           end = as.character(Sys.Date())),
            
            br(),
            br(),
            
            checkboxInput("log", "Plot y axis on log scale", 
                          value = FALSE),
            
            checkboxInput("adjust", 
                          "Adjust prices for inflation", value = FALSE)
            ),
        mainPanel(
            dygraphOutput("dygraph")
        )
        #mainPanel(plotOutput("plot"))
    )
))