
# load National Emissions Inventory (NEI) data
NEI <- readRDS("data/summarySCC_PM25.rds")
SCC <- readRDS("data/Source_Classification_Code.rds")

# Baltimore City, MD subset
BC <- subset(NEI, fips == '24510')

# set margins, barplot and save to plot2.png
par(mar=c(5, 5, 3, 2))

barplot(tapply(X = BC$Emissions, INDEX = BC$year, FUN = sum), 
        main = "Total Emission Baltimore City, MD", 
        xlab = "Year", ylab = "PM2.5")

dev.copy(png, file = "plot2.png")
dev.off()

