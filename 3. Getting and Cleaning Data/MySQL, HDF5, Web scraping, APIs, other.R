## Coursera JHU Series, Course 3 Getting and Cleaning Data, Week 1

## MySQL

# install.packages('RMySQL')

library(RMySQL)

# Connecting and listing databases
ucscDB <- dbConnect(MySQL(), user='genome', host='genome-mysql.cse.ucsc.edu')
result <- dbGetQuery(ucscDB, 'show databases;')
dbDisconnect(ucscDB)

print(result)

# COnnecting to hg19 and listing tables
hg19 <= dbConnect(MySQL(), user='genome', db='hg19', host='genome-mysql.cse.ucsc.edu')
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

## HDF5

# 