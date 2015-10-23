# cleaningdata_samsung

Included in this project is the code for downloading and cleaning the Activity Monitor Data Located at https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip 

After cloning this repository and setting teh working directory in R Studio to the created directory

Run these two commands

1. source('download.R')

2. download_unzip()

This will download the zip located at https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip and unzip into a directory "UCI HAR Dataset"

Than running these two commands

1. source('run_analysis.R')

2. summary<-run_all()

will create a list of four varaibles 

summary[[1]] - is the training and test data from "UCI HAR Dataset" merged together, it's first column is an integer corresponding to a subject in the experiment and the second column is an activityId corresponding to the activity being performed. The other columns are measuremnts taking by the movement tracking device, the names for these columns where extracted from "UCI HAR Dataset/features.txt" - this completes step #1 and #4 of the assignment

summary[[2]] - is the smae dataset, but only with the mean and std columns - this completes step #2 of the assignment

summary[[3]] - adds a column with descriptive activity names taken from "UCI HAR Dataset/activity_labels.txt" to the data frame summary[[2]] - this completes #3 of the assignment

summary[[4]] - is a summary of summary[[3]] each row is the average of all the observed measurement for a activity and subject, foreach different mean and std that was measured - this answers #5 of the assignmnet


this will also write summary[[4]] to a file named "step_5_answer.txt" the format for that fileis described in CodeBook.mdfil