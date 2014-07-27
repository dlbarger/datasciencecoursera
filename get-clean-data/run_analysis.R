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
#   - Desired feature measurements = Body Acceleration Mean x,y,z

data <- read.table("features.txt", header=FALSE)
measures <- data[1:3,2] 
ActivityLabel <- read.table("activity_labels.txt", header=FALSE)


## Build modified training data set
#
# Data transformations
colSubject <- read.table("./train/subject_train.txt", header=FALSE)
ActivityId <- read.table("./train/y_train.txt", header=FALSE)
names(ActivityId) <- c("id")
names(ActivityLabel) <- c("id","activity")
colActivity <- merge(ActivityId, ActivityLabel, by="id")

# Create final training data set
#   - Subset training data is only include desired feature measurements.
#   - Add subject and activity to data set
data <- read.table("./train/x_train.txt", header=FALSE)
dataset <- data[,measures]
trainset <- cbind(colSubject, colActivity, dataset)
names(trainset) <- c("SubjectId","ActivityId","ActivityDescr","XBodyAccMean","YBodyAccMean","ZBodyAccMean")


## Build modified test data set
#
# Data transformations
colSubject <- read.table("./test/subject_test.txt", header=FALSE)
ActivityId <- read.table("./test/y_test.txt", header=FALSE)
names(ActivityId) <- c("id")
names(ActivityLabel) <- c("id","activity")
colActivity <- merge(ActivityId, ActivityLabel, by="id")

# Create final test data set
#   - Subset test data based on feature measurements and add columns
data <- read.table("./test/x_test.txt", header=FALSE)
dataset <- data[,measures]
testset <- cbind(colSubject, colActivity, dataset)
names(testset) <- c("SubjectId","ActivityId","ActivityDescr","XBodyAccMean","YBodyAccMean","ZBodyAccMean")


## Merge final data sets intos one
#   - For Body Acceleration measurements train and test data are unique sets.
#   - Write finalset data frame to csv file for upload.
finalset <- rbind(trainset, testset)
write.csv(finalset, file="run_analysis_output_v1.csv", row.names=FALSE)

## Create second, independent tidy data set with averages by subject and activity
x <- aggregate(XBodyAccMean ~ SubjectId + ActivityId + ActivityDescr, FUN=mean, data=finalset)
y <- aggregate(YBodyAccMean ~ SubjectId + ActivityId + ActivityDescr, FUN=mean, data=finalset)
z <- aggregate(ZBodyAccMean ~ SubjectId + ActivityId + ActivityDescr, FUN=mean, data=finalset)

t <- merge(x,y, by=c("SubjectId","ActivityId","ActivityDescr"))
t <- merge(t,z, by=c("SubjectId","ActivityId","ActivityDescr"))

write.csv(t, file="run_analysis_output_v2.csv", row.names=FALSE)

## Clean up
rm(finalset)
rm(dataset)
rm(data)
rm(ActivityId)
rm(ActivityLabel)
rm(colActivity)
rm(colSubject)
rm(testset)
rm(trainset)
