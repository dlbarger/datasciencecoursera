##
#   Script:  corr.R
#   Author:  Dennis Barger
#   Date:    6/15/14
#
#   Description
#   Calculate the correlation between sulfates and nitrates for all monitor files within the
#   a specific directory.  Only include completely observed cases on all variables where the
#   count of observed cases is greater than the threshold argument
#
#   Arguments:
#    - directory = name of subdirectory within R working directory containing monitor files
#    - threshold = number of completely observed cases to analyze in the function
#
#   Return Value:
#   - vector of correlations for monitors meeting the threshold requirement.
#     If no monitors meet the requirement then return a numeric vector length = 0
#
#   Dataset:
#   - specdata:  attributes include Date, sulfate, nitrate, ID

corr <- function(directory, threshold = 0) {
    
#   Use complete() to get a data frame of all monitors and count of complete cases. 
#   Subset the data frame to exclude monitors with case counts less than or equal to the threshold
    cases <- complete(directory, 1:332)
    cases <- cases[cases$nobs > threshold,]
    ids <- vector("numeric", nrow(cases))
    ids <- cases$id
    ids <- ids[!is.na(ids)]
        
#   Use monitor ID vector and create a data frame of monitor ID, sulfate and nitrate values:

#   Build file list
    output <- vector("numeric", length=0)
    dirpath <- gsub(" ", "", paste("./", directory, "/"))
    lst <- list.files(dirpath)

    for(i in ids) {
        values <- read.csv(gsub(" ", "", paste(dirpath, lst[i])))  
        corval <- round(cor(values$sulfate, values$nitrate, use="complete.obs"), digits=5)
        output <- c(output, corval)
    }
    return(output)
}