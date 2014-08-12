library(shiny)
load("data/data_app.RData")

shinyUI(
  fluidPage(
    tags$head(
      tags$link(rel = "stylesheet", type = "text/css", href = "http://bootswatch.com/cosmo/bootstrap.min.css"),
      tags$link(rel = "stylesheet", type = "text/css", href = "custom.css")
    ),
    br(),
    fluidRow(
      column(width = 3, id = "side_menu",
             h4("Analisis de Lorem Ipsum"),
             hr(),
             p("Escoge una region y un fecha:"),
             selectInput("region_input", NULL, regiones_select, selectize = TRUE, width = "100%"),
             dateInput("date_input", NULL, value = max(dates_select), format = "yyyy/mm/dd",
                       language = "es", min = min(dates_select), max = max(dates_select)),
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