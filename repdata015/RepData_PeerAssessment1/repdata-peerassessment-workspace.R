#############################################################################################
#
#   Script:     repdata-peerassessment-workspace.R
#   Author:     Dennis Barger
#   Date:       6/12/2015
#   Purpose;
#   Workspace for Coursera Reproduible Research Peer Assessment 1 (RepData=015)
#
#   Assignment:
#   - Load and preprocess Activity data
#   - Calculate mean total number of steps taken per day.
#       - Calculate total steps per day
#       - Make histogram of total steps per day
#   - Identify the average daily activity pattern
#       - Make time series plot of 5 minute interval (x axis) and avg
#         steps taken, averaged across all days (Y axis)
#       - Which 5 minute interval on average across all days contains
#         maximum number of steps?
#   - Impute missing values
#       - Calculate total missing values
#       - Devise strategy for imputing value for missing values such as 
#         using mean/median for each day or mean of 5 minute interval
#       - Create new dataset (data frame) with imputed values
#       - Make histogram of total steps per day using new dataset and calcualte mean 
#         and median total steps take per day.  Determine if the values difer from
#         similar measurements on original dataset.
#   - Are there differences in activity patterns between weekdays and weekends?
#       - Use weekdays() function and dataset with imputed values
#       - Create new factor variable in new dataset with two levels:  weekday and weekend
#       - Make panel plot using time series plot of 5 minute interval (X) and avg steps
#         taken, average across all weekday days or weekend days (y)
#
#   Dataset (Activity):
#   - steps = number of steps taken in 5 minute interval
#   - date = date measurement was taken in YYYY-MM-DD format
#   - interval = identifer for 5 minute interval in which measurement was taken
##############################################################################################

##############################################################################################
#   Load and preprocess activity data
##############################################################################################
setwd("c:\\get-repos\\datasciencecoursera\\repdata015\\RepData_PeerAssessment1")
df <- read.csv("activity.csv",sep=",")
df$date <- as.Date(df$date)

##############################################################################################
#   What is mean total number of steps taken per day?
#   - Build table of total steps per  i.e. aggregate()
#   - Build histogram using table data
#   - Calculate mean and median from table
#
#   ** Remove records from data frame where df$steps value is NA
##############################################################################################
require(ggplot2)
library(ggplot2)

dat <- df[!is.na(df$steps),]
tbl <- aggregate(steps ~ date, data=df, sum)
cht <- qplot(tbl$steps, 
             geom="histogram",
             binwidth=1000, 
             main="Frequency of Total Steps Per Day",
             xlab="Total Steps Per DaY",
             ylab="Count of Days",
             fill=I("blue"),
             col=I("white"))
cht

mean_steps <- mean(tbl$steps)
median_steps <- median(tbl$steps)

#############################################################################################
#   What is the average daily activity pattern?
#############################################################################################
rm(tbl)
tbl <- aggregate(steps ~ interval, data=dat, FUN = mean)
plot(x=tbl$interval, y=tbl$steps, type="l", main="Average Daily Activity", xlab="5 Minute Intervals", ylab="Average Daily Steps")

x <- tbl[which.max(tbl$steps),]
max.interval <- x$interval
interval.val <- x$steps

#############################################################################################
#   Imput missing values
#   - Impute Strategy:  Use median value for same interval across all days.
#     Create data frame with median value per interval across all days then merge
#     original data frame with data frames of imputer values.
#############################################################################################


