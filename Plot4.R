# Across the United States, how have emissions from coal combustion-related sources changed from 1999???2008?

# Read in data
NEI <- readRDS("./summarySCC_PM25.rds")
SCC <- readRDS("./Source_Classification_Code.rds")

# Subset coal combustion data
combustion <- grepl("comb", SCC$SCC.Level.One, ignore.case = TRUE)
coal.related <- grepl("coal", SCC$SCC.Level.Four, ignore.case = TRUE) 
coalcomb <- (combustion & coal.related)
comb.SCC <- SCC[coalcomb, ]$SCC
comb.NEI <- NEI[NEI$SCC %in% comb.SCC, ]

# Generate the graph in the same directory as the source code using ggplot2
library(ggplot2)
png(filename = "./Plot4.png", width = 480, height = 480, units = "px", bg = "transparent")
coal.plot <- ggplot(comb.NEI, aes(x = factor(year), y = Emissions/10^3), fill = year) +
                geom_bar(stat = "identity", width = 0.6) +
                theme_bw() +  
                guides(fill = FALSE) +
                labs(x="Year", y = "Total PM2.5 Emission (in kilotons)") + 
                labs(title = "PM2.5 Coal Combustion-related Source Emissions in the US from 1999-2008")
plot(coal.plot)
dev.off()