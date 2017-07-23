# server.R
library(quantmod)
library(dygraphs)
library(xts)

shinyServer(function(input, output) {
    
    # Update data
    stock_data <- reactive({
        ticker <- input$symb
        
        data_all <- getSymbols(ticker, src = "yahoo",
                           from = input$dates[1],
                           to = input$dates[2],
                           auto.assign = FALSE)

    })

    
    display_data <- reactive({
        data <- stock_data()[,6]
        
        if(input$returns) {
            ret_data <- diff(log(data))
            
            if(input$duration == "1w") {
                data <- apply.weekly(ret_data, sum)
            }else if(input$duration == "1mon") {
                data <- apply.monthly(ret_data, sum)
            }else if(input$duration == "3mon") {
                data <- apply.quarterly(ret_data, sum)
            }else{
                data <- diff(log(ret_data))
            }
        }
        data <- data
        
    })
    
    output$dygraph <- renderDygraph({
        
        datafull<- display_data()
        
        dygraph(datafull, main = "Price Chart") %>%
            dyRangeSelector(dateWindow = c((today() - 365), today())) %>%
            dyOptions(maxNumberWidth = 20)
        
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