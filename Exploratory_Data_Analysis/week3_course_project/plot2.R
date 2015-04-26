# Have total emissions from PM2.5 decreased in the Baltimore City, 
# Maryland (fips == "24510") from 1999 to 2008? 
# Use the base plotting system to make a plot answering this question.

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

png("figure/plot2.png")
plot(neiData[fips=="24510",list(TotalEmissions=sum(Emissions)), by = year],
     type="l", xlab="Year", main="Total Emissions in Baltimore from 1999 to 2008")
dev.off()