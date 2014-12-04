##############################################################################
#
#   Script: plot3.R
#   Author: dbarger
#   Date:   8/23/14
#
#   Description:
#   Answer the following question:  "Of the four types of sources indicated by the "type"
#   (point,nonpoint,onroad,nonroad) variable, which of these four sources have seen decreases
#   in emissions from 1999 - 2008 for Baltimore city?  Which have seen increases in emissions
#   from 1999-2009?"
#
#   Special Note:  Use ggplot2 for answerinvg questions.
#
#   Data Source:
#   - EPA National Emissions Inventory
#   - Source location: https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2FNEI_data.zip
#   - Contains two files: 
#       - PM2.5 Emissions Data (summarySCC_PM25.rds)
#       - Source Classification Code Table (Source_Classification_Code.rds)
#


###################################################################################
#   Supporting functions
###################################################################################

getfile <- function(url, directory, srcfile) {

        if(!file.exists(directory)) {
            dir.create(directory)
        }
        
        #setwd(paste("./",directory,sep=""))
        if(!file.exists(srcfile)) {
            download.file(url,destfile=srcfile)
            unzip(srcfile)
        }
}

readRDSFile <- function(file) {
    
    if(file.exists(file)) {
        df <- readRDS(file)
    } else {
        df <- paste(file, ":  file missing")
    }
    return(df)
}

################################################################################
#   Main Logic for building trend chart
###############################################################################

#   Get data for chart using supporting functions

url <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2FNEI_data.zip"
getfile(url,"pm","nei_data.zip")
ems <- readRDSFile("summarySCC_PM25.rds")
scc <- readRDSFile("Source_Classification_Code.rds")

#   Aggregate emission counts by year
ems <- ems[ems$fips=="24510",]
df <- aggregate(Emissions ~ year + type, data=ems, mean)
df$Emissions <- round(df$Emissions,2)
df$year <- factor(df$year)

#   Create trend chart and display emission counts in millions
par(mar=c(5,5,5,5))

ggplot(data=df, aes(x=year,y=Emissions)) +
    geom_bar(stat="identity") +
    facet_grid(. ~ type) +
    xlab("Year") + ylab("Average Emissions") +
    ggtitle("Average Yearly Baltimore Emissions")

#   Copy chart to file
dev.copy(png, file="plot3.png")
dev.off()


