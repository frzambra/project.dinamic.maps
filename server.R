library(shiny)
library(ggplot2)

shinyServer(function(input, output) {
  
  output$plot_sequia <- renderPlot({
    p <- ggplot(iris, aes(x= Sepal.Length, y=Sepal.Width)) + geom_point() + ggtitle(input$region_input)
    print(p)
  })
  
  output$table_sequia <- renderDataTable({
    iris
  }, options = list(aLengthMenu = c(5, 10, 20), iDisplayLength = 5))  

})