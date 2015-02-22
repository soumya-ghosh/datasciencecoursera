# Check if both data exist in the environment. If not, load the data.
if (!"neiData" %in% ls()) {
    neiData <- readRDS("./data/summarySCC_PM25.rds")
}
if (!"sccData" %in% ls()) {
    sccData <- readRDS("./data/Source_Classification_Code.rds")
}

balt_LA <- neiData[(neiData$fips == "06037" | neiData$fips == "24510") & neiData$type == "ON-ROAD", ]

# Summarise the totals for sources in Baltimore City and type ON-ROAD to capture motor vehicles
motor <- ddply(balt_LA, .(fips, year), summarise, TotalEmissions = sum(Emissions))

png("./figure/plot6.png")

# Plot the data -- finding total emissions each year
print(qplot(year, TotalEmissions, data=motor, colour=fips, geom="line",
            main = "Comparison of Total Emissions From Motor\n Vehicle Sources in Baltimore City\n and Los Angeles County from 1999 to 2008" ))
dev.off()
