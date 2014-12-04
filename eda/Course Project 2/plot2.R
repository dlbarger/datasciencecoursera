##############################################################################
#
#   Script: plot2.R
#   Author: dbarger
#   Date:   8/23/14
#
#   Description:
#   Answer the following question:  "Have total emissions from PM25 decreased in Baltimore 
#   City, Maryland (flips=="24510" from 1999 to 2008?")
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
df <- aggregate(Emissions ~ year, data=ems, mean)
df$Emissions <- round(df$Emissions,2)
df$year <- factor(df$year)

#   Create trend chart and display emission counts in millions
par(mar=c(5,5,5,5))
chart <- barplot(df$Emissions, names=df$year,
                 main="Average Yearly Baltimore Emissions",
                 ylab="Average Emissions")

text(chart,0,df$Emissions, cex=1, pos=3)

#   Copy chart to file
dev.copy(png, file="plot2.png")
dev.off()