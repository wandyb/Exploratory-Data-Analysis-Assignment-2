# Have total emissions from PM2.5 decreased in the Baltimore City, Maryland from 1999 to 2008? 
# Use the base plotting system to make a plot answering this question.

# Read in data
NEI <- readRDS("./summarySCC_PM25.rds")
SCC <- readRDS("./Source_Classification_Code.rds")

# Subset NEI data according to Baltimore, MD
Baltimore.NEI <- subset(NEI, fips == "24510")

# Sum of emissions per year in Baltimore
Sum.Baltimore <- aggregate(Emissions ~ year, data = Baltimore.NEI, FUN = sum)

# Generate the graph in the same directory as the source code
png(filename = "./Plot2.png", width = 480, height = 480, units = "px", bg = "transparent")
barplot(Sum.Baltimore$Emissions, names.arg = Sum.Baltimore$year, main = "Total PM2.5 Emissions by Year in Baltimore, MD", xlab = "Year", ylab = "PM2.5 Emissions (10^6 tons)")
dev.off()
