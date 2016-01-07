# Question 1
# The American Community Survey distributes downloadable data about United States communities.
# Download the 2006 microdata survey about housing for the state of Idaho using download.file()
# from here: https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2Fss06hid.csv
# and load the data into R. The code book, describing the variable names is here:
# https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2FPUMSDataDict06.pdf
# How many properties are worth $1,000,000 or more?

setwd('/Users/behfar/Documents/GitHub/datasciencecoursera/3. Getting and Cleaning Data')
url <- 'https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2Fss06hid.csv'
filename <- 'community_survey_2006.csv'
download.file(url, destfile=filename, method='curl')
df <- read.csv(filename)
df_with_vals <- df[!is.na(df$VAL), ]
properties_above_a_million <- nrow(df_with_vals[df_with_vals$VAL == 24, ])
cat('There are', properties_above_a_million, 'properties above a million dollars.')

# Question 3
# Download the Excel spreadsheet on Natural Gas Aquisition Program here:
# https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2FDATA.gov_NGAP.xlsx
# Read rows 18-23 and columns 7-15 into R and assign the result to a variable called:
# dat
# What is the value of:
# sum(dat$Zip*dat$Ext,na.rm=T)
library(xlsx)
url <- 'https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2FDATA.gov_NGAP.xlsx'
filename <- 'natural_gas_acquisition_program.xlsx'
download.file(url, destfile=filename, method='curl')
dat <- read.xlsx('natural_gas_acquisition_program.xlsx',
				 sheetIndex = 1, rowIndex = 18:23, colIndex = 7:15)
result <- sum(as.numeric(dat$Zip) * as.numeric(dat$Ext),na.rm=T)
cat('The expression result is', result)

# Question 4
# Read the XML data on Baltimore restaurants from here:
# https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2Frestaurants.xml
# How many restaurants have zipcode 21231?
library(XML)
url <- 'https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2Frestaurants.xml'
filename <- 'baltimore_restaurants'
download.file(url, destfile=filename, method='curl')
doc <- xmlTreeParse(filename, useInternal=TRUE)

