plot4 = function(){
  
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
  
  ## Preparing data for plotting - Plot 4
  
  ##Filtering for Coal
  coal <- SCC[grep("coal", SCC$Short.Name, ignore.case = T), ]
  ##And by Combustion!
  coal <- coal[grep("Combustion", coal$SCC.Level.One, ignore.case = T), ]
  
  dt <- DT[DT$SCC %in% coal$SCC, sum(Emissions) / 1000000, by = c("year")]
  
  
  png(file = "plot4.png", width = 480, height = 480)
  ggplot(dt, aes(year, V1)) + geom_point() + geom_smooth(method = "lm") + geom_line() + labs(title = "PM25 Emissions from Coal Combustion in US (1999-2998)") + labs(y = expression("log "* PM[2.5] * " in Mtons"), x = "Year")
  dev.off()
}