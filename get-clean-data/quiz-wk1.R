# Question 1
file <- "c:\\workspace\\data\\housing\\getdata-data-ss06hid.csv"
data <- read.csv(file)
x <- subset(data, VAL==24, select=VAL)
nrow(x)

# Question 2
file <- "c:\\workspace\\data\\housing\\getdata-data-ss06hid.csv"
data <- read.csv(file)


# Question 3
#  Need to install packages:  rJava and xlsx.
#  Current version of R is 64bit, which requires 64bit java runtime.  My laptop is configured to use
#  32-bit jre.  To make RStudio compatible with 64-bit, set JAVA_HOME environment variable to null
#
# If JAVA_HOME is populated then set variable to null
if (Sys.getenv("JAVA_HOME")!="") {
    Sys.setenv(JAVA_HOME="")
    library(rJava)
}
#
file <- "c:\\workspace\\data\\getdata-005\\getdata-data-DATA.gov_NGAP.xlsx"
cIndex <- 7:15
rIndex <- 18:23
dat <- read.xlsx(file, sheetIndex=1, colIndex=cIndex, rowIndex=rIndex)
sum(dat$Zip*dat$Ext,na.rm=T)

# Question 4
#
# Read Baltimore xml data:  https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2Frestaurants.xml

library(XML)
fileUrl <- "https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2Frestaurants.xml"

rootNode <- xmlRoot(doc)
xmlName(rootNode)
y <- xpathSApply(rootNode, "//zipcode". xmlValue)
z <- grep("21231", y)

# Question 5
# Download csv file from internet

fileUrl <- "https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2Fss06pid.csv"
file <- "c"\\workspace\\data\\getdata-005\\q5-file.csv"
download.file(fileUrl, destTile=file)
