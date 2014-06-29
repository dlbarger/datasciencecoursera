##  Coursera
##  R Programming - Assignment Week 3
#
#   Author: Dennis Barger
#   Date:   6/28/14

##  Assignment #1
#   30-day Mortality Rates for Heart Attack histogram

data <- "outcome-of-care-measures.csv";
outcome <- read.csv(data, colClasses = "character");
head(outcome);

outcome[,11] <- as.numeric(outcome[,11])
hist(outcome[,11])
