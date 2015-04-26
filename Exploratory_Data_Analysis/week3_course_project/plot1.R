# Have total emissions from PM2.5 decreased in the United States from 1999 to 2008? 
# Using the base plotting system, make a plot showing the total PM2.5 emission 
# from all sources for each of the years 1999, 2002, 2005, and 2008.

# Check if both data exist in the environment. If not, load the data.
if(!"neiData" %in% ls())
{
    neiData <- readRDS("./summarySCC_PM25.rds")
}
if(!"sccData" %in% ls())
{
    sccData <- readRDS("./Source_Classification_Code.rds")
}
neiData <- as.data.table(readRDS("summarySCC_PM25.rds"))

png("figure/plot1.png")
plot(neiData[,list(TotalEmissions=sum(Emissions)), by = year], 
     xlab = "Year", ylab = " PM2.5 Emissions",pch = 19,type = "l",
     main = "Total Emissions of PM2.5 from 1999 to 2008",col = "red")
dev.off()
