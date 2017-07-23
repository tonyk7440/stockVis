library(shiny)
library(dygraphs)
library(shinyWidgets)

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
            
            checkboxInput("returns", "Plot log returns", 
                          value = FALSE)
            ),
        mainPanel(
            radioGroupButtons(inputId = "duration", choices = c("1day","1w","1mon", "3mon")),
            dygraphOutput("dygraph")
        )
        #mainPanel(plotOutput("plot"))
    )
))