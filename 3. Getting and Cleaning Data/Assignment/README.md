Tidy data for the Samsung Galaxy S smartphone accelerometer project
==========

This 'Assignment' directory contains the following files:

* [README.md] (./README.md) - this file
* [UCI HAR Dataset] (./UCI HAR Dataset) - the untidy data for this project
* [tidy_data.txt] (./tidy_data.txt) - the tidy data for this project
* [run_analysis.R] (./run_analysis.R) - the R script that produced the tidy data from the untidy data

## The untidy data (source data)

The untidy data and all its variables are documented in the [UCI HAR Dataset] (./UCI HAR Dataset) directory.

## The tidy data (processed data)

The tidy data in [tidy_data.txt] (./tidy_data.txt) was produced by the [run_analysis.R] (./run_analysis.R) script (described in detail below).

The tidy data consists of 180 observations grouped by 30 subjects (i.e. persons) and 6 activity types per subject (i.e. 'WALKING', 'STANDING', 'SITTING', etc).

Each row is a single observation. The first two columns are 'Subject' and 'Activity'. The remaining 66 columns are numeric values representing a set of averages, computed from a corresponding set of 66 variables in the untidy data.  Appendix A lists the names of the 66 columns of the tidy data, along with the names of their corresponding variables in the untidy data.

## The R script that produced the tidy data

[run_analysis.R] (./run_analysis.R) is the R script that produced the tidy data from the untidy data. The following is a summary of the steps performed by this script.  The file itself contains more detailed comments.

1. Download and unzip the file containing the Samsung Galaxy S smartphone accelerometer untidy data
2. Read the training and test data sets from the untidy data and merge them into a combined data set
3. Extract the subjects, activities, and the measurements on the mean and standard deviation from the untidy data set
4. Create a separate tidy data set with the average of each extracted variable, grouped by subject and activity
5. Label the activities in the tidy data set with descriptive names
6. Rename the columns of the tidy data set with descriptive variable names
7. Export the tidy data set to the file [tidy_data.txt] (./tidy_data.txt)


## Appendix A:

Names of the 66 columns of the tidy data, along with the names of their corresponding variables from the untidy data.

Tidy column name | Corresponding untidy column name
Subject | subject
activity | y
TimeDomain_BodyAccelerometer_Mean_X_Axis | tBodyAcc-mean()-X
TimeDomain_BodyAccelerometer_Mean_Y_Axis | tBodyAcc-mean()-Y
TimeDomain_BodyAccelerometer_Mean_Z_Axis | tBodyAcc-mean()-Z
TimeDomain_BodyAccelerometer_StandardDeviation_X_Axis | tBodyAcc-std()-X
TimeDomain_BodyAccelerometer_StandardDeviation_Y_Axis | tBodyAcc-std()-Y
TimeDomain_BodyAccelerometer_StandardDeviation_Z_Axis | tBodyAcc-std()-Z
TimeDomain_GravityAccelerometer_Mean_X_Axis | tGravityAcc-mean()-X
TimeDomain_GravityAccelerometer_Mean_Y_Axis | tGravityAcc-mean()-Y
TimeDomain_GravityAccelerometer_Mean_Z_Axis | tGravityAcc-mean()-Z
TimeDomain_GravityAccelerometer_StandardDeviation_X_Axis | tGravityAcc-std()-X
TimeDomain_GravityAccelerometer_StandardDeviation_Y_Axis | tGravityAcc-std()-Y
TimeDomain_GravityAccelerometer_StandardDeviation_Z_Axis | tGravityAcc-std()-Z
TimeDomain_BodyAccelerometerJerk_Mean_X_Axis | tBodyAccJerk-mean()-X
TimeDomain_BodyAccelerometerJerk_Mean_Y_Axis | tBodyAccJerk-mean()-Y
TimeDomain_BodyAccelerometerJerk_Mean_Z_Axis | tBodyAccJerk-mean()-Z
TimeDomain_BodyAccelerometerJerk_StandardDeviation_X_Axis | tBodyAccJerk-std()-X
TimeDomain_BodyAccelerometerJerk_StandardDeviation_Y_Axis | tBodyAccJerk-std()-Y
TimeDomain_BodyAccelerometerJerk_StandardDeviation_Z_Axis | tBodyAccJerk-std()-Z
TimeDomain_BodyGyroscope_Mean_X_Axis | tBodyGyro-mean()-X
TimeDomain_BodyGyroscope_Mean_Y_Axis | tBodyGyro-mean()-Y
TimeDomain_BodyGyroscope_Mean_Z_Axis | tBodyGyro-mean()-Z
TimeDomain_BodyGyroscope_StandardDeviation_X_Axis | tBodyGyro-std()-X
TimeDomain_BodyGyroscope_StandardDeviation_Y_Axis | tBodyGyro-std()-Y
TimeDomain_BodyGyroscope_StandardDeviation_Z_Axis | tBodyGyro-std()-Z
TimeDomain_BodyGyroscopeJerk_Mean_X_Axis | tBodyGyroJerk-mean()-X
TimeDomain_BodyGyroscopeJerk_Mean_Y_Axis | tBodyGyroJerk-mean()-Y
TimeDomain_BodyGyroscopeJerk_Mean_Z_Axis | tBodyGyroJerk-mean()-Z
TimeDomain_BodyGyroscopeJerk_StandardDeviation_X_Axis | tBodyGyroJerk-std()-X
TimeDomain_BodyGyroscopeJerk_StandardDeviation_Y_Axis | tBodyGyroJerk-std()-Y
TimeDomain_BodyGyroscopeJerk_StandardDeviation_Z_Axis | tBodyGyroJerk-std()-Z
TimeDomain_BodyAccelerometerMagnitude_Mean | tBodyAccMag-mean()
TimeDomain_BodyAccelerometerMagnitude_StandardDeviation | tBodyAccMag-std()
TimeDomain_GravityAccelerometerMagnitude_Mean | tGravityAccMag-mean()
TimeDomain_GravityAccelerometerMagnitude_StandardDeviation | tGravityAccMag-std()
TimeDomain_BodyAccelerometerJerkMagnitude_Mean | tBodyAccJerkMag-mean()
TimeDomain_BodyAccelerometerJerkMagnitude_StandardDeviation				tBodyAccJerkMag-std()
TimeDomain_BodyGyroscopeMagnitude_Mean | tBodyGyroMag-mean()
TimeDomain_BodyGyroscopeMagnitude_StandardDeviation | tBodyGyroMag-std()
TimeDomain_BodyGyroscopeJerkMagnitude_Mean | tBodyGyroJerkMag-mean()
TimeDomain_BodyGyroscopeJerkMagnitude_StandardDeviation | tBodyGyroJerkMag-std()
FrequencyDomain_BodyAccelerometer_Mean_X_Axis | fBodyAcc-mean()-X
FrequencyDomain_BodyAccelerometer_Mean_Y_Axis | fBodyAcc-mean()-Y
FrequencyDomain_BodyAccelerometer_Mean_Z_Axis | fBodyAcc-mean()-Z
FrequencyDomain_BodyAccelerometer_StandardDeviation_X_Axis | fBodyAcc-std()-X
FrequencyDomain_BodyAccelerometer_StandardDeviation_Y_Axis | fBodyAcc-std()-Y
FrequencyDomain_BodyAccelerometer_StandardDeviation_Z_Axis | fBodyAcc-std()-Z
FrequencyDomain_BodyAccelerometerJerk_Mean_X_Axis | fBodyAccJerk-mean()-X
FrequencyDomain_BodyAccelerometerJerk_Mean_Y_Axis | fBodyAccJerk-mean()-Y
FrequencyDomain_BodyAccelerometerJerk_Mean_Z_Axis | fBodyAccJerk-mean()-Z
FrequencyDomain_BodyAccelerometerJerk_StandardDeviation_X_Axis | fBodyAccJerk-std()-X
FrequencyDomain_BodyAccelerometerJerk_StandardDeviation_Y_Axis | fBodyAccJerk-std()-Y
FrequencyDomain_BodyAccelerometerJerk_StandardDeviation_Z_Axis | fBodyAccJerk-std()-Z
FrequencyDomain_BodyGyroscope_Mean_X_Axis | fBodyGyro-mean()-X
FrequencyDomain_BodyGyroscope_Mean_Y_Axis | fBodyGyro-mean()-Y
FrequencyDomain_BodyGyroscope_Mean_Z_Axis | fBodyGyro-mean()-Z
FrequencyDomain_BodyGyroscope_StandardDeviation_X_Axis | fBodyGyro-std()-X
FrequencyDomain_BodyGyroscope_StandardDeviation_Y_Axis | fBodyGyro-std()-Y
FrequencyDomain_BodyGyroscope_StandardDeviation_Z_Axis | fBodyGyro-std()-Z
FrequencyDomain_BodyAccelerometerMagnitude_Mean | fBodyAccMag-mean()
FrequencyDomain_BodyAccelerometerMagnitude_StandardDeviation | fBodyAccMag-std()
FrequencyDomain_BodyBodyAccelerometerJerkMagnitude_Mean | fBodyBodyAccJerkMag-mean()
FrequencyDomain_BodyBodyAccelerometerJerkMagnitude_StandardDeviation | fBodyBodyAccJerkMag-std()
FrequencyDomain_BodyBodyGyroscopeMagnitude_Mean | fBodyBodyGyroMag-mean()
FrequencyDomain_BodyBodyGyroscopeMagnitude_StandardDeviation | fBodyBodyGyroMag-std()
FrequencyDomain_BodyBodyGyroscopeJerkMagnitude_Mean | fBodyBodyGyroJerkMag-mean()
FrequencyDomain_BodyBodyGyroscopeJerkMagnitude_StandardDeviation | fBodyBodyGyroJerkMag-std()
