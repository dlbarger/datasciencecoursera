#########################
#   Script: caret-example.R
#   Author: Coursera
#   Date:   3/11/15
#
#   Comments:
#   Example taken from class "Practical Machine Learning"
#

library(caret)
library(kernlab)
data(spam)

## Use the createDataPartition function to sample 75% of the spam$type data.
## Using list=FALSE forces the function to return data in a matrix
inTrain <- createDataPartition(y=spam$type, p=0.75, list=FALSE)

## The createDataPartition function creates a list of pointers stored in a matrix.
## This matrix (or list if list=TRUE) can be used to filter the spam data frame by spam$type
##similar to using a c() function.
training <- spam[inTrain,]

## The other 25% of data can stored in another data frame called "testing" using the
## following command.
testing <- spam[-inTrain,]
dim(training)

## Now let's fit a model using functiosn from the caret package
##
set.seed(32343)
modelFit <- train(type ~.,data=training,method="glm")
modelFit