## This first line will likely take a few seconds. Be patient!
NEI <- readRDS("exdata-data-NEI_data/summarySCC_PM25.rds")
SCC <- readRDS("exdata-data-NEI_data/Source_Classification_Code.rds")

# Q2. Have total emissions from PM2.5 decreased in the Baltimore City, Maryland (𝚏𝚒𝚙𝚜 == "𝟸𝟺𝟻𝟷𝟶")
# from 1999 to 2008? Use the base plotting system to make a plot answering this question.
#
# Answer: Yes, see plot

library(dplyr)

# compute emissions summary
totals <- NEI %>%
	filter(fips == '24510') %>%
	group_by(year) %>%
	summarize(total.emissions=sum(Emissions))

# plot to png file
png(filename='plot2.png', width=480, height=480, units='px')
barplot(totals$total.emissions, names.arg=totals$year, xlab='year', ylab='total.emissions (tons)',
	main='Baltimore City total emissions 1999-2008')
dev.off(which=dev.cur())
