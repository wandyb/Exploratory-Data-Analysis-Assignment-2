# Have total emissions from PM2.5 decreased in the United States from 1999 to 2008? 
# Using the base plotting system, make a plot showing the total PM2.5 emission from all sources 
# for each of the years 1999, 2002, 2005, and 2008.

# Read in data
NEI <- readRDS("./summarySCC_PM25.rds")
SCC <- readRDS("./Source_Classification_Code.rds")

# Sum of emissions per year 
Sum.NEI <- aggregate(Emissions ~ year, data = NEI, FUN = sum)

# Generate the graph in the same directory as the source code
png(filename = "./Plot1.png", width = 480, height = 480, units = "px", bg = "transparent")
barplot(Sum.NEI$Emissions, names.arg = Sum.NEI$year, main = "Total PM2.5 Emissions by Year", xlab = "Year", ylab = "PM2.5 Emissions (10^6 tons)")
dev.off()