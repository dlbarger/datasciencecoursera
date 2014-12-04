#######################################################
#
#   regression.R
#   Example calculating linear least squares regression
#
#   Define data sets
yr <- c(2000,2001,2002,2003,2004)
rt <- c(9.34,8.50,7.62,6.93,6.60)

#   let's plot the data
plot(yr,rt,main="Interest Rates")
#   let's ensure data is linear by reviewing correlations
cor(yr,rt)

#   let's use the lm() to calculate least squares
#   The explantory/independent variables = yr (years)
#   The response/depedent variable = rt (rate)
#   fit <- lm(dependent var ~ independent var)
fit <- lm(rt ~ yr)
fit

#   Let's drill down further...
#   The object fit is a linear function with names
names(fit)

#   We are only interested in slope and intercept for 
#   calculating least squares
fit$coefficients[1] # intercept
fit$coefficients[2] # slope

