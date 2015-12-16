corr <- function(directory, threshold = 0) {
        ## 'directory' is a character vector of length 1 indicating
        ## the location of the CSV files

        ## 'threshold' is a numeric vector of length 1 indicating the
        ## number of completely observed observations (on all
        ## variables) required to compute the correlation between
        ## nitrate and sulfate; the default is 0

        ## Return a numeric vector of correlations
        ## NOTE: Do not round the result!

        # get all the filenames in directory, and create a list of data frames for them
        filenames <- list.files(directory, pattern="*.csv", full.names=TRUE)
		ldf <- lapply(filenames, read.csv)

		# this is the correlation vector that we will be returning
		correlation_vector <- numeric(0)

		# loop through all files
		for (df in ldf) {
			# if the number of complete cases is greater than the threshold, compute the corrlation and append it to the correlation vector
			df_complete_cases <- df[complete.cases(df),]
			if (nrow(df_complete_cases) > threshold) {
				correlation <- cor(df_complete_cases$sulfate, df_complete_cases$nitrate)
				correlation_vector <- append(correlation_vector, correlation)
			}
		}

		correlation_vector
}