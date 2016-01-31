Tidy data for the Samsung Galaxy S smartphone accelerometer project
==========

This 'Assignment' directory contains the following files:

* [README.md] (./README.md) - this file
* [UCI HAR Dataset] (./UCI HAR Dataset) - the source data for this project
* [tidy_data.txt] (./tidy_data.txt) - the tidy data for this project
* [run_analysis.R] (./run_analysis.R) - the R script that produced the tidy data from the source data
* [Codebook.md] (./Codebook.md) - The Codebook describing the source and tidy data sets and the analysis

## How to run this project

Download this [Assignment] (./) directory and its contents. Open up R (e.g. inside RStudio), set your working directory to the `Assignment` directoy, and run the `run_analysis.R` script:
```
setwd('Assignment')
source('run_analysis.R')
```
View the tidy data set, either in a text editor, or using `View()` within RStudio like this:
```
tidy_df <- read.table('tidy_data.txt', header=TRUE)
View(tidy_df)
```

Please refer to the [Codebook] (./Codebook.md) for a brief explanation of the data and its analysis.
