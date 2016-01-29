# 1.
# The American Community Survey distributes downloadable data about United States communities.
# Download the 2006 microdata survey about housing for the state of Idaho using download.file() from here:
#
# https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2Fss06hid.csv
#
# and load the data into R. The code book, describing the variable names is here:
#
# https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2FPUMSDataDict06.pdf
#
# Apply strsplit() to split all the names of the data frame on the characters "wgtp". What is the value of
# the 123 element of the resulting list?
#
# "" "15" <- correct answer
#
# "w" "15"
#
# "wgt" "15"
#
# "wgtp" "15"

url <- 'https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2Fss06hid.csv'
filename <- 'community_survey_2006.csv'

# use method='curl' if on a Mac, skip it if on Windows
if (.Platform$OS.type == "windows") {
	download.file(url, destfile=filename)
} else {
	download.file(url, destfile=filename, method='curl')
}

df <- read.csv(filename)

strsplit(names(df), split='wgtp')[123] # <- returns "" "15"



# 2. 
# Load the Gross Domestic Product data for the 190 ranked countries in this data set:
#
# https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2FGDP.csv
#
# Remove the commas from the GDP numbers in millions of dollars and average them. What is the average?
#
# Original data sources:
#
# http://data.worldbank.org/data-catalog/GDP-ranking-table
#
# 377652.4 <- correct answer
#
# 387854.4
#
# 293700.3
#
# 381668.9

url <- 'https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2FGDP.csv'
filename <- 'GDP.csv'

# use method='curl' if on a Mac, skip it if on Windows
if (.Platform$OS.type == "windows") {
	download.file(url, destfile=filename)
} else {
	download.file(url, destfile=filename, method='curl')
}

df <- read.csv(filename)

# column X.3 has the GDP dollar values, and rows 5-194 are the 190 "ranked" rows
mean(as.numeric(gsub(',', '', df$X.3[5:194]))) # <- 377652.4



# 3. 
# In the data set from Question 2 what is a regular expression that would allow you to count the number of
# countries whose name begins with "United"? Assume that the variable with the country names in it is named
# countryNames. How many countries begin with United?
#
# grep("^United",countryNames), 3 <- correct answer

# grep("*United",countryNames), 5

# grep("*United",countryNames), 2

# grep("United$",countryNames), 3



# 4. 
# Load the Gross Domestic Product data for the 190 ranked countries in this data set:
#
# https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2FGDP.csv
#
# Load the educational data from this data set:
#
# https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2FEDSTATS_Country.csv
#
# Match the data based on the country shortcode. Of the countries for which the end of the fiscal year is
# available, how many end in June?
#
# Original data sources:
#
# http://data.worldbank.org/data-catalog/GDP-ranking-table
#
# http://data.worldbank.org/data-catalog/ed-stats
#
# 8
#
# 15
#
# 31
#
# 13 <- correct answer

gdp_url <- 'https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2FGDP.csv'
gdp_filename <- 'GDP.csv'
edu_url <- 'https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2FEDSTATS_Country.csv'
edu_filename <- 'EDU.csv'

# use method='curl' if on a Mac, skip it if on Windows
if (.Platform$OS.type == "windows") {
	download.file(gdp_url, destfile=gdp_filename)
	download.file(edu_url, destfile=edu_filename)

} else {
	download.file(gdp_url, destfile=gdp_filename, method='curl')
	download.file(edu_url, destfile=edu_filename, method='curl')
}

gdp_df <- read.csv(gdp_filename, stringsAsFactors = FALSE)
edu_df <- read.csv(edu_filename, stringsAsFactors = FALSE)

ranked_gdp_df <- gdp_df[!is.na(as.numeric(gdp_df$Gross.domestic.product.2012)), ]


# first merge the two dfs by country ID
merged_df <- merge(ranked_gdp_df, edu_df, by.x='X', by.y='CountryCode')

# then grep on the "Special.Notes" column to count how many rows have their fiscal year end in June
length(grep("^Fiscal year end: June", merged_df$Special.Notes)) # <- returns 13



# 5. 
# You can use the quantmod (http://www.quantmod.com/) package to get historical stock prices for publicly traded
# companies on the NASDAQ and NYSE. Use the following code to download data on Amazon's stock price and get the
# times the data was sampled.
#
# library(quantmod)
# amzn = getSymbols("AMZN",auto.assign=FALSE)
# sampleTimes = index(amzn)
# How many values were collected in 2012? How many values were collected on Mondays in 2012?
#
# 250, 47 <- correct answer
#
# 252, 50
#
# 250, 51
#
# 251, 47

library(quantmod)
amzn = getSymbols("AMZN",auto.assign=FALSE)
sampleTimes = index(amzn)

# how many values in 2012?
years <- year(sampleTimes)
length(which(years == 2012)) # <- returns 250

# how many values on a Mon in 2012?
wdays <- wday(sampleTimes, label=True)
length(which((years == 2012) & (wdays == 'Mon'))) # <- returns 47

