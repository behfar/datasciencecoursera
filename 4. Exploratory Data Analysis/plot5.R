## This first line will likely take a few seconds. Be patient!
NEI <- readRDS("exdata-data-NEI_data/summarySCC_PM25.rds")
SCC <- readRDS("exdata-data-NEI_data/Source_Classification_Code.rds")

# Q5. How have emissions from motor vehicle sources changed from 1999–2008 in Baltimore City?
#
# Answer: They have dropped. See plot

library(dplyr)

# identify SCCs related to vehicle sources
vehicle.SCC <- SCC %>%
	filter(grepl('Vehicle', Short.Name)) %>%
	select(SCC)

# compute emissions summary
totals <- NEI %>%
	filter(fips == '24510') %>%
	filter(SCC %in% vehicle.SCC$SCC) %>%
	group_by(year) %>%
	summarize(total.emissions=sum(Emissions))

# plot to png file
library(ggplot2)
png(filename='plot5.png', width=480, height=480, units='px')
ggplot(totals, aes(factor(year), total.emissions)) +
	geom_bar(stat = 'identity') +
	xlab('year') +
	ylab('total emissions (tons)') +
	ggtitle('Baltimore City total emissions from motor vehicle sources 1999-2008')
dev.off(which=dev.cur())
