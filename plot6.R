
# load National Emissions Inventory (NEI) data
NEI <- readRDS("data/summarySCC_PM25.rds")
SCC <- readRDS("data/Source_Classification_Code.rds")

NEI$year <- factor(NEI$year, levels = c('1999', '2002', '2005', '2008'))

# Baltimore City, MD fips = 24510
BC.onroad <- subset(NEI, fips == "24510" & type == 'ON-ROAD')
# Los Angeles City, CA fips = 06037
LA.onroad <- subset(NEI, fips == "06037" & type == 'ON-ROAD')

# agg
BC.DF <- aggregate(BC.onroad[, 'Emissions'], by = list(BC.onroad$year), sum)
colnames(BC.DF) <- c('year', 'Emissions')
BC.DF$City <- paste(rep('BC', 4))

LA.DF <- aggregate(LA.onroad[, 'Emissions'], by = list(LA.onroad$year), sum)
colnames(LA.DF) <- c('year', 'Emissions')
LA.DF$City <- paste(rep('LA', 4))

DF <- as.data.frame(rbind(LA.DF, BC.DF))

png("plot6.png", width = 800, height = 600, units = 'px')
gplot <- ggplot(data = DF, aes(x = year, y = Emissions)) + 
         geom_bar(aes(fill = year),stat = "identity") + 
         guides(fill = FALSE) +
         ggtitle("Total Emissions of Motor Vehicle Sources\nBaltimore City, MD  vs  Los Angeles, CA") +
         ylab("PM2.5") + xlab("Year") + 
         theme(legend.position = "none") + 
         facet_grid(. ~ City) + 
         geom_text(aes(label = round(Emissions, 0), size = 1, hjust = 0.5, vjust = -1))

suppressWarnings(print(gplot))
dev.off()
