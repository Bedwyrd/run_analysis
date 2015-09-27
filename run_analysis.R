run_analysis <- function()  
{
#install.packages("sqldf")
#install.packages("RH2")
#install.packages("plyr")
#install.packages("dplyr")
#library(sqldf)
library(plyr)
library(dplyr)

run_analysis_X_data_feat <- read.table("./R/data/UCI HAR Dataset/features.txt", header = FALSE)
run_analysis_X_data <- read.table("./R/data/UCI HAR Dataset/train/X_train.txt", header = FALSE)

#3. Appropriately labels the data set with descriptive variable names. 
for (i in run_analysis_X_data_feat)
{names(run_analysis_X_data)[i] <- as.character(run_analysis_X_data_feat[i,2])}

#3. Appropriately labels the data set with descriptive variable names. 
run_analysis_Y_data <- read.table("./R/data/UCI HAR Dataset/train/y_train.txt", header = FALSE)
names(run_analysis_Y_data)[1] <- "activity_num"
run_analysis_X_data <- cbind(run_analysis_X_data, run_analysis_Y_data)

run_analysis_X_data_temp <- read.table("./R/data/UCI HAR Dataset/test/X_test.txt", header = FALSE)
for (i in run_analysis_X_data_feat)
{names(run_analysis_X_data_temp)[i] <- as.character(run_analysis_X_data_feat[i,2])}

run_analysis_Y_data_temp <- read.table("./R/data/UCI HAR Dataset/test/y_test.txt", header = FALSE)
names(run_analysis_Y_data_temp)[1] <- "activity_num"
run_analysis_X_data_temp <- cbind(run_analysis_X_data_temp, run_analysis_Y_data_temp)

#1.Merges the training and the test sets to create one data set.
run_analysis_all_data <- rbind(run_analysis_X_data, run_analysis_X_data_temp)

j <- grep("*ean*",names(run_analysis_all_data))
k <- grep("*std*",names(run_analysis_all_data))
l <- grep("*activity_num*",names(run_analysis_all_data))

#2. Extracts only the measurements on the mean and standard deviation for each measurement. 
run_analysis_all_data_less_cols <- run_analysis_all_data[,c(j,k,l)]

#4. Uses descriptive activity names to name the activities in the data set
run_analysis_all_data_less_cols$activity_num <- factor(run_analysis_all_data_less_cols$activity_num, labels = c("WALKING","WALKING_UPSTAIRS","WALKING_DOWNSTAIRS","SITTING","STANDING","LAYING"))
run_analysis_all_data_less_cols_g <- group_by(run_analysis_all_data_less_cols, activity_num)

#5. From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.
run_analysis_all_data_less_cols_mean <- data.frame(0)
for (i in names(run_analysis_all_data_less_cols))
{
    print(i)
    if (i == "activity_num") {stop("reached end")}
    temp_mean <- aggregate(run_analysis_all_data_less_cols[,i] ~ activity_num, data=run_analysis_all_data_less_cols, FUN=mean)
    run_analysis_all_data_less_cols_mean <- cbind(run_analysis_all_data_less_cols_mean, temp_mean[,2])
    }
run_analysis_all_data_less_cols_mean

}
