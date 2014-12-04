##############################################################################################
#
#   Script: statinfer-project.R
#   Author: Dennis Barger
#   Date:   10/22/2014
#
#   Description:
#   Workspace for completing course project
#   - Simulation Exercises
#   - Basic Inferential data analysis

# http://rstudio-pubs-static.s3.amazonaws.com/25344_573d3c98510e48f0bef830e67c9d02dc.html
#
###############################################################################################
#   Simulation Exercises
#   - Show where the distribution is centered and compare to theoretical center
#   - Show how variable it is and compare to theoretical variance of distribvutions
#   - Show that the distribution is approximately normal
#   - Evaluate coverage of confidence interval for 1/lambda
###############################################################################################

library(ggplot2)

#   Simulate data for exponential distribution
lambda = 0.2
n = 40
set.seed(100)
df <- data.frame(replicate(1000,mean(rexp(40,.2))))
names(df) <- "mean_value"


#   Evaluate distribution mean, standard deviation and variance
mean(df$mean_value)
sd(df$mean_vallue)
var(df$mean_value)

#   Evaluate theoretical mean
(1/lambda)

#   Evaluate theoretical standard variance 
(1/lambda)/sqrt(40)
#   Evaluate theoretical variance
((1/lambda)/sqrt(40))^2

#   Plot simulated values
g <- ggplot(data=df, aes(x=mean_value))
g <- g + geom_histogram(aes(y=..density..), binwidth=0.20)
g <- g + stat_function(fun=dnorm, arg=list(mean=1/lambda, sd=sd(df$mean_value)))
    

