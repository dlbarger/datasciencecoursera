##
# Households with 10 acres or more and sold more than 10,000 AGS products

df <- read.csv("c:\\workspace\\data\\getdata-005\\getdata-data-ss06hid.csv")
x <- which(df$ACR==3 & df$AGS==6)

# use jpeg package and read image
install.packages("jpeg")
library(jpeg)
url <- "https://d396qusza40orc.cloudfront.net/getdatfa%2Fjeff.jpg"
download.file(url, destfile ="image.jpg")

# gdp
url = "https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2FGDP.csv"
download.file(url, destfile="gdp.csv")
gdp <- read.csv("gdp.csv", skip=4)
df <- subset(gdp,select=c(X,X.1,X.3,X.4))
names(df) <- c("CountryCode","Ranking","Economy","Dollars")

url ="https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2FEDSTATS_Country.csv"
download.file(url, destfile="country.csv")
country <- read.csv("country.csv")

x <- merge(df, country, by="CountryCode")

y <- x[order(x$Ranking, decreasing=TRUE),]
