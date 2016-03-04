## This first line will likely take a few seconds. Be patient!
NEI <- readRDS("exdata-data-NEI_data/summarySCC_PM25.rds")
SCC <- readRDS("exdata-data-NEI_data/Source_Classification_Code.rds")

# Q6. Compare emissions from motor vehicle sources in Baltimore City with emissions from
# motor vehicle sources in Los Angeles County, California (𝚏𝚒𝚙𝚜 == "𝟶𝟼𝟶𝟹𝟽"). Which city
# has seen greater changes over time in motor vehicle emissions?
#
# Answer: Los Angeles County. See plot

library(dplyr)

# identify SCCs related to vehicle sources
vehicle.SCC <- SCC %>%
	filter(grepl('Vehicle', Short.Name)) %>%
	select(SCC)

# compute emissions summary
totals <- NEI %>%
	filter((fips == '24510') | (fips == '06037')) %>%
	mutate(region = ifelse(fips == '24510', 'Baltimore City', 'Los Angeles County')) %>%
	filter(SCC %in% vehicle.SCC$SCC) %>%
	group_by(year, region) %>%
	summarize(total.emissions=sum(Emissions))

# plot to png file
library(ggplot2)
png(filename='plot6.png', width=480, height=480, units='px')
ggplot(totals, aes(factor(year), total.emissions)) +
	facet_grid(.~region) +
	geom_bar(stat = 'identity') +
	xlab('year') +
	ylab('total emissions (tons)') +
	ggtitle('Total emissions from motor vehicle sources 1999-2008')
dev.off(which=dev.cur())
