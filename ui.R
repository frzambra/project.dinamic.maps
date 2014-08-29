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
             hr(),
             p(" ")
      ),
      column(width = 9,
             navbarPage("plotGooleMaps in shinyapps",
                        mainPanel(uiOutput('mymap')))
      )
    )
  )
)