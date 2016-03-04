## This first line will likely take a few seconds. Be patient!
NEI <- readRDS("exdata-data-NEI_data/summarySCC_PM25.rds")
SCC <- readRDS("exdata-data-NEI_data/Source_Classification_Code.rds")

# Q3. Of the four types of sources indicated by the 𝚝𝚢𝚙𝚎 (point, nonpoint, onroad, nonroad) variable,
# which of these four sources have seen decreases in emissions from 1999–2008 for Baltimore City?
# Which have seen increases in emissions from 1999–2008? Use the ggplot2 plotting system to make a
# plot answer this question.
#
# Answer: POINT sources show an increase, all other sources show a decrease. See plot

library(dplyr)

# compute emissions summary
totals <- NEI %>%
	filter(fips == '24510') %>%
	group_by(type, year) %>%
	summarize(total.emissions=sum(Emissions))

# plot to png file
library(ggplot2)
png(filename='plot3.png', width=480, height=480, units='px')
ggplot(totals, aes(factor(year), total.emissions)) +
	facet_grid(.~type) +
	geom_bar(stat = 'identity') +
	xlab('year') +
	ylab('total emissions (tons)') +
	ggtitle('Baltimore City total emissions by source type 1999-2008')
dev.off(which=dev.cur())
