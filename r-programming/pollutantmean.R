##
#   Script:  pollutantmean.R
#   Author:  Dennis Barger
#   Date:    6/12/14
#
#   Description
#   Calculate the mean value of specific pollutant acros a specified number of monitors
#
#   Arguments:
#    - directory = name of subdirectory within R working directory containing monitor files
#    - pollutant = sulfate or nitrate
#    - id = integer vector containg monitors to retrieve
#
#   Dataset:
#   - specdata:  attributes include Date, sulfate, nitrate, ID

# mergefiles function reads all files in specific directory and loads data into data frame.
# It assumes the volume of file values is not significant.
mergefiles <- function(directory) {
    
    dirpath <- gsub(" ", "", paste("./",directory, "/"))
    filelist <- list.files(dirpath)
    
    for(i in 1:332) {
        filevalues <- read.csv(gsub(" ", "", paste(dirpath, filelist[i])))
        if(i==1) {
            allvalues <- filevalues
        } else {
            allvalues <- rbind(allvalues, filevalues)
        }
    } 
    return(allvalues)
};

pollutantmean <- function(directory, pollutant, id = 1:332) {
 
#   Prepare data:
#   - load values from all files into a data frame (results)
#   - remove NA values from data frame
    results <- mergefiles(directory)
    data <- results[(!is.na(results[[pollutant]])),]
    
#   Calculate mean
#   - subset data frame based on id argument
#   - calculate mean based on pollutant argument and return value
    if(min(id) == max(id)) {
        data <- data[data$ID == id,]
    } else {
        data <- data[data$ID >= min(id) & data$ID <= max(id),]
    }

    val <- round(mean(data[[pollutant]]), digits=3)
    return(val)
    
};