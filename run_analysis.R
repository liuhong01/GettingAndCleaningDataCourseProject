######################################################################
#                                                                    #
# Script for Getting and Cleaning Data Course Project run_analysis.R #
#                                                                    #
######################################################################
#
# This script does the following:
# 1. Download the project data.
# 2. Extracts only the measurements on the mean and standard deviation for each measurement.
# 3. Merges the training and the test sets to create one data set.
# 4. Uses descriptive activity names to name the activities in the data set
# 5. Labels the data set with descriptive variable names.
# 6. From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.
# 7. Save the dataset to a text file
#
# Load libraries required
library(plyr)
library(reshape2)

# Step 1: Get data
#
# Download and unzip the dataset
projectfilename <- "project_dataset.zip"
if (!file.exists("UCI HAR Dataset")) 
{
    if (!file.exists(projectfilename))
    {
        fileURL <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip "
        download.file(fileURL, projectfilename, mode = "wb")
        unzip(projectfilename,exdir=".")
    }
    
    unzip(projectfilename,exdir=".")
}

# Step 2: Extract Data
#
# Load features
features <- read.table("UCI HAR Dataset/features.txt")
features[,2] <- as.character(features[,2])

# Extract only the data on mean and standard deviation
selected.features <- grep(".*mean.*|.*std.*", features[,2])
selected.features.names <- features[selected.features,2]

# Modify the feature names to more reader friendly form
selected.features.names <- gsub('-mean', '.Mean.', selected.features.names)
selected.features.names <- gsub('-std', '.Std.', selected.features.names)
selected.features.names <- gsub('[-()]', '', selected.features.names)


selected.features.names <- gsub('-mean', '.Mean.', selected.features.names)
selected.features.names <- gsub('-std', '.Std.', selected.features.names)
selected.features.names <- gsub('[-()]', '', selected.features.names)



# Step 3: Load datasets
#
# Load train dataset
train <- read.table("UCI HAR Dataset/train/X_train.txt")[selected.features]
train.activities <- read.table("UCI HAR Dataset/train/Y_train.txt")
train.subjects <- read.table("UCI HAR Dataset/train/subject_train.txt")
train <- cbind(train.subjects, train.activities, train)

# Load test dataset
test <- read.table("UCI HAR Dataset/test/X_test.txt")[selected.features]
test.activities <- read.table("UCI HAR Dataset/test/Y_test.txt")
test.subjects <- read.table("UCI HAR Dataset/test/subject_test.txt")
test <- cbind(test.activities, test.activities, test)

# Step 4: Merge datasets
my.data <- rbind(train, test)
colnames(my.data) <- c("subject", "activity", selected.features.names)

# Step 5: Label the final dataset
#
# Load activity labels
activity.labels <- read.table("UCI HAR Dataset/activity_labels.txt")
activity.labels[,2] <- as.character(activity.labels[,2])

# Factorize activities and subjects
my.data$activity <- factor(my.data$activity, levels = activity.labels[,1], labels = activity.labels[,2])
my.data$subject <- as.factor(my.data$subject)

# Step 6: Create tidy dataset
#
# Create a tidy data set with the average of each variable for each activity and each subject.
my.data.melted <- melt(my.data, id = c("subject", "activity"))
my.data.mean <- dcast(my.data.melted, subject + activity ~ variable, mean)

# Step 7: Save data to a a text file
write.table(my.data.mean, "tidy.txt", row.names = FALSE)

# END




