plot2 = function(){
  
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
  dt <- DT[fips == "24510", sum(Emissions) / 1000, by = year]
  
  
  png(file = "plot2.png", width = 480, height = 480) 
  plot(dt, 
       ylab="PM25 Emissions (in ktons)", 
       xlab="Year", 
       pch=2,
       main = "PM25 Emissions Trend in Baltimore",
       xlim = c(1999, 2008)
       )
  axis(side=3, at=dt$year, padj = 1)
  axis(side=4, at=dt$V1, padj = 0, labels=format(round(dt$V1, 1), nsmall = 1))
  lines(dt, col="green", type="l", lwd="2")
  
  dev.off()
}