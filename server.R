

library(shiny)
library(timeSeries)
suppressPackageStartupMessages(library(googleVis))
options("getSymbols.warning4.0"=FALSE)
#read stock quotes from yahoo finance
source("./get_data.R")

# Define server logic required to draw a histogram
shinyServer(function(input, output) {
     #read the data from the fields

     myday <- reactive({
          # get reactive changes to slider
          input$Year
     })
     
     output$distPlot <- renderGvis({
          
          #get only one row and convert it to dataframe
          if (isWeekday(myday())==TRUE){
               #write the date of the graph in the text box
               output$date_O <-  renderPrint({ paste("Stock quotes for the date", as.character(myday()),sep = " - ")})
               # take the row corresponding with the input date
               vettore <- as.Date(rownames(total))==myday()
               dataToPlot <- total[vettore,]
               dataToPlot <- as.data.frame(dataToPlot)
               # transpose matrix
               dataToPlot <- as.data.frame(t(dataToPlot))
               # add countries as a column and format country names
               dataToPlot <- cbind(row.names(dataToPlot),dataToPlot)
               names(dataToPlot)<- c("Country","Value")
               dataToPlot$Country<- sub("\\."," ",dataToPlot$Country)
               dataToPlot$Perc <- paste0(dataToPlot$Country,"  ",sprintf("%.2f", round(dataToPlot$Value,2)),"%")
               #plot with google Vis
               gvisGeoChart(dataToPlot, locationvar='Country', colorvar='Value',hovervar = 'Perc',
                       options=list(projection="kavrayskiy-vii",
                       colorAxis="{values:[-4,0,4],colors:[\'red', \'white\', \'green']}",
                       backgroundColor= '#81d4fa',datalessRegionColor= '#454545'))
          }
          else {
               #markets are closed so display all countries as zero
               #write the date of the graph in the text box
               output$date_O <-  renderPrint({ paste("Weekend date - Market Closed", as.character(myday()),sep = " - ")})
               # take the first row just to get the country names
               dataToPlot <- as.data.frame(total[1,])
               # transpose matrix
               dataToPlot <- as.data.frame(t(dataToPlot))
               # add countries as a column and set values to zero since markets are closed
               dataToPlot <- cbind(row.names(dataToPlot),dataToPlot)
               dataToPlot[,2] <- 0
               names(dataToPlot)<- c("Country","Value")
               dataToPlot$Country<- sub("\\."," ",dataToPlot$Country)
               dataToPlot$Perc <- paste0(dataToPlot$Country,"  ",sprintf("%.2f", round(dataToPlot$Value,2)),"%")
               # plot using googlevis
               gvisGeoChart(dataToPlot, locationvar='Country', colorvar='Value',hovervar = 'Perc',
                            options=list(projection="kavrayskiy-vii",
                                         colorAxis="{values:[-4,0,4],colors:[\'red', \'white\', \'green']}",
                                         backgroundColor= '#81d4fa',datalessRegionColor= '#454545'))
          }
     })
     
})