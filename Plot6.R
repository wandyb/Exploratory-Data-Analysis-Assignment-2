# Compare emissions from motor vehicle sources in Baltimore City with emissions from motor vehicle sources 
# in Los Angeles County, California. Which city has seen greater changes over time in motor vehicle 
# emissions?

# Read in data
NEI <- readRDS("./summarySCC_PM25.rds")
SCC <- readRDS("./Source_Classification_Code.rds")

# Subset the NEI data corresponding to Baltimore
Baltimore <- subset(NEI, fips == "24510")

# Subset the NEI data corresponding to Baltimore
LA <- subset(NEI, fips == "06037")

# Subset the NEI data corresponding to motor vehicles
vehicle <- grepl("vehicle", SCC$SCC.Level.Two, ignore.case = TRUE)
vehicle.SCC <- SCC[vehicle, ]$SCC

# Subset Baltimore NEI data corresponding to motor vehicles
Baltimore.vehicles <- Baltimore[Baltimore$SCC %in% vehicle.SCC, ]
# Give fips a city a name
Baltimore.vehicles$city <- "Baltimore City, MD"

# Subset LA NEI data corresponding to motor vehicles
LA.vehicles <- LA[LA$SCC %in% vehicle.SCC, ]
# Give fips a city a name
LA.vehicles$city <- "Los Angeles County, CA"

# Combine the two subsets with city name into one data frame
comparison <- rbind(Baltimore.vehicles, LA.vehicles)

# Generate the graph in the same directory as the source code using ggplot2
library(ggplot2)
png(filename = "./Plot5.png", width = 480, height = 480, units = "px", bg = "transparent")
plot.comparison <- ggplot(comparison, aes(x = factor(year), y = Emissions/10^3), fill = city) +
                   geom_bar(stat = "identity", aes(fill = year), width = 0.6) +
                   facet_grid( ~ city) +
                   guides(fill = FALSE) + 
                   theme_bw() +
                   labs(x = "Year", y = "Total PM2.5 Emission (in kilotons)") + 
                   labs(title = "PM Motor Vehicle Source Emissions in Baltimore and Los Angeles, 1999-2008")
plot(plot.comparison)
dev.off()