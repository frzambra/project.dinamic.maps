library(shiny)
load("data/data_app2.RData")

shinyUI(
  fluidPage(
    tags$head(
      tags$link(rel = "stylesheet", type = "text/css", href = "http://bootswatch.com/cosmo/bootstrap.min.css"),
      tags$link(rel = "stylesheet", type = "text/css", href = "custom.css")
    ),
    br(),
    fluidRow(
      column(width = 3, id = "side_menu",
             h4("Analisis"),
             hr(),
             p("Escoge una region, indicador y fechas a comparar:"),
             selectizeInput("region_input", NULL, regiones_select),
             selectizeInput("indicator_input", NULL, indicator_select),
             selectizeInput("dates_input", NULL, dates_select, selected = sort(sample(dates_select, 4)), multiple = TRUE, options = list(maxItems = 4)),
             hr(),
             p(" ")
      ),
      column(width = 9,
             tabsetPanel(id = 'panel',
                         tabPanel('Plot', br(), textOutput("text_1"),
                                  fluidRow(
                                    column(width = 3, plotOutput("plot_1")),
                                    column(width = 3, plotOutput("plot_2")),
                                    column(width = 3, plotOutput("plot_3")),
                                    column(width = 3, plotOutput("plot_4"))
                                    )),
                         tabPanel('Table', br(), dataTableOutput("table_sequia"))
             )
      )
    )
  )
)