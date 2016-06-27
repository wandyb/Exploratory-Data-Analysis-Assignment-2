# How have emissions from motor vehicle sources changed from 1999???2008 in Baltimore City?

# Read in data
NEI <- readRDS("./summarySCC_PM25.rds")
SCC <- readRDS("./Source_Classification_Code.rds")

# Subset the NEI data corresponding to Baltimore
Baltimore <- subset(NEI, fips == "24510")
# Subset the NEI data corresponding to motor vehicles
vehicle <- grepl("vehicle", SCC$SCC.Level.Two, ignore.case = TRUE)
vehicle.SCC <- SCC[vehicle, ]$SCC

# Subset Baltimore NEI data corresponding to motor vehicles
Baltimore.vehicles <- Baltimore[Baltimore$SCC %in% vehicle.SCC, ]

# Generate the graph in the same directory as the source code using ggplot2
library(ggplot2)
png(filename = "./Plot5.png", width = 480, height = 480, units = "px", bg = "transparent")
motor.vehicles <- ggplot(Baltimore.vehicles, aes(x = factor(year), y = Emissions)) +
                  geom_bar(stat = "identity", width = 0.6) +
                  theme_bw() + 
                  guides(fill = FALSE) +
                  labs(x = "Year", y = "Total PM2.5 Emission") + 
                  labs(title = "PM2.5 Motor Vehicle Source Emissions in Baltimore, MD, from 1999-2008")
plot(motor.vehicles)
dev.off()