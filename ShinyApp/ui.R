#
# ShinyMongo App
# a simple R based MongoDB - Viewer
# 

library(shiny)
library(ggplot2)

# Define UI for miles per gallon application
shinyUI(pageWithSidebar(
  
  # Application title
  headerPanel("CatchChat Analysis for Data in Mongodb"),
  
  # Sidebar
  sidebarPanel(
    
    textInput("host", "Host:", "localhost"),
    textInput("username", "Username:", ""),
    textInput("password", "Password:", ""),
    
    uiOutput("dbs"),
   
    uiOutput("collections"),
    
    uiOutput("query"),

    dateInput(inputId = "theDate", label = "dateInput"),
                   
    dateRangeInput(inputId = "dateRange", label = "dateRangeInput"),

    br(),br(),
    helpText("https://github.com:CatchChat/catchchat_data_import/tree/mongodb_data_analysis")
    ),
  
  # main window
  mainPanel(
    tabsetPanel(
      tabPanel("Connection", textOutput("connection")),
      tabPanel("Collections",
        conditionalPanel(
          # condition = "input.collections_input == '-'",
          h4("Collections overview:"),
          tableOutput("view_collections")
        )
      ),
      tabPanel("Raw Data",
        conditionalPanel(
          condition = "input.collections_input != '-'",
          h4(textOutput("view_head")),
          tableOutput("view")
        )
      ),

      tabPanel("Created Time Filter",
        plotOutput("plotUserDaily") 
      )
    ) 
  )
))
