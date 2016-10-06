# server.R

library(quantmod)
library(dygraphs)
source("helpers.R")

shinyServer(function(input, output) {
    
    output$dygraph <- renderDygraph({
        datafull<- getSymbols(input$symb, src = "yahoo", 
                              from = input$dates[1],
                              to = input$dates[2],
                              auto.assign = FALSE)
        data <- datafull[,6]
        
        dygraph(data, main = "Price Chart") %>%
            dyRangeSelector()
        
        # autoplot.zoo(data) + 
        #   theme_bw() +
        #   ggtitle("Price Chart") +
        #   labs(x = "Year") +
        #   scale_color_discrete(name = "Types") +
        #   scale_y_continuous(name="Price($/Share)")
        
        # chartSeries(data, theme = chartTheme("white"), 
        #             type = "line", log.scale = input$log, TA = NULL)
    })
    
})