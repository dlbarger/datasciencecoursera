##  Coursera R Programming
#   rprog week 3 programming assignment
#
#   Script: rankhospital.R
#   Author: Dennis Barger
#   Date:   6/28/14
#
#   Arguments:
#   - state:    2 character state abbreviation
#   - outcome:  values include "heart attack", "heart failure", "pneumonia"
#   - num:      best, worst or integer representing desired ranking (lowest is best)
#
#   Return (character vector): 
#   - hospital.name value

rankhospital <- function(state, outcome, num = "best") {
    
    ##  load data frame with data from outcome file
    data <- read.csv("outcome-of-care-measures.csv", na.strings="Not Available", stringsAsFactors = FALSE)
    
    ##  validate arguments passed into function
    #   check state argument
    
    lst <- unique(data[["State"]])
    if(is.na(match(state,lst))) {
        stop("invalid state")
    }
    
    #   check outcome argument
    #   - "Hospital.30.Day.Death..Mortality..Rates.from.Heart.Attack"
    #   - "Hospital.30.Day.Death..Mortality..Rates.from.Heart.Failure"
    #   - "Hospital.30.Day.Death..Mortality..Rates.from.Pneumonia"
    outcome <- tolower(outcome)
    if (outcome == "heart attack") {
        val <- "Hospital.30.Day.Death..Mortality..Rates.from.Heart.Attack"
    } else if (outcome == "heart failure") {
        val <- "Hospital.30.Day.Death..Mortality..Rates.from.Heart.Failure"
    } else if (outcome == "pneumonia") {
        val <- "Hospital.30.Day.Death..Mortality..Rates.from.Pneumonia"
    } else {
        stop("invalid outcome")
    }
    
    ##  calculate min(30 day rate) and return character vector with hospital nameb 
    results <- subset(data, State==state, select=c("Hospital.Name", val))
    results <- results[complete.cases(results),]
    results <- results[ order(results[,2],results[,1]),]
    
    if (num == "best") {
        rank <- 1
    } else if (num == "worst") {
        rank <- nrow(results)
    } else {
        rank <- num
    }
    
    return(results[rank,1])
}