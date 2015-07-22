
# load National Emissions Inventory (NEI) data
NEI <- readRDS("data/summarySCC_PM25.rds")
SCC <- readRDS("data/Source_Classification_Code.rds")

# aggregate across years available
EM <- aggregate(NEI[, 'Emissions'], by = list(NEI$year), FUN = sum)
EM$PM <- round(EM[, 2] / 1000, 2)

# set margins, barplot and save to plot1.png
par(mar=c(5, 5, 3, 2))

barplot(EM$PM, names.arg = EM$Group.1, 
        main = "Total Emission of PM2.5", 
        xlab = "Year", ylab = "PM2.5 in Kilotons")

dev.copy(png, file = "plot1.png")
dev.off()

