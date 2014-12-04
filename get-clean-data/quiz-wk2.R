##
#   Script:     quiz-wk2.R
#   Author:     Dennis Barger
#   Date:       7/19/14
#
#   Purpose:    Research topics related to Week 2 Quiz (Using Github API)
#
#   Comments:
#   Based on Hadley's tutorial/code example.  Using Github "Personal Access Tokens"
#   instead of creating application.  According to CTA comments in Discussion forum
#   Github would prefer uses test API functionality using Personal Access Tokens.

#   Need instantiate packages:  httr, httpuv
install.packages("httr")
library(httr)
install.packages("httpuv")
library(httpuv)
install.packages("jsonlite")
library(jsonlite)


#   1. Find oauth settings for github (http://developer.github.com/v3/oauth/)
oauth_endpoints("github")

#   2. Set environment variables (GITHUB_CONSUMER_SECRET) and register application??

#   Old code
#       Hadley's example uses an application.  According to Discussion forum, replace
#       secret token with NULL value (not "")
#       Sys.setenv(GITHUB_CONSUMER_SECRET = 'd9034eb820d35acf2ab76f1f75a2b4de213f3eb1')
#       myapp <- oauth_app("github", NULL)
#   New Code
#   myapp <- oauth_app("github", <<client id>>, <<secret code>>)
myapp <- oauth_app("github", "a05e752cce3ddafa090e", "eef1d9113d60be75203b6978d41725eea8671404")

#   3. Get OAuth credentials
github_token <- oauth2.0_token(oauth_endpoints("github"), myapp)

# 4. Use API
gtoken <- config(token = github_token)
req <- GET("https://api.github.com/users/jtleek/repos", gtoken)
data <- fromJSON("https://api.github.com/users/jtleek/repos")
x <- subset(data, name =="datasharing", select=created_at)

