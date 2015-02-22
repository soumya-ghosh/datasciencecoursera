# Across the United States, how have emissions from coal combustion-related sources
# changed from 1999-2008?

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

coal <- grep("coal", sccData$Short.Name, ignore.case = T)
coal <- sccData[coal, ]
coal <- neiData[neiData$SCC %in% coal$SCC, ]


# Summarize the emissions by year to simplify the plot
total <- ddply(coal, .(year),
               summarise,
               TotalEmissions = sum(Emissions))

png("./figure/plot4.png")

# Plot the data -- finding total emissions each year
g <- ggplot(total, aes(year, TotalEmissions))
g <- g + geom_line() + geom_point() + 
    labs(title = "Total Emissions From Coal Combustion-related Sources\n from 1999 to 2008",
         x = "Year", y = "Total Emissions")
print(g)
dev.off()