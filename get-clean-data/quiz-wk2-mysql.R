# Question 4
con <- url("http://biostat.jhsph.edu/~jleek/contact.html ")
htmlCode <- readLines(con)
close(con)
# count line 10
nchar(htmlCode[10])
# count line 20
nchar(htmlCode[20])
# count line 30
nchar(htmlCode[30])
# count line 100
nchar(htmlCode[100])