## This first line will likely take a few seconds. Be patient!
NEI <- readRDS("exdata-data-NEI_data/summarySCC_PM25.rds")
SCC <- readRDS("exdata-data-NEI_data/Source_Classification_Code.rds")

# Q1. Have total emissions from PM2.5 decreased in the United States from 1999 to 2008?
# Using the base plotting system, make a plot showing the total PM2.5 emission from all
# sources for each of the years 1999, 2002, 2005, and 2008.
#
# Answer: Yes. See plot

library(dplyr)

# compute emissions summary
totals <- NEI %>%
	group_by(year) %>%
	summarize(total.emissions=sum(Emissions))

# plot to png file
png(filename='plot1.png', width=480, height=480, units='px')
barplot(totals$total.emissions, names.arg=totals$year, xlab='year', ylab='total.emissions (tons)',
	main='US total emissions 1999-2008')
dev.off(which=dev.cur())
