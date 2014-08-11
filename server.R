library(shiny)
library(ggplot2)
library(maptools)
library(rgeos)
library(lubridate)
load("data/data_app.RData")

# test input
# input <- list(region_input = 4, date_input = "2013-04-05")
# input <- list(region_input = 4, date_input = "2007-04-05")
shinyServer(function(input, output) {
  
  output$plot_sequia <- renderPlot({
    
    shp <- readShapePoly(file.path('shp', paste0("r", input$region_input, ".shp")))
    col <- paste0("V", which.min(abs(ymd(dates_select) - ymd(input$date_input)))[1])
    p <- mapCom(shp, data, fill=col, shp.u='COD_COMUNA', data.u='cod')
    print(p)
  
  })
  
  output$table_sequia <- renderDataTable({
    
    col <- paste0("V", which.min(abs(ymd(dates_select) - ymd(input$date_input)))[1])
    d <- subset(data, subset = region == input$region_input, select =  c("Comuna", col))
    names(d)[2] <- paste("Sequía", dates_select[which.min(abs(ymd(dates_select) - ymd(input$date_input)))[1]])
    d
  }, options = list(aLengthMenu = c(5, 10, 20), iDisplayLength = 5))  

})