rm(list=ls())
library(plyr)
library(stringr)
options(stringsAsFactors = FALSE)

file <- dir("../data/", full.names = TRUE)[1]

data <- ldply(dir("../data/", full.names = TRUE), function(file){
  d <- read.csv2(file)
  d <- cbind(region = as.numeric(str_extract(file, "\\d+")), d)
  d <- names()
})


names(data)
head(data[,1:10])
