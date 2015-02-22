# Of the four types of sources indicated by the type (point, nonpoint, onroad, nonroad) 
# variable, which of these four sources have seen decreases in emissions from 1999-2008 
# for Baltimore City? Which have seen increases in emissions from 1999-2008? 
# Use the ggplot2 plotting system to make a plot answer this question.


library(plyr)
library(ggplot2)

# Check if both data exist in the environment. If not, load the data.
if(!"neiData" %in% ls())
{
    neiData <- readRDS("./summarySCC_PM25.rds")
}
if(!"sccData" %in% ls())
{
    sccData <- readRDS("./Source_Classification_Code.rds")
}
# Summarize the emissions by year and Baltimore City to simplify the plot
balt <- ddply(neiData[neiData$fips == "24510", ],
.(type,year), summarise,
TotalEmissions = sum(Emissions))

png("./figure/plot3.png")

# Plot the data -- finding total emissions each year

g <- ggplot(balt, aes(year, TotalEmissions, colour = type))
g <- g + geom_line() + geom_point() + 
    labs(title = "Total Emissions by Type in Baltimore", 
         x = "Year", y = "Total Emissions")

print(g)

dev.off()