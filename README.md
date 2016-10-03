# GettingAndCleaningDataCourseProject
# This is the readme file for the run_analysis.R script for this project.

Script Objectives:
Download the data collected from the accelerometers from the Samsung Galaxy S smartphone and prepare tidy data that can be used for later analysis.
The data is at https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip

Script Detals:
The run_analysis.R does the following tasks:
1. Download the project data.
2. Extracts only the measurements on the mean and standard deviation for each measurement.
3. Merges the training and the test sets to create one data set.
4. Uses descriptive activity names to name the activities in the data set
5. Labels the data set with descriptive variable names.
6. From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.
7. Save the dataset to a text file
