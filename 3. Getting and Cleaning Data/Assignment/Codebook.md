Codebook
==========

## The source data

The [UCI HAR Dataset] (./UCI HAR Dataset) was produced by Reyes-Ortiz et al. at [Smartlab] (http://www.smartlab.ws) in Genoa, Italy, and is available at this [URL] (https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip'). It contains measurements from experiments involving 30 subjects performing 6 different activities (WALKING, WALKING_UPSTAIRS, WALKING_DOWNSTAIRS, SITTING, STANDING, LAYING) while wearing a smartphone (Samsung Galaxy S II). The data represent measurements recorded using the embedded accelerometer and gyroscope of the smartphone. The data are randomly partitioned into a training set and a test set, for use in training machine learning models, with about 70% of the data selected for the training set and 30% the test set.

The accelerator and gyroscope data were obtained over a number of time windows, and for each time window a vector of features is provided in both time and frequency domains. The accelerometer data is separated into gravitational and body motion components. The data also includes computed features indicating mean and standard deviations of the measurements.

Each observation includes

* An identifier of the subject who carried out the experiment
* An activity label 
* Triaxial acceleration from the accelerometer and estimated body and gravity components
* Triaxial angular velocity from the gyroscope
* A 561-feature vector with time and frequency domain variables. 

The activity labels are
```
1 WALKING
2 WALKING_UPSTAIRS
3 WALKING_DOWNSTAIRS
4 SITTING
5 STANDING
6 LAYING
```

The training data (subject, activity, features) are stored in `train/subject_train.txt`, `train/y_train.txt`, and `train/X_train.txt` respectively, and the test data is similarly stored in `test/subject_test.txt`, `test/y_test.txt`, and `test/X_test.txt`.


## The tidy data (processed)

The tidy data in [tidy_data.txt] (./tidy_data.txt) was produced by the [run_analysis.R] (./run_analysis.R) script (described in detail below).

The tidy data consists of 180 observations grouped by 30 subjects (i.e. persons) and 6 activity types per subject (i.e. `'WALKING', 'STANDING', 'SITTING'`, etc).

Each row is a single observation. The first two columns are `Subject` and `Activity`. The remaining 66 columns are numeric values representing a set of averages, computed from a corresponding set of 66 variables in the source data.  Appendix A describes the columns of the tidy data in more detail, along with their corresponding variables in the source data.

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

Here is a summary of the 66 columns of the tidy data, along with the names of their corresponding variables from the source data.

The names of the tidy columns are based on the following components: 

* The `Subject` and `Activity` columns indicate the subject (i.e. person) who collected the data and the activity in which that person was engaged at the time.
* `TimeDomain` and `FrequencyDomain` indicate the data domain
* `Body` and `Gravity` indicate whether the measurement is attributed to body movement or gravity
* `Accelerometer` and `Gyroscope` indicate the measurement sensor
* `{XYZ}_Axis` indicates the measurement axis
* `Jerk` indicates whether the measurement is due to a jerk movement
* `Magnitude` indicates a computed magnitude without reference to a particular axis
* `Mean` and `StandardDeviation` indicate which statistical measure is presented

The following is a table of the tidy columns and their corresponding variables in the source data:

Tidy column name | Corresponding untidy column name
--- | ---
Subject | subject
Activity | y
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
TimeDomain_BodyAccelerometerJerkMagnitude_StandardDeviation | tBodyAccJerkMag-std()
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
