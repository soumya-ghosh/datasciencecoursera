library(ggplot2)
library(plyr)

# Check if both data exist in the environment. If not, load the data.
if (!"neiData" %in% ls()) {
    neiData <- readRDS("./data/summarySCC_PM25.rds")
}
if (!"sccData" %in% ls()) {
    sccData <- readRDS("./data/Source_Classification_Code.rds")
}
balt <- neiData[neiData$fips == "24510" & neiData$type == "ON-ROAD", ]

# Summarise the totals for sources in Baltimore City and type ON-ROAD to capture motor vehicles
motor <- ddply(balt, .(type,year), summarise, TotalEmissions = sum(Emissions))

png("./figure/plot5.png")

# Plot the data -- finding total emissions each year
g <- ggplot(motor, aes(year, TotalEmissions))
g <- g + geom_line() + geom_point() +
    labs(title = "Total Emissions from Motor Vehicles in Baltimore City",
         x = "Year", y = "Total Emissions")

print(g)
dev.off()

