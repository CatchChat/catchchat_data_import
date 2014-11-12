#
# ShinyMongo App
# a simple R based MongoDB - Viewer
# 

library(shiny)

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

    br(),br(),
    helpText("more at https://github.com:CatchChat/catchchat_data_import/tree/mongodb_data_analysis")
    ),
  
  # main window
  mainPanel(
    
    textOutput("connection"),
    
    conditionalPanel(
      condition = "input.collections_input == '-'",
      h4("Collections overview:"),
      tableOutput("view_collections")
    ),
    
    conditionalPanel(
      condition = "input.collections_input != '-'",
      h4(textOutput("view_head")),
      tableOutput("view")
    )
    
  )

))
