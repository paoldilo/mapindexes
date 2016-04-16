
library(shiny)
shinyUI(fluidPage(
     titlePanel("Get 15 major stock indexes quotes on world map by date"),
     sidebarLayout(
          sidebarPanel(
               helpText("Select a  date on calendar or press the play button underneath the slider to see the animation"),

               sliderInput("Year", "Date to be displayed:", 
                    min=as.Date("01/05/16",format="%m/%d/%y"), max=Sys.Date()-1, 
                    value=Sys.Date()-1,animate=animationOptions(interval = 2000, 
                    loop = FALSE), timeFormat="%F")
               
     ),
     mainPanel(
          h3("Stock indexes world map"),
          helpText("This application retrieves the stock markets indexes of 15 majow world indices, computes the percentage difference with the previous day 
                   and display the increase (in green) or decrease (in red) of the index."),
          helpText("To use the application you can either select the date with the slider 
           to get a specific date or press the play button on the right lower corner of the slider to start
           the anomation day by day. Enjoy"),
          verbatimTextOutput("date_O"),
          htmlOutput("distPlot")
          
     )
)))