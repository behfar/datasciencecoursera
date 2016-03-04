## This first line will likely take a few seconds. Be patient!
NEI <- readRDS("exdata-data-NEI_data/summarySCC_PM25.rds")
SCC <- readRDS("exdata-data-NEI_data/Source_Classification_Code.rds")

# Q4. Across the United States, how have emissions from coal combustion-related sources
# changed from 1999–2008?
#
# Answer: They have dropped. See plot

library(dplyr)

# identify SCCs related to combustion and coal
coal.SCC <- SCC %>%
	filter(grepl('Combustion', SCC.Level.One) & grepl('Coal', SCC.Level.Three)) %>%
	select(SCC)

# compute emissions summary
totals <- NEI %>%
	filter(SCC %in% coal.SCC$SCC) %>%
	group_by(year) %>%
	summarize(total.emissions=sum(Emissions))

# plot to png file
library(ggplot2)
png(filename='plot4.png', width=480, height=480, units='px')
ggplot(totals, aes(factor(year), total.emissions)) +
	geom_bar(stat = 'identity') +
	xlab('year') +
	ylab('total emissions (tons)') +
	ggtitle('US total emissions from coal combustion sources 1999-2008')
dev.off(which=dev.cur())
