# Question 1 - Apply strsplit() to split all the names of the data frame on the characters "wgtp". 
# What is the value of the 123 element of the resulting list?

url <- "https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2Fss06hid.csv"
download.file(ulr, destfile="microdata.csv")
x <- strsplit(names(data), "wgtp")
x[123]

# Question 2 Remove the commas from the GDP numbers in millions of dollars and average them. What is the average? 

url <- "https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2FGDP.csv"
download.file(url, destfile="gdp.csv")
data <- read.csv("gdp.csv", skip=4)
x <- as.numeric(gsub(",","",data$X.4))
y <- complete.cases(x)
x[y]
