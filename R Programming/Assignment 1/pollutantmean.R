pollutantmean <- function(directory, pollutant, id = 1:332) {
        ## 'directory' is a character vector of length 1 indicating
        ## the location of the CSV files

        ## 'pollutant' is a character vector of length 1 indicating
        ## the name of the pollutant for which we will calculate the
        ## mean; either "sulfate" or "nitrate".

        ## 'id' is an integer vector indicating the monitor ID numbers
        ## to be used

        ## Return the mean of the pollutant across all monitors list
        ## in the 'id' vector (ignoring NA values)
        ## NOTE: Do not round the result!

        # length of CSV filenames, which are all "0" padded
        filename_example <- "001.csv"
        filename_length <- nchar(filename_example)

        # pull in stringr lib to use str_pad for padding filename strings with leading "0"s
        library(stringr)
        
        #create an empty data frame with the four columns needed
        df <- data.frame(Date=character(), sulfate=numeric(), nitrate=numeric(), ID=numeric())

        # read each file and rbind it to the data frame
        for (this_id in id) {
                filename_unpadded <- paste(this_id, ".csv", sep="")
                filename <- str_pad(filename_unpadded, filename_length, pad="0")
                file <- file.path(directory, filename)
                data <- read.csv(file, header=TRUE)
                df <- rbind(df, data)
        }

        # return the mean of the pollutant column, with NA's removed
        mean(df[[pollutant]], na.rm=TRUE)
}