# run_analysis.R
run_analysis Coursera Project for week 3

Afer installing
library(plyr)
library(dplyr)

I downloaded the data files
run_analysis_X_data_feat <- read.table("./R/data/UCI HAR Dataset/features.txt", header = FALSE)
run_analysis_X_data <- read.table("./R/data/UCI HAR Dataset/train/X_train.txt", header = FALSE)

I labelled the data sets with descriptive variable names. 

I added the activity as the last column

I then merged the training and the test sets to create one data set.

The grep for *ean* worked for Mean and mean:
j <- grep("*ean*",names(run_analysis_all_data))
There were no ther STD or Std strings so the following is fine:
k <- grep("*std*",names(run_analysis_all_data))
Lastly I used this to get the 'column number' for activity_num:
l <- grep("*activity_num*",names(run_analysis_all_data))

This extracts only the measurements on the mean and standard deviation for each measurement:
run_analysis_all_data_less_cols <- run_analysis_all_data[,c(j,k,l)]

I used descriptive activity names to name the activities in the data set, and then created a factor

From the previous data set I creates a second, independent tidy data set with the average of each variable for each activity and each subject.
