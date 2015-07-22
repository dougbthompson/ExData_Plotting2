
# load National Emissions Inventory (NEI) data
NEI <- readRDS("data/summarySCC_PM25.rds")
SCC <- readRDS("data/Source_Classification_Code.rds")

# Baltimore City, MD fips = 24510
BC <- subset(NEI, fips == 24510)
BC$year <- factor(BC$year, levels = c('1999', '2002', '2005', '2008'))

# ggplot and save to plot3.png

png("plot3.png", width = 800, height = 600, units = "px")
gplot <- ggplot(data = BC, aes(x = year, y = log(BC$Emissions)), na.rm=TRUE) + 
       facet_grid(. ~ type) + guides(fill = F) + geom_boxplot(aes(fill = type)) + 
       stat_boxplot(geom = 'errorbar') + 
       ylab(expression(paste("Log of PM2.5 Emissions"))) + 
       xlab("Year") + 
       ggtitle("Emissions per Type - Baltimore City") +
       geom_jitter(alpha = 0.10)

suppressWarnings(print(gplot))
dev.off()

