# Question 1
# Register an application with the Github API here https://github.com/settings/applications.
# Access the API to get information on your instructors repositories (hint: this is the url
# you want "https://api.github.com/users/jtleek/repos"). Use this data to find the time that
# the datasharing repo was created. What time was it created?
# This tutorial may be useful (https://github.com/hadley/httr/blob/master/demo/oauth2-github.r).
# You may also need to run the code in the base R package and not R studio.
# 
# 2014-03-05T16:11:46Z
# 2013-11-07T13:25:07Z <- correct answer, per below code
# 2013-08-28T18:18:50Z
# 2012-06-20T18:39:06Z

# Following the R github tutorial at https://github.com/hadley/httr/blob/master/demo/oauth2-github.r

library(httr)

# 1. Find OAuth settings for github:
#    http://developer.github.com/v3/oauth/
oauth_endpoints("github")

# 2. To make your own application, register at at
#    https://github.com/settings/applications. Use any URL for the homepage URL
#    (http://github.com is fine) and  http://localhost:1410 as the callback url
#
#    Replace your key and secret below.
github_client_ID <- 'c4d7ae252d58c2b3c37e'
github_client_secret <- '538574b6d6127e44458441250b16fb221ae49c90'
myapp <- oauth_app('github',
	key=github_client_ID,
	secret=github_client_secret)

# 3. Get OAuth credentials
github_token <- oauth2.0_token(oauth_endpoints("github"), myapp)

# 4. Use API
gtoken <- config(token = github_token)
url <- 'https://api.github.com/users/jtleek/repos'
req <- GET(url, gtoken)
stop_for_status(req)
print(content(req)) # can use sink('filename') to output into filename (and sink() to stop)

# answer is 2013-11-07T13:25:07Z

# OR:
# req <- with_config(gtoken, GET("https://api.github.com/rate_limit"))
# stop_for_status(req)
# content(req)



# Question 2
# The sqldf package allows for execution of SQL commands on R data frames. We will use the sqldf
# package to practice the queries we might send with the dbSendQuery command in RMySQL.
# Download the American Community Survey data and load it into an R object called acs
# https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2Fss06pid.csv
# Which of the following commands will select only the data for the probability weights pwgtp1
# with ages less than 50?
# 
# sqldf("select * from acs where AGEP < 50 and pwgtp1")
# sqldf("select pwgtp1 from acs")
# sqldf("select * from acs")
# sqldf("select pwgtp1 from acs where AGEP < 50") <- correct answer, confirmed by below code

library(sqldf)

fileUrl <- 'https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2Fss06pid.csv'
filename <- 'american_community_survey.csv'
download.file(fileUrl, destfile=filename, method='curl')
acs <- read.csv.sql(filename)



# Question 3
# Using the same data frame you created in the previous problem, what is the equivalent function
# to unique(acs$AGEP)
# 
# sqldf("select distinct pwgtp1 from acs")
# sqldf("select AGEP where unique from acs")
# sqldf("select unique * from acs")
# sqldf("select distinct AGEP from acs") <- correct answer, just based on SQL syntax



# Question 4
# How many characters are in the 10th, 20th, 30th and 100th lines of HTML from this page:
# http://biostat.jhsph.edu/~jleek/contact.html
# (Hint: the nchar() function in R may be helpful)
# 
# 45 92 7 2
# 45 31 7 31
# 43 99 8 6
# 43 99 7 25
# 45 31 2 25
# 45 0 2 2
# 45 31 7 25 <- correct answer, based on below code

con <- url('http://biostat.jhsph.edu/~jleek/contact.html')
htmlCode <- readLines(con)
close(con)

cat('nchar of line 10', nchar(htmlCode[10]),'\n',
	'nchar of line 20', nchar(htmlCode[20]),'\n',
	'nchar of line 30', nchar(htmlCode[30]),'\n',
	'nchar of line 100', nchar(htmlCode[100]),'\n')



# Question 5
# Read this data set into R and report the sum of the numbers in the fourth of the nine columns.
# https://d396qusza40orc.cloudfront.net/getdata%2Fwksst8110.for
# Original source of the data: http://www.cpc.ncep.noaa.gov/data/indices/wksst8110.for
# (Hint this is a fixed width file format)
# 
# 28893.3
# 222243.1
# 35824.9
# 32426.7
# 101.83
# 36.5


