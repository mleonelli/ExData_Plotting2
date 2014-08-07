plot6 = function(){
  
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
  
  ## Preparing data for plotting - Plot 6
  
  ##Filtering for Coal
  coal <- SCC[grep("motor", SCC$Short.Name, ignore.case = T), ]
  coal <- coal[grep("veh", coal$Short.Name, ignore.case = T), ]
  
  dt <- DT[DT$SCC %in% coal$SCC & (fips == "24510" | fips == "06037") , sum(Emissions) / 1000, by = c("year", "fips")]
  
  
  png(file = "plot6.png", width = 480, height = 480)
  ggplot(dt, aes(year, V1)) + 
    geom_point(aes(color = fips)) + 
    geom_line(aes(color = fips)) + 
    labs(title = "PM25 Emissions from Motor Vehicles\n Baltimore vs Los Angeles (1999-2008)") + 
    labs(y = expression("log "* PM[2.5] * " in ktons"), x = "Year") + 
    scale_colour_discrete(name = "City", label = c("Los Angeles","Baltimore"))
  
  dev.off()
}