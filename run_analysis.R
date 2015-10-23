# http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones 
# 
# Here are the data for the project: 
#   
#   https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip 
# 
# You should create one R script called run_analysis.R that does the following. 
# 1. Merges the training and the test sets to create one data set.
#     all_data() - also completes 4
# 2. Extracts only the measurements on the mean and standard deviation for each measurement. 
#     only_mean_and_std()
# 3. Uses descriptive activity names to name the activities in the data set
#     descriptive_activity_names()
# 4. Appropriately labels the data set with descriptive variable names. 
#     all_data()
# 5. From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.
#     summarize_by_activity_and_subject()
default_data_dir<-"UCI HAR Dataset/"
library(dplyr)

run_all<-function(data_dir=default_data_dir){
  all_df<-all_data(data_dir)
  mean_std_df<-only_mean_and_std(all_df)
  activity_df<-descriptive_activity_names(mean_std_df)
  summary_df<-summarize_by_activity_and_subject(activity_df)
  write.table(summary_df, file = "step_5_answer.txt", row.name=F)
  list(all_df, mean_std_df, activity_df, summary_df)
}

only_mean_and_std<-function(df, data_dir=default_data_dir){
  df%>%select(subject, activityId, matches(".*(mean|std)\\(\\)-."))
}

descriptive_activity_names<-function(df, data_dir=default_data_dir){
  activity_label_path = paste0(data_dir, "activity_labels.txt")
  activity_label = load_df(activity_label_path)
  colnames(activity_label) <- c("activityId","activity")
  left_join(activity_label, df)
}

summarize_by_activity_and_subject<-function(df, data_dir=default_data_dir){
  g<-group_by(df, activity, subject)
  summarise_each(g, funs(mean))
}

all_data<-function(data_dir=default_data_dir){
  header_path = paste0(data_dir, "features.txt")
  data_header = get_data_header(header_path)
  
  subset_dir = paste0(data_dir, "test/")
  test <- load_dir(subset_dir, data_header)
  
  subset_dir2 = paste0(data_dir, "test/")
  train <- load_dir(subset_dir2, data_header)
  
  all_data<-bind_rows(test,train)
  all_data
}

load_dir<-function(subset_dir, data_header){
  observation_path = paste0(subset_dir, "x_test.txt")
  subject_path =  paste0(subset_dir, "subject_test.txt")
  activity_path =  paste0(subset_dir, "y_test.txt")
  
  observations <- load_df(observation_path)
  subject <- load_df(subject_path)
  activity <- load_df(activity_path)
  
  if(length(colnames(observations)) != length(data_header)){
    stop("observation headers list wrong length")
  }
  
  colnames(observations)<-data_header
  colnames(subject)<-c("subject")
  colnames(activity)<-c("activityId")
  
  if(nrow(observations) != nrow(subject)){
    stop("length observation subject mismatch")
  }
  if(nrow(observations) != nrow(activity)){
    stop("length observation subject activity")
  }
  obs_df<-subject %>% bind_cols(activity) %>% bind_cols(observations)
  obs_df
}

load_df<-function(path){
  x<-read.table(path)
  tbl_df(x)
}

get_data_header<-function(path){
  headers = load_df(path)
  colnames(headers)<-c("header_number","header_name")
  headers$header_name
}

