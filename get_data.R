suppressPackageStartupMessages(library(quantmod))
library(timeSeries)
suppressPackageStartupMessages(library(zoo))
options("getSymbols.warning4.0"=FALSE)

#set dates
startingDate <- as.Date("01/01/16",format="%m/%d/%y")
today <- Sys.Date()

america <- getSymbols(c("^GSPC", "^GSPTSE","^BVSP"),src="yahoo",auto.assign = T,from=startingDate,to=today)
america2 <- getSymbols(c("^MXX","^MERV"),src="yahoo",auto.assign = T,from=startingDate,to=today)
europe <- getSymbols(c("^FTSE","^GDAXI","^FCHI"),src="yahoo",auto.assign = T,from=startingDate,to=today)
europe <- getSymbols(c("^MCX","FTSEMIB.MI","^IBEX"),src="yahoo",auto.assign = T,from=startingDate,to=today)
asia <- getSymbols(c("^HSI","^N225","^BSESN","^AORD"),src="yahoo",auto.assign = T,from=startingDate,to=today)
africa <- getSymbols(c("JSE:JSE"),src="google",auto.assign = T,from=startingDate,to=today)

usa <- ts(GSPC)
usa <- (diff(usa)/usa[-nrow(usa),] * 100)[,4]
usa <- as.data.frame(usa)
row.names(usa) <- row.names(as.data.frame(GSPC[2:nrow(GSPC),]))
names(usa) <- c("United States")

canada <- ts(GSPTSE)
canada <- (diff(canada)/canada[-nrow(canada),] * 100)[,4]
canada <- as.data.frame(canada)
row.names(canada) <- row.names(as.data.frame(GSPTSE[2:nrow(GSPTSE),]))
names(canada) <- c("Canada")

mex <- ts(MXX)
mex <- (diff(mex)/mex[-nrow(mex),] * 100)[,4]
mex <- as.data.frame(mex)
row.names(mex) <- row.names(as.data.frame(MXX[2:nrow(MXX),]))
names(mex) <- c("Mexico")

brasil <- ts(BVSP)
brasil <- (diff(brasil)/brasil[-nrow(brasil),] * 100)[,4]
brasil <- as.data.frame(brasil)
row.names(brasil) <- row.names(as.data.frame(BVSP[2:nrow(BVSP),]))
names(brasil) <- c("Brasil")

argentina <- ts(MERV)
argentina <- (diff(argentina)/argentina[-nrow(argentina),] * 100)[,4]
argentina <- as.data.frame(argentina)
row.names(argentina) <- row.names(as.data.frame(MERV[2:nrow(MERV),]))
names(argentina) <- c("Argentina")

russia <- ts(MCX)
russia <- (diff(russia)/russia[-nrow(russia),] * 100)[,4]
russia <- as.data.frame(russia)
row.names(russia) <- row.names(as.data.frame(MCX[2:nrow(MCX),]))
names(russia) <- c("Russian Federation")

germany <- ts(GDAXI)
germany <- (diff(germany)/germany[-nrow(germany),] * 100)[,4]
germany <- as.data.frame(germany)
row.names(germany) <- row.names(as.data.frame(GDAXI[2:nrow(GDAXI),]))
names(germany) <- c("Germany")

france <- ts(FCHI)
france <- (diff(france)/france[-nrow(france),] * 100)[,4]
france <- as.data.frame(france)
row.names(france) <- row.names(as.data.frame(FCHI[2:nrow(FCHI),]))
names(france) <- c("France")

italy <- ts(FTSEMIB.MI)
italy <- (diff(italy)/italy[-nrow(italy),] * 100)[,4]
italy <- as.data.frame(italy)
row.names(italy) <- row.names(as.data.frame(FTSEMIB.MI[2:nrow(FTSEMIB.MI),]))
names(italy) <- c("Italy")

uk <- ts(FTSE)
uk <- (diff(uk)/uk[-nrow(uk),] * 100)[,4]
uk <- as.data.frame(uk)
row.names(uk) <- row.names(as.data.frame(FTSE[2:nrow(FTSE),]))
names(uk) <- c("United Kingom")

spain <- ts(IBEX)
spain <- (diff(spain)/spain[-nrow(spain),] * 100)[,4]
spain <- as.data.frame(spain)
row.names(spain) <- row.names(as.data.frame(IBEX[2:nrow(IBEX),]))
names(spain) <- c("Spain")

southafrica <- ts(`JSE:JSE`)
southafrica <- (diff(southafrica)/southafrica[-nrow(southafrica),] * 100)[,4]
southafrica <- as.data.frame(southafrica)
row.names(southafrica) <- row.names(as.data.frame(`JSE:JSE`[2:nrow(`JSE:JSE`),]))
names(southafrica) <- c("South Africa")

china <- ts(HSI)
china <- (diff(china)/china[-nrow(china),] * 100)[,4]
china <- as.data.frame(china)
row.names(china) <- row.names(as.data.frame(HSI[2:nrow(HSI),]))
names(china) <- c("China")

india <- ts(BSESN)
india <- (diff(india)/india[-nrow(india),] * 100)[,4]
india <- as.data.frame(india)
row.names(india) <- row.names(as.data.frame(BSESN[2:nrow(BSESN),]))
names(india) <- c("India")

australia <- ts(AORD)
australia <- (diff(australia)/australia[-nrow(australia),] * 100)[,4]
australia <- as.data.frame(australia)
row.names(australia) <- row.names(as.data.frame(AORD[2:nrow(AORD),]))
names(australia) <- c("Australia")


#unite all data
total <- merge(as.timeSeries(usa), as.timeSeries(mex))
total <- merge(total,as.timeSeries(brasil))
total <- merge(total,as.timeSeries(canada))
total <- merge(total,as.timeSeries(argentina))
total <- merge(total,as.timeSeries(germany))
total <- merge(total,as.timeSeries(russia))
total <- merge(total,as.timeSeries(france))
total <- merge(total,as.timeSeries(italy))
total <- merge(total,as.timeSeries(uk))
total <- merge(total,as.timeSeries(spain))
total <- merge(total,as.timeSeries(southafrica))
total <- merge(total,as.timeSeries(china))
total <- merge(total,as.timeSeries(india))
total <- merge(total,as.timeSeries(australia))

# convert NA to 0
total[is.na(total)]<-0
