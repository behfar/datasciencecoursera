# Question 1
# The American Community Survey distributes downloadable data about United States communities.
# Download the 2006 microdata survey about housing for the state of Idaho using download.file()
# from here: https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2Fss06hid.csv
# and load the data into R. The code book, describing the variable names is here:
# https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2FPUMSDataDict06.pdf
# How many properties are worth $1,000,000 or more?

url <- 'https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2Fss06hid.csv'
filename <- 'community_survey_2006.csv'

# use method='curl' if on a Mac, skip it if on Windows
if (.Platform$OS.type == "windows") {
	download.file(url, destfile=filename)
} else {
	download.file(url, destfile=filename, method='curl')
}

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

# use method='curl' if on a Mac, skip it if on Windows. On Windows, use mode='wb' (see http://stackoverflow.com/questions/28325744/r-xlsx-package-error)
if (.Platform$OS.type == "windows") {
	download.file(url, destfile=filename, mode='wb')
} else {
	download.file(url, destfile=filename, method='curl')
}

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
filename <- 'baltimore_restaurants.xml'

# use method='curl' if on a Mac, skip it if on Windows
if (.Platform$OS.type == "windows") {
	download.file(url, destfile=filename)
} else {
	download.file(url, destfile=filename, method='curl')
}

doc <- xmlTreeParse(filename, useInternal=TRUE)
rootNode <- xmlRoot(doc)
zipcode <- 21231
zipcodes <- xpathSApply(rootNode, '//zipcode', xmlValue)
num_restaurants_in_zipcode <- length(zipcodes[zipcodes == zipcode])
cat('The number of restaurants with zipcode', zipcode, 'is', num_restaurants_in_zipcode)


# Question 5
# The American Community Survey distributes downloadable data about United States communities.
# Download the 2006 microdata survey about housing for the state of Idaho using download.file() from here:
# https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2Fss06pid.csv
# using the fread() command load the data into an R object DT
# The following are ways to calculate the average value of the variable pwgtp15
# broken down by sex. Using the data.table package, which will deliver the fastest user time?

url <- 'https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2Fss06pid.csv'
filename <- 'housing_micro_survey_data_2006.csv'

# use method='curl' if on a Mac, skip it if on Windows
if (.Platform$OS.type == "windows") {
	download.file(url, destfile=filename)
} else {
	download.file(url, destfile=filename, method='curl')
}

DT <- fread(filename)

cat('system.time(DT[,mean(pwgtp15),by=SEX]) is',
	 system.time(DT[,mean(pwgtp15),by=SEX]), '\n')

#cat('system.time({rowMeans(DT)[DT$SEX==1]; rowMeans(DT)[DT$SEX==2]}) is',
#	 system.time({rowMeans(DT)[DT$SEX==1]; rowMeans(DT)[DT$SEX==2]}), '\n')

cat('system.time(tapply(DT$pwgtp15,DT$SEX,mean)) is',
	 system.time(tapply(DT$pwgtp15,DT$SEX,mean)), '\n')

cat('system.time(mean(DT$pwgtp15,by=DT$SEX)) is', 
	 system.time(mean(DT$pwgtp15,by=DT$SEX)), '\n')

#cat('system.time(mean(DT[DT$SEX==1,]$pwgtp15); mean(DT[DT$SEX==2,]$pwgtp15)) is',
#	 system.time(mean(DT[DT$SEX==1,]$pwgtp15); mean(DT[DT$SEX==2,]$pwgtp15)), '\n')

cat('system.time(sapply(split(DT$pwgtp15,DT$SEX),mean)) is',
	 system.time(sapply(split(DT$pwgtp15,DT$SEX),mean)), '\n')
