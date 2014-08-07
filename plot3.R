plot3 = function(){
  
  ##Installing data.table for performance
  if(require("data.table") == 0){
    install.packages("data.table")
  }
  library(data.table)
  
  if(require("ggplot2") == 0){
    install.packages("ggplot2")
  }
  library(ggplot2)
  
  ## This first line will likely take a few seconds. Be patient!
  NEI <- readRDS("summarySCC_PM25.rds")
  SCC <- readRDS("Source_Classification_Code.rds")
  
  ## Saving data into DT
  DT <- data.table(NEI)
  
  ## Preparing data for plotting - Plot 3
  dt <- DT[fips == "24510", sum(Emissions) / 1000, by = c("year", "type")]
  
  
  png(file = "plot3.png", width = 480, height = 480)
  ggplot(dt, aes(year, V1)) + geom_point(aes(color = type)) + geom_smooth(aes(color = type), method = "lm") + labs(title = "PM25 Emissions in Baltimore by type") + labs(y = expression("log "* PM[2.5]), x = "Year")
  dev.off()
}