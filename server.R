library(shiny)
library(ggplot2)
library(maptools)
library(rgeos)
library(lubridate)
library(scales)
load("data/data_app2.RData")

# test input
# input <- list(region_input = 4, dates_input = c("2008-04-05", "2013-06-05"), indicator_input = "sequia")
shinyServer(function(input, output) {
  
  data_reactive <- reactive({ get(paste0("data_", input$indicator_input)) })
  palette_reactive <- reactive({ if(input$indicator_input %in% c("sequia", "vci") ){ color_palette } else { color_palette2 } })
  cuts_reactive <- reactive({ if(input$indicator_input %in% c("sequia", "vci") ){ seq(0,100,10) } else { c(-10,seq(-2,by=0.5,length.out=9),10) } })
  shp_reactive <- reactive({ readShapePoly(file.path("shp", paste0("r", input$region_input, ".shp"))) }) 
  
  output$text_1 <- renderText({ 
    paste("Comparando", paste(input$dates_input, collapse = ", "))
  })
  
  output$plot_1 <- renderPlot({  
    data <- data_reactive()
    col <- paste0("V", which.min(abs(ymd(dates_select) - ymd(input$dates_input[1])))[1])
    data2map <- data.frame(cod=data$cod, value=cut(data[,col], cuts_reactive(), include.lowest=TRUE))
    p <- mapCom(shp_reactive(), data=data2map, fill='value', shp.u='COD_COMUNA', data.u='cod', fill.values=palette_reactive())
    print(p)
  })

  output$plot_2 <- renderPlot({
    data <- data_reactive()
    col <- paste0("V", which.min(abs(ymd(dates_select) - ymd(input$dates_input[2])))[1])
    data2map <- data.frame(cod=data$cod, value=cut(data[,col], cuts_reactive(), include.lowest=TRUE))
    p <- mapCom(shp_reactive(), data=data2map, fill='value', shp.u='COD_COMUNA', data.u='cod', fill.values=palette_reactive())
    print(p)
  })
  
  output$plot_3 <- renderPlot({
    data <- data_reactive()
    col <- paste0("V", which.min(abs(ymd(dates_select) - ymd(input$dates_input[3])))[1])
    data2map <- data.frame(cod=data$cod, value=cut(data[,col], cuts_reactive(), include.lowest=TRUE))
    p <- mapCom(shp_reactive(), data=data2map, fill='value', shp.u='COD_COMUNA', data.u='cod', fill.values=palette_reactive())
    print(p)
  })
  
  output$plot_4 <- renderPlot({
    data <- data_reactive()
    col <- paste0("V", which.min(abs(ymd(dates_select) - ymd(input$dates_input[4])))[1])
    data2map <- data.frame(cod=data$cod, value=cut(data[,col], cuts_reactive(), include.lowest=TRUE))
    p <- mapCom(shp_reactive(), data=data2map, fill='value', shp.u='COD_COMUNA', data.u='cod', fill.values=palette_reactive())
    print(p)
  })
  
  output$table_sequia <- renderDataTable({
    
    cols <- c()
    names <- c()
    for(date in input$dates_input){
      cols <- c(cols, paste0("V", which.min(abs(ymd(dates_select) - ymd(date)))[1]))
      names <- c(names,  paste0("", dates_select[which.min(abs(ymd(dates_select) - ymd(date)))[1]]))
    }
    
    d <- subset(data_reactive(), subset = region == input$region_input, select =  c("Comuna", cols))
    names(d) <- c("Comuna", names)
    d
  }, options = list(aLengthMenu = c(5, 10, 20), iDisplayLength = 5))  

})