
# load National Emissions Inventory (NEI) data
NEI <- readRDS("data/summarySCC_PM25.rds")
SCC <- readRDS("data/Source_Classification_Code.rds")

# extract coal related data
SCC.coal = SCC[grepl("coal", SCC$Short.Name, ignore.case = TRUE), ]

# Merges two data sets
merge <- merge(x = NEI, y = SCC.coal, by = 'SCC')
merge.sum <- aggregate(merge[, 'Emissions'], by = list(merge$year), sum)
colnames(merge.sum) <- c('Year', 'Emissions')

png("plot4.png", width = 800, height = 600, units = 'px')
gplot <- ggplot(data = merge.sum, aes(x = Year, y = Emissions / 1000)) + 
         geom_line(aes(group = 1, col = Emissions)) + 
         geom_point(aes(size = 2, col = Emissions)) + 
         ggtitle("Total Emissions of PM2.5") +
         ylab("PM2.5 in kilotons") + 
         theme(legend.position = "none") +
         geom_text(aes(label = round(Emissions / 1000, digits = 2), size = 2, hjust = 0.9, vjust = 1.5)) + 
         scale_colour_gradient(low = "black", high = "blue")

suppressWarnings(print(gplot))
dev.off()

