# The American Community Survey distributes downloadable data about United States communities.
# Download the 2006 microdata survey about housing for the state of Idaho using download.file()
# from here:
# 
# https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2Fss06hid.csv
# 
# and load the data into R. The code book, describing the variable names is here:
# 
# https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2FPUMSDataDict06.pdf
# 
# Create a logical vector that identifies the households on greater than 10 acres who sold more than
# $10,000 worth of agriculture products. Assign that logical vector to the variable agricultureLogical.
# Apply the which() function like this to identify the rows of the data frame where the logical vector
# is TRUE.
# 
# which(agricultureLogical)
# 
# What are the first 3 values that result?
# 153 ,236, 388
# 236, 238, 262
# 125, 238,262 <- correct answer
# 59, 460, 474

url <- 'https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2Fss06hid.csv'
filename <- 'community_survey_2006.csv'

# use method='curl' if on a Mac, skip it if on Windows
if (.Platform$OS.type == "windows") {
	download.file(url, destfile=filename)
} else {
	download.file(url, destfile=filename, method='curl')
}

df <- read.csv(filename)

# Per description pdf file above:
# df$ACR is the acreage, w 3 indicating house is on ten or more acres
# df$AGS is amount of agri products sold, w 6 indicating $10,000+
agricultureLogical <- (df$ACR >= 3) & (df$AGS >= 6)
which(agricultureLogical)



# Question 2
# Using the jpeg package read in the following picture of your instructor into R
# 
# https://d396qusza40orc.cloudfront.net/getdata%2Fjeff.jpg
# 
# Use the parameter native=TRUE. What are the 30th and 80th quantiles of the resulting data?
# (some Linux systems may produce an answer 638 different for the 30th quantile)
#
# -15259150 -10575416 <- correct answer
# -16776430 -15390165
# 10904118 -594524
# -10904118 -10575416

url <- 'https://d396qusza40orc.cloudfront.net/getdata%2Fjeff.jpg'
filename <- 'jeff.jpg'

# use method='curl' if on a Mac, skip it if on Windows
if (.Platform$OS.type == "windows") {
	download.file(url, destfile=filename)
} else {
	download.file(url, destfile=filename, method='curl')
}

img <- readJPEG(filename, native=TRUE)

quantile(img, probs=c(0.30, 0.80))



# Question 3
# Load the Gross Domestic Product data for the 190 ranked countries in this data set:
#
# https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2FGDP.csv
#
# Load the educational data from this data set:
#
# https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2FEDSTATS_Country.csv
#
# Match the data based on the country shortcode. How many of the IDs match?
# Sort the data frame in descending order by GDP rank (so United States is last).
# What is the 13th country in the resulting data frame?
#
# Original data sources:
#
# http://data.worldbank.org/data-catalog/GDP-ranking-table
#
# http://data.worldbank.org/data-catalog/ed-stats
#
# 190 matches, 13th country is St. Kitts and Nevis
# 234 matches, 13th country is St. Kitts and Nevis
# 189 matches, 13th country is St. Kitts and Nevis <- correct answer
# 234 matches, 13th country is Spain
# 189 matches, 13th country is Spain
# 190 matches, 13th country is Spain

gdp_url <- 'https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2FGDP.csv'
education_url <- 'https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2FEDSTATS_Country.csv'

gdp_filename <- 'GDP.csv'
education_filename <- 'education.csv'

# use method='curl' if on a Mac, skip it if on Windows
if (.Platform$OS.type == "windows") {
	download.file(gdp_url, destfile=gdp_filename)
	download.file(education_url, destfile=education_filename)
} else {
	download.file(gdp_url, destfile=gdp_filename, method='curl')
	download.file(education_url, destfile=education_filename, method='curl')
}

gdp_df <- read.csv(gdp_filename, stringsAsFactors=FALSE)
education_df <- read.csv(education_filename)

# convert gdp_df$Gross.domestic.product.2012 from character vector to integer (introduces some NAs)
gdp_df$Gross.domestic.product.2012 <- as.integer(gdp_df$Gross.domestic.product.2012)

# get the subset that is actually ranked
ranked_gdp_df <- gdp_df[!is.na(gdp_df$Gross.domestic.product.2012), ]

# this is how many country codes match between the two dfs
length(which(ranked_gdp_df$X %in% education_df$CountryCode)) # gives 189

# 13th country when sorted in descending order of GDP rank
ranked_gdp_df[order(ranked_gdp_df$Gross.domestic.product.2012, ), ][13, 'X'] # gives "KNA" (St Kitts & Nevis)



# Question 4
# What is the average GDP ranking for the "High income: OECD" and "High income: nonOECD" group?
#
# 32.96667, 91.91304 <- correct answer
# 23, 30
# 23, 45
# 23.966667, 30.91304
# 133.72973, 32.96667
# 30, 37

# first merge the two dfs by country ID
merged_df <- merge(ranked_gdp_df, education_df, by.x='X', by.y='CountryCode')

# the use tapply to get the mean of the GDP, grouped by Income.Group
tapply(merged_df$Gross.domestic.product.2012, merged_df$Income.Group, mean)



# Question 5
# Cut the GDP ranking into 5 separate quantile groups. Make a table versus Income.Group.
# How many countries are Lower middle income but among the 38 nations with highest GDP?
#
# 3
# 0
# 5 <- correct answer, bec apparently "with highest GDP" in Q was typo, should say "lowest GDP"
# 18

# we want 5 quantile groups, which means 6 "probs" for the quantile functino
quantile_groups <- seq(0, 1, length=6)

# create a new Income.Quantile column, and cut the GDP into it according to 5 GDP quantile groups
merged_df$Income.Quantile <- cut(merged_df$Gross.domestic.product.2012,
	breaks=quantile(merged_df$Gross.domestic.product.2012, probs=quantile_groups))

# make a table of Income.Group vs Income.Quantile, and read off the answer to the question
table(merged_df$Income.Group, merged_df$Income.Quantile) # answer is 5 (see above re typo in Q)
