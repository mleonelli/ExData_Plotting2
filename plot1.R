plot1 = function(){
  
  ##Installing data.table for performance
  if(require("data.table") == 0){
    install.packages("data.table")
  }
  library(data.table)
  
  ## This first line will likely take a few seconds. Be patient!
  NEI <- readRDS("summarySCC_PM25.rds")
  SCC <- readRDS("Source_Classification_Code.rds")
  
  ## Saving data into DT
  DT <- data.table(NEI)
  
  ## Preparing data for plotting - Plot 1
  dt <- DT[, sum(Emissions) / 1000000, by = year]
  
  
  png(file = "plot1.png", width = 480, height = 480) 
  plot(dt, 
       ylab="PM25 Emissions (in Mtons)", 
       xlab="Year", 
       pch=2,
       main = "PM25 Emissions Trend in US",
       xlim = c(1999, 2008),
       axes = FALSE
       )
  axis(side=1, at=dt$year)
  axis(side=2, at=dt$V1)
  lines(dt, col="green", type="l", lwd="2")
  box()
  
  dev.off()
}