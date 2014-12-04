##
#   Script:     run_analysis.R
#   Author:     Dennis Barger
#   Date:       7/25/14
#   Purpose:    getdata-005 course project
#
#   Objectives:
#   - Merge training and test files to create one data set
#   - Extract mean and std deviation features for each measurement
#   - Use descriptive activity names for features
#   - Label data set with descriptive variable names
#   - Create second, indepdent tidy data set with avg for each
#     variable for each activity and each subject

#   Identify all mean and std deviation features using feature.txt file

setwd("c:\\workspace\\data\\getdata-005\\UCI HAR Dataset")

## Create common lookup values
#
# Create desired list of features
data <- read.table("features.txt", header=FALSE)
vars <- rbind(data[grep("mean", data[,2]),], data[grep("std", data[,2]),])
measures <- c(vars$V1)
# Create activity labels
ActivityLabel <- read.table("activity_labels.txt", header=FALSE)
measures <- vars[1:3,2]

## Build modified training data set
#
# Data transformations
colSubject <- read.table("./train/subject_train.txt", header=FALSE)
ActivityId <- read.table("./train/y_train.txt", header=FALSE)
names(ActivityId) <- c("id")
names(ActivityLabel) <- c("id","activity")
colActivity <- merge(ActivityId, ActivityLabel, by="id")

# Create final training data set
#   - Read training data
data <- read.table("./train/x_train.txt", header=FALSE)
#   - subset data frame to only include desired features
dataset <- data[,measures]
#   - Build final dataset combining subjects, activities and training data
trainset <- cbind(colSubject, colActivity, dataset)

## Build modified test data set
#
# Data transformations
colSubject <- read.table("./test/subject_test.txt", header=FALSE)
ActivityId <- read.table("./test/y_test.txt", header=FALSE)
names(ActivityId) <- c("id")
names(ActivityLabel) <- c("id","activity")
colActivity <- merge(ActivityId, ActivityLabel, by="id")

# Create final test data set
#   - Read training data
data <- read.table("./test/x_test.txt", header=FALSE)
#   - subset data frame to only include desired features
dataset <- data[,measures]
#   - Build final dataset combining subjects, activities and training data
testset <- cbind(colSubject, colActivity, dataset)

## Merge final data sets into one
finalset <- merge(trainset, testset, )


