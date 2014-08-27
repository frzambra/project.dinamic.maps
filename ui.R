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
             p("Escoge una region y fechas a comparar:"),
             selectInput("region_input", NULL, regiones_select, selectize = TRUE),
             dateInput("date_input_1", NULL, value = min(dates_select), format = "yyyy/mm/dd",
                       language = "es", min = min(dates_select), max = max(dates_select)),
             dateInput("date_input_2", NULL, value = max(dates_select), format = "yyyy/mm/dd",
                       language = "es", min = min(dates_select), max = max(dates_select)),
             hr(),
             p(" ")
      ),
      column(width = 9,
             tabsetPanel(id = 'panel',
                         tabPanel('Plot', br(), textOutput("text_1"),
                                  fluidRow(
                                    column(width = 6, plotOutput("plot_1")),
                                    column(width = 6, plotOutput("plot_2")))),
                         tabPanel('Table', br(), dataTableOutput("table_sequia"))
             )
      )
    )
  )
)