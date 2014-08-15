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
    
    data2map<-data.frame(cod=data$cod,value=cut(data[,col],seq(0,100,10),include.lowest=TRUE))
    
    #Define colores para las clases
    values<-c("[0,10]"="#8B0000","(10,20]"="#A43800","(20,30]"="#BE7100","(30,40]"="#D8AA00",
              "(40,50]"="#F2E200","(50,60]"="#E2ED00","(60,70]"="#AACB00","(70,80]"="#71A800",
              "(80,90]"="#388600","(90,100]"="#006400")
    
    p<-mapCom(shp,data=data2map,fill='value',shp.u='COD_COMUNA',data.u='cod',fill.values=values)
    #p <- mapCom(shp, data, fill=col, shp.u='COD_COMUNA', data.u='cod')
    print(p)
    
  })
  
  output$table_sequia <- renderDataTable({
    
    col <- paste0("V", which.min(abs(ymd(dates_select) - ymd(input$date_input)))[1])
    d <- subset(data, subset = region == input$region_input, select =  c("Comuna", col))
    names(d)[2] <- paste("Sequia", dates_select[which.min(abs(ymd(dates_select) - ymd(input$date_input)))[1]])
    d
  }, options = list(aLengthMenu = c(5, 10, 20), iDisplayLength = 5))  

})