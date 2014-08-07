plot5 = function(){
  
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
  
  ## Preparing data for plotting - Plot 5
  
  ##Filtering for Coal
  coal <- SCC[grep("veh", SCC$Short.Name, ignore.case = T), ]
  
  dt <- DT[DT$SCC %in% coal$SCC & fips == "24510", sum(Emissions) / 1000, by = c("year")]
  
  
  png(file = "plot5.png", width = 480, height = 480)
  ggplot(dt, aes(year, V1)) + geom_point() + geom_smooth(method = "lm") + geom_line() + labs(title = "PM25 Emissions from Motor Vehicles in US (1999-2998)") + labs(y = expression("log "* PM[2.5] * " in ktons"), x = "Year")dev.off()
}