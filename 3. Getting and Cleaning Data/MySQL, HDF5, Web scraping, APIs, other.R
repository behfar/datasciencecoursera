## Coursera JHU Series, Course 3 Getting and Cleaning Data, Week 1

## Reading local files

# Download the file to load
if (!file.exists('data')) {
	dir.create('data')
}
setwd('data')

fileUrl <- 'https://data.baltimorecity.gov/api/views/dz54-2aru/rows.csv?accessType=DOWNLOAD'
download.file(fileUrl, destfile='cameras.csv', method='curl')
dateDownloaded <- date()

# Loading flat files - read.table() - Example: Baltimore camera data

cameraData <- read.table('./data/cameras.csv', sep=',', header=TRUE) # slighly clunky with sep, header
head(cameraData)

cameraData <- read.csv('./data/cameras.csv') # read.csv sets sep=',' and header=TRUE
head(cameraData)

# Some more important parameters:
# quote - you can tell R whether there are any quotes values. quote = "" means no quotes.
# na.strings - set the character that represents a missing value
# nrows - how many rows to read of the file
# skip - the number of lines to skip before starting to read



## MySQL

# install.packages('RMySQL')

library(RMySQL)

# Connecting and listing databases
ucscDB <- dbConnect(MySQL(), user='genome', host='genome-mysql.cse.ucsc.edu')
result <- dbGetQuery(ucscDB, 'show databases;')
dbDisconnect(ucscDB)

print(result)

# COnnecting to hg19 and listing tables
hg19 <- dbConnect(MySQL(), user='genome', db='hg19', host='genome-mysql.cse.ucsc.edu')
allTables <- dbListTables(hg19)

print(length(allTables))
print(allTables[1:5])

# Get dimensions of a specific table
dbListFields(hg19, 'affyU133Plus2')
dbGetQuery(hg19, 'select count(*) from affyU133Plus2')

# Read from the table
affyData <- dbReadTable(hg19, 'affyU133Plus2')
head(affyData)

# Select a specific subset
query <- dbSend(hg19, 'select * from affyU133Plus2 where misMatches between 1 and 3')
affyMis <- fetch(query)
quantile(affyMis$misMatches)



## HDF5 - hdfgroup.org

# Used for hierarchically storing large data sets.
# Groups contain zero or more datasets and metadata.
# Datasets are multi-dim arrays with metadata.

# R HDF5 package
source('http://bioconductor.org/biocLite.R')
biocLite('rhdf5')

library(rhdf5)
created <- h5createFile('example.h5')
created <- # should return [1] TRUE

# Create groups
created <- h5createGroup('example.h5', 'foo')
created <- h5createGroup('example.h5', 'baa')
created <- h5createGroup('example.h5', 'foo/foobaa')
h5ls('example.h5')

# Write to groups
A <- matrix(1:10, nr=5, nc=2)
h5write(A, 'example.h5', 'foo/A') # group is /foo, name is A
B <- array(seq(0.1, 2.0, by=0.1), dim=c(5,2,2))
attr(B, 'scale') <- 'liter'
h5write(B, 'example.h5', 'foo/foobaa/B') # group is /foo/foobaa, name is B
h5ls('example.h5')

# Write a dataset
df <- data.frame(1L:5L,
	seq(0,1,length.out=5),
	c('ab', 'cde', 'fghi', 'a', 's'),
	stringsAsFactors=FALSE)
h5write(df, 'example.h5', 'df') # no group (ie at top level '/'), name is df
h5ls('example.h5')

# Reading data
readA <- h5read('exmaple.h5', 'foo/A')
readB <- h5read('exmaple.h5', 'foo/foobaa/B')
readdf <- h5read('exmaple.h5', 'df')
readA

# Writing and reading chunks
h5write(c(12,13,14), 'example.h5', 'foo/A', index=list(1:3, 1)) # write 12,13,14 into rows 1:3 and column 1 of foo/A
h5read('example.h5', 'foo/A')

# HDF5 can be used to optimize reading/writing from disk in R
# Tutorial at bioconductor.org



## Reading data from the web

# Getting data off webpages - readLines()
con <- url('http://scholar.google.com/citations?user=HI-I6C0AAAAl&bl=en')
htmlCode <- readLines(con)
close(con)
print(htmlCode)

# Parsing with XML
library(XML)
url <- 'http://scholar.google.com/citations?user=HI-I6C0AAAAl&bl=en'
html <- htmlTreeParse(url, useInternalNode=T)

# Get the title of the page
result <- xpathSApply(html, '//title', xmlValue)
print(result)

# Get the number of times Jeff's papers have been cited by others
result <- xpathSApply(html, "//td[@id='col-citedby']", xmlValue)
print(result)

# GET from the httr package (read about the httr package at http://cran.r-project.org/web/packages/httr/httr.pdf)
library(httr); html2 <- GET(url)
content2 <- content(html2, as='text')
parsedHtml <- htmlParse(content2, asText=TRUE)
xpathSApply(parsedHtml, '//title', xmlValue)

# Accessing websites with passwords
pg2 <- GET('http://httpbin.org/basic-auth/user/passwd', authenticate('user', 'passwd'))
print(pg2)

print(names(pg2))

# Using handles to prevent having to authenticate over and over again
google <- handle('http://google.com')
pg1 <- GET(handle=google, path='/')
pg2 <- GET(handle=google, path='search')

# Also, see many web scraping examples at R-bloggers http://www.r-bloggers.com/?s=Web+Scraping



## Reading data from APIs

# Creating a Twitter application (create a new app on dev.twitter.com, and the execute below code)
myapp <- oauth_app('twitter',
					key='sEoiV2is7QUO6VQ4EbotIxklK',
					secret='8GUYigsHCoducbQt0ZlNagRsGOrOquUO4b6gPVcFj7qK46dYTD')

sig <- sign_oauth1.0(myapp,
					 token='18698333-BF6jUvNJXG4gI0BkpzlxCGpy3a2HIZd5eEMs1YGcZ',
					 token_secret='Y7uvvESHczL25RL2pP97f5IHUyWhWtJBpLssH60nXVs1j')

homeTL <- GET('https://api.twitter.com/1.1/statuses/home_timeline.json', sig)

json1 <- content(homeTL)
library('rjson') # need this for the toJSON call in next line
json2 <- jsonlite::fromJSON(toJSON(json1))

print(json2[1, 1:4])

# In general, look at Twitter documentation at https://dev.twitter.com/docs/api/1.1



## Reading from other resources

# file - open a connection to a text file
# url - open a connection to a url
# gzfile - open a connection to a .gz file
# bzfile - open a connection to a .bz2 file
# ?connections for more information
# remember to close connections

# Foreign package - loads data from Minitab, S, SAS, SPSS, Stata, Systat
# Packages for reading images - jpeg, readbitmap, png, EBImage (Bioconductor)
# Packages for reading GIS data - rdgal, rgeos, raster
# Packages for reading music data - tuneR, seewave

