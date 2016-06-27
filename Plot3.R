# Of the four types of sources indicated by the type (point, nonpoint, onroad, nonroad) variable, 
# which of these four sources have seen decreases in emissions from 1999???2008 for Baltimore City? 
# Which have seen increases in emissions from 1999???2008? 
# Use the ggplot2 plotting system to make a plot answer this question.

# Read in data
NEI <- readRDS("./summarySCC_PM25.rds")
SCC <- readRDS("./Source_Classification_Code.rds")

# Subset NEI data according to Baltimore, MD
Baltimore.NEI <- subset(NEI, fips == "24510")

# Generate the graph in the same directory as the source code using ggplot2
library(ggplot2)
png(filename = "./Plot3.png", width = 480, height = 480, units = "px", bg = "transparent")
Baltimore.type <- ggplot(Baltimore.NEI, aes(x = factor(year), y = Emissions, fill = type)) + 
                  geom_bar(stat = "identity") +
                  guides(fill = FALSE) +
                  theme_bw() +
                  facet_grid(. ~ type) +
                  labs(x = "year", y = "Total PM2.5 Emssion", title = "Total PM2.5 Emissions by Year in Baltimore, MD by Source Type")
plot(Baltimore.type)                  
dev.off()