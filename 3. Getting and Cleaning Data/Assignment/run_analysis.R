# Instructions
#
# The purpose of this project is to demonstrate your ability to collect, work with, and clean a data set.
#
# Review criteria: 
# The submitted data set is tidy.
# The Github repo contains the required scripts.
# GitHub contains a code book that modifies and updates the available codebooks with the data to indicate
# all the variables and summaries calculated, along with units, and any other relevant information.
# The README that explains the analysis files is clear and understandable.
# The work submitted for this project is the work of the student who submitted it.
#
# Getting and Cleaning Data Course Project 
# The purpose of this project is to demonstrate your ability to collect, work with, and clean a data set.
# The goal is to prepare tidy data that can be used for later analysis. You will be graded by your peers on
# a series of yes/no questions related to the project. You will be required to submit:
# 1) a tidy data set as described below,
# 2) a link to a Github repository with your script for performing the analysis, and
# 3) a code book that describes the variables, the data, and any transformations or work that you performed
# to clean up the data called CodeBook.md.
# You should also include a README.md in the repo with your scripts.
# This repo explains how all of the scripts work and how they are connected.
#
# One of the most exciting areas in all of data science right now is wearable computing - see for example
# this article . Companies like Fitbit, Nike, and Jawbone Up are racing to develop the most advanced
# algorithms to attract new users. The data linked to from the course website represent data collected from
# the accelerometers from the Samsung Galaxy S smartphone. A full description is available at the site where
# the data was obtained:
#
# http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones
#
# Here are the data for the project:
#
# https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip
#
# You should create one R script called run_analysis.R that does the following.
#
# Merges the training and the test sets to create one data set.
# Extracts only the measurements on the mean and standard deviation for each measurement.
# Uses descriptive activity names to name the activities in the data set
# Appropriately labels the data set with descriptive variable names.
# From the data set in step 4, creates a second, independent tidy data set with the average of each variable
# for each activity and each subject.
# Good luck!


# Organization of the source data:

# The 'UCI HAR Dataset' directory contains the source data
# The 'train/' and 'test/' directories contain the training and test data sets
# There are 7352 rows in 'train/subject_train.txt'. Each row has one int from 1:30 representing a subject
# There are 7352 rows in 'train/Y_train.txt'. Each row has one int from 1:5 = representing an activity [WALKING, LYING, etc.]
# There are 7352 rows in 'train/X_train.txt'. Each row has 561 floats representing the features
# The 'test/'' data set is organized similarly

# Reading in the source data

# URL of the zip file containing the data
zip_file_url <- 'https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip'
zip_file_name <- 'UCI HAR Dataset.zip'

# The directory that the zip file should be unzipped to
dir <- './UCI HAR Dataset'

# If the directory does not already exist, download the zip file and extract it to the directory
if (!file.exists(dir)) {
	dir.create(dir)
	# use method='curl' if on a Mac, skip it if on Windows
	if (.Platform$OS.type == "windows") {
		download.file(zip_file_url, destfile=zip_file_name)
	} else {
		download.file(zip_file_url, destfile=zip_file_name, method='curl')
	}
	unzip(zip_file_name)
}

# Set up the various file names that we will be reading from
dir_sep <- '/'
feature_names_file <- paste(dir, 'features.txt', sep=dir_sep) # 561 feature names
activity_names_file <- paste(dir, 'activity_labels.txt', sep=dir_sep) # 6 activity names
train_subject_file <- paste(dir, 'train/subject_train.txt', sep=dir_sep) # 7352 training observations, 21 different subjects
train_features_file <- paste(dir, 'train/X_train.txt', sep=dir_sep) # 7352 training observations, 561 features
train_activity_file <- paste(dir, 'train/y_train.txt', sep=dir_sep) # 7352 training observations, 6 activities
test_subject_file <- paste(dir, 'test/subject_test.txt', sep=dir_sep) # 7352 test observatinos, 9 different subjects
test_features_file <- paste(dir, 'test/X_test.txt', sep=dir_sep) # 7352 test observations, 561 features
test_activity_file <- paste(dir, 'test/y_test.txt', sep=dir_sep) # 7352 test observations, 6 activities
tidy_data_file <- 'tidy_data.txt'

# Get the feature names from the second column in this file
feature_names_df <- read.table(feature_names_file, stringsAsFactors=FALSE, col.names=c('index', 'name'))
feature_col_names <- feature_names_df$name

# Read in descriptive names for the activity values (note: using factors for activities, could also use strings)
activity_names_df <- read.table(activity_names_file, stringsAsFactors=TRUE, col.names=c('index', 'name'))
activity_names <- activity_names_df$name

# Set up column names for the subject and activity columns
subject_col_name <- 'Subject'
activity_col_name <- 'Activity'

# Read in the training data, label the columns, cbind everything into a training dataframe
train_subject_df <- read.table(train_subject_file, col.names = c(subject_col_name))
train_activity_df <- read.table(train_activity_file, colClasses='integer', col.names=c(activity_col_name))
train_features_df <- read.table(train_features_file, colClasses='numeric', col.names=feature_col_names, check.names=FALSE)
train_df <- cbind(train_subject_df, train_activity_df, train_features_df)

# Read in the test data in a similar manner
test_subject_df <- read.table(test_subject_file, col.names = c(subject_col_name))
test_activity_df <- read.table(test_activity_file, colClasses = 'integer', col.names = c(activity_col_name))
test_features_df <- read.table(test_features_file, colClasses='numeric', col.names=feature_col_names, check.names=FALSE)
test_df <- cbind(test_subject_df, test_activity_df, test_features_df)

# rbind the training and test data into a combined dataframe
combined_df <- rbind(train_df, test_df)

# replace the int values in the activity column with their corresponding descriptive names (factors)
combined_df[,activity_col_name] <- sapply(combined_df[,activity_col_name], function(x) activity_names[x])

# get the subset of column names that contains mean and stds (ie that have 'mean()' or 'std()' in them)
mean_std_cols <- feature_col_names[grep('mean\\(\\)|std\\(\\)', feature_col_names)]

# select only the mean and std columns from the conbined dataframe, retaining the 'subject' and 'activity' columns on the ends
mean_std_df <- combined_df[, c(subject_col_name, activity_col_name, mean_std_cols)]

# Create the tidy data set

# create tidy data set containing the average of each feature for each activity and each subject
library(dplyr)
tidy_averages_df <- mean_std_df %>% group_by(Subject, Activity) %>% summarize_each(funs(mean))

# tidy the column names by deleting parens, replacing dashes with underscores, expanding abbreviations
tidy_col_names <- colnames(tidy_averages_df)
tidy_col_names <- gsub('-', '_', tidy_col_names) # replace dashes with underscores
tidy_col_names <- gsub('\\(\\)', '', tidy_col_names) # delete parens
tidy_col_names <- sub('^t', 'TimeDomain_', tidy_col_names) # expand abbreviations
tidy_col_names <- sub('^f', 'FrequencyDomain_', tidy_col_names)
tidy_col_names <- sub('_mean', '_Mean', tidy_col_names)
tidy_col_names <- sub('_std', '_StandardDeviation', tidy_col_names)
tidy_col_names <- sub('_X', '_X_Axis', tidy_col_names)
tidy_col_names <- sub('_Y', '_Y_Axis', tidy_col_names)
tidy_col_names <- sub('_Z', '_Z_Axis', tidy_col_names)
tidy_col_names <- sub('Acc', 'Accelerometer', tidy_col_names)
tidy_col_names <- sub('Gyro', 'Gyroscope', tidy_col_names)
tidy_col_names <- sub('Mag', 'Magnitude', tidy_col_names)
colnames(tidy_averages_df) <- tidy_col_names

# write the tidy data to a txt file 
write.table(tidy_averages_df, file=tidy_data_file, row.name=FALSE, append=FALSE)
