library(shiny)
library(ggplot2)
library(maptools)
library(rgeos)
library(lubridate)
library(scales)
load("data/data_app2.RData")

# test input
# input <- list(region_input = 4, date_input_1 = "2008-04-05", date_input_2 = "2013-06-05")
shinyServer(function(input, output) {
  
  output$text_1 <- renderText({ 
    paste("Comparando", input$date_input_1, "con", input$date_input_2)
  })
  
  output$plot_1 <- renderPlot({
    
    shp <- readShapePoly(file.path('shp', paste0("r", input$region_input, ".shp")))
    col <- paste0("V", which.min(abs(ymd(dates_select) - ymd(input$date_input_1)))[1])
    
    data2map <- data.frame(cod=data$cod, value=cut(data[,col],seq(0,100,10),include.lowest=TRUE))
    p <- mapCom(shp,data=data2map, fill='value', shp.u='COD_COMUNA', data.u='cod', fill.values=color_palette)
    print(p)
    
  })
  
  output$plot_2 <- renderPlot({
    
    shp <- readShapePoly(file.path('shp', paste0("r", input$region_input, ".shp")))
    col <- paste0("V", which.min(abs(ymd(dates_select) - ymd(input$date_input_2)))[1])
    
    data2map <- data.frame(cod=data$cod, value=cut(data[,col],seq(0,100,10),include.lowest=TRUE))
    p <- mapCom(shp,data=data2map, fill='value', shp.u='COD_COMUNA', data.u='cod', fill.values=color_palette)
    print(p)
    
  })
  
  output$table_sequia <- renderDataTable({
    
    col1 <- paste0("V", which.min(abs(ymd(dates_select) - ymd(input$date_input_1)))[1])
    col2 <- paste0("V", which.min(abs(ymd(dates_select) - ymd(input$date_input_2)))[1])
    d <- subset(data, subset = region == input$region_input, select =  c("Comuna", col1, col2))
    names(d)[2] <- paste("", dates_select[which.min(abs(ymd(dates_select) - ymd(input$date_input_1)))[1]])
    names(d)[3] <- paste("", dates_select[which.min(abs(ymd(dates_select) - ymd(input$date_input_2)))[1]])
    d$Variacion <- percent((d[,3]-d[,2])/d[,2])
    d
  }, options = list(aLengthMenu = c(5, 10, 20), iDisplayLength = 5))  

})