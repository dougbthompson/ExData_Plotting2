
# load National Emissions Inventory (NEI) data
NEI <- readRDS("data/summarySCC_PM25.rds")
SCC <- readRDS("data/Source_Classification_Code.rds")

NEI$year <- factor(NEI$year, levels = c('1999', '2002', '2005', '2008'))

# Baltimore City, MD fips = 24510
BC.onroad <- subset(NEI, fips == 24510 & type == 'ON-ROAD')

# agg
BC.df <- aggregate(BC.onroad[, 'Emissions'], by = list(BC.onroad$year), sum)
colnames(BC.df) <- c('year', 'Emissions')

png("plot5.png", width = 800, height = 600, units = 'px')
gplot <- ggplot(data = BC.df, aes(x = year, y = Emissions)) + 
         geom_bar(aes(fill = year), stat = "identity") + 
         guides(fill = FALSE) + 
         ggtitle("Total Emissions of Motor Vehicle Sources in Baltimore City") + 
         ylab("PM2.5") + xlab("Year") + 
         theme(legend.position = "none") + 
         geom_text(aes(label = round(Emissions, 0), size = 1, hjust = 0.5, vjust = 2))

suppressWarnings(print(gplot))
dev.off()
