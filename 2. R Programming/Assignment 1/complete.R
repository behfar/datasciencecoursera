complete <- function(directory, id = 1:332) {
        ## 'directory' is a character vector of length 1 indicating
        ## the location of the CSV files

        ## 'id' is an integer vector indicating the monitor ID numbers
        ## to be used
        
        ## Return a data frame of the form:
        ## id nobs
        ## 1  117
        ## 2  1041
        ## ...
        ## where 'id' is the monitor ID number and 'nobs' is the
        ## number of complete cases

        # this is how many rows our data frame will have at the end
        num_files <- length(id)

        # filenames are padded with "0"s
        filename_example <- "001.csv"
        filename_padded_length <- nchar(filename_example)

        # import stringr library so we can call str_pad
        library(stringr)
        
        # preallocate two columns, which will be cbound together at the end to get our data frame
        filenames <- character(num_files)
        complete_cases <- integer(num_files)

        # populate the two columns for each file 
        cur_row <- 1
        for (this_id in id) {
                # add ".csv" to the file name, pad it with "0"s, and add the directory
                filename_unpadded <- paste(this_id, ".csv", sep="")
                filename <- str_pad(filename_unpadded, filename_padded_length, pad="0")
                filepath <- file.path(directory, filename)
                # read the file and calculate how many complete cases it has
                data <- read.csv(filepath, header=TRUE)
                num_complete_cases <- sum(complete.cases(data))
                # populate the two columns
                filenames[cur_row] <- this_id
                complete_cases[cur_row] <- num_complete_cases
                cur_row <- cur_row + 1
        }

        # return the two columns as a data frame, with appropriate column names
        cbind(data.frame(id=filenames), data.frame(nobs=complete_cases))
}