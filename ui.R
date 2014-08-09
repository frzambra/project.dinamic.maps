library(shiny)


regiones <-  c("Arica y Parinatoca" = "14", "Tarapacá" = "1", "Antofagasta" = "2", "Atacama" = "3", "Coquimbo" = "4",
               "Valparaíso" = "5", "Metropolitana" = "13", "Libertador Bernardo O'Higgins" = "6", "Maule" = "7",
               "Bío-Bío" = "8", "Araucanía" = "9", "Los Ríos" = "15", "Los Lagos" = "10",
               "Aysén del General Ibañez del Campo" = "11", "Magallanes y Antártica Chilena" = "12")

shinyUI(
  fluidPage(
    tags$head(
      tags$link(rel = "stylesheet", type = "text/css", href = "http://bootswatch.com/cosmo/bootstrap.min.css"),
      tags$link(rel = "stylesheet", type = "text/css", href = "custom.css")
    ),
    h2("Análisis"),
    br(),
    fluidRow(
      column(width = 3, id = "side_menu",
             p("Escoge una región y un fecha:"),
             selectInput("region_input", NULL, regiones, width = "100%"),
             dateInput("date_input", NULL, value = "2012-02-29", format = "yyyy/mm/dd", language = "es"),
             hr(),
             p("Lorem ipsum dolor sit amet. Lorem ipsum dolor sit amet. Lorem ipsum dolor sit amet. ")
      ),
      column(width = 9,
             tabsetPanel(id = 'panel',
                         tabPanel('Plot', br(), plotOutput("plot_sequia")),
                         tabPanel('Table', br(), dataTableOutput("table_sequia"))
             )
      )
    )
  )
)