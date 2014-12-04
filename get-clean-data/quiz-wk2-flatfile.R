##
#   Script:     quiz-wk2-flatfile.R
#   Author:     Dennis Barger
#   Date:       7/20/14
#   Purpose:
#   Download file using url and read contents
#

#fileUrl <- "http://www.cpc.ncep.noaa.gov/data/indices/wksst8110.for"
fileUrl <- "https://d396qusza40orc.cloudfront.net/getdata%2Fwksst8110.for"
download.file(fileUrl, destfile="data-cloud.txt")

widths <- c(12,7,4,9,4,9,4,9,4)
##labels <- c("week","n1+2sst","n1+2ssta","n3sst","n3ssta","n34sst","n34ssta","n4sst","n4ssta")
#dat <- read.fwf(fileUrl, skip=4, widths=widths, col.names=labels)
dat <- read.fwf(fileUrl, skip=4, widths=widths)
sum(dat$V4)
