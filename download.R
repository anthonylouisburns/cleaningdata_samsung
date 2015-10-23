# A. download and extract to csv

download_unzip <- function(){
  download_smartphone()
  unzip_smartphone()
}

# 1. download
download_smartphone <- function(){
  download.file("https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip", "smartphone.zip")
}

# 2. unzip
unzip_smartphone <- function(){
  unzip("smartphone.zip")
}