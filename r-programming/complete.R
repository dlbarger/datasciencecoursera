xdata##
#   Script:  complete.R
#   Author:  Dennis Barger
#   Date:    6/13/14
#
#   Description
#   Counts the number of complete cases for each monitor file.  Complete cases represent records
#   populated with a sulfate and nitrate value.
#
#   Arguments:
#    - directory = name of subdirectory within R working directory containing monitor files
#    - id = integer vector containg monitors to retrieve
#
#   Dataset:
#   - specdata:  attributes include Date, sulfate, nitrate, ID

complete <- function(directory, id=1:332) {
    
    output <- matrix(ncol=2, nrow=length(id))
    idx <- 1
    
    dirpath <- gsub(" ", "", paste("./",directory, "/"))
    filelist <- list.files(dirpath)
    
    for(i in id) {
        filevalues <- read.csv(gsub(" ", "", paste(dirpath, filelist[i])))
        data <- filevalues[(!is.na(filevalues$sulfate) & !is.na(filevalues$nitrate)),]
        
        if(nrow(data)>0) {
            output[idx,1] <- min(data$ID) 
            output[idx,2] <- nrow(data)
            idx <- idx + 1
        }
    } 
    colnames(output) <- c("id", "nobs")
    output <- data.frame(output)
    return(output)
};

