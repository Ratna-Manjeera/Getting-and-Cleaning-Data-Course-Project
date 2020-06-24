

Getting And Cleaning Data Course Project: README
Author: Francisco Moya
Date: 23/06/2020
==================================================================



This dataset is a tidy version of the original dataset provided in the Getting And
Cleaning Data Course, a course that is part of the Data Science Specialization in
Coursera, teached by the John Hopkins University.

The original dataset was collected from a group of 30 volunteers within an age range of 19-48 years.
Each person performed six activities (WALKING, WALKING_UPSTAIRS, WALKING_DOWNSTAIRS, SITTING, STANDING, LAYING)
wearing a smartphone (Samsung Galaxy S II) on the waist. Using its embedded accelerometer and gyroscope, they
captured 3-axial linear acceleration and 3-axial angular velocity at a constant rate of 50Hz. After that,
the obtained dataset was randomly partitioned into two sets,
where 70% of the volunteers was selected for generating the training data and 30% the test data
(Reyes-Ortiz et al., n.d).

In this project i followed the instructions of the project to create a nwe tidy dataset from the original, the instructions
were:
"...create one R script called run_analysis.R that does the following.

1.Merges the training and the test sets to create one data set.
2.Extracts only the measurements on the mean and standard deviation for each measurement.
3.Uses descriptive activity names to name the activities in the data set
4.Appropriately labels the data set with descriptive variable names.
5.From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject."

The variables in the tidy dataset are:
-subjectID: an identifier for each participant in the project.
-activitylabels: labels that identifies the different activities that the participants did (standing, sitting,
laying, walking, walking downstairs, walking upstairs).  
-the mean and standard deviation of each of the following Features:
tBodyAcc-XYZ
tGravityAcc-XYZ
tBodyAccJerk-XYZ
tBodyGyro-XYZ
tBodyGyroJerk-XYZ
tBodyAccMag
tGravityAccMag
tBodyAccJerkMag
tBodyGyroMag
tBodyGyroJerkMag
fBodyAcc-XYZ
fBodyAccJerk-XYZ
fBodyGyro-XYZ
fBodyAccMag
fBodyAccJerkMag
fBodyGyroMag
fBodyGyroJerkMag

For this project i took advantage of the functionalities of data.table
 The steps that i did are:

-Read all the different files in the original dataset (both train and test)
-Rename all variables  (both train and test)
-Change the values of the labels of the activities (both train and test)
-Bind the test and test datasets by rows
-Order the new dataset
-subset the new dataset using the column names
-Extract the values that are needed
-Compute the mean of each variable for each activity and subject
-Create a new dataset called "tidydata.txt"

It is highly recommended to use data.table to read and manipulate this dataset.
==================================================================
*Original dataset from : Human Activity Recognition Using Smartphones DatasetVersion 1.0
authors: Jorge L. Reyes-Ortiz, Davide Anguita, Alessandro Ghio, Luca Oneto.
