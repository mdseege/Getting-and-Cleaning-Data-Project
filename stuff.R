gcd.zip <- download.file("https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip", destfile = "gcd.zip")
unzip("gcd.zip")
setwd("UCI HAR Dataset")
library(dplyr)

#download X train and X test data 
xtrain <- read.table("train/X_train.txt")
xtest <- read.table("test/X_test.txt")

#bind X test and X train data by rows
xdata <- rbind(xtrain, xtest)

#download features data 
features <- read.table("features.txt", stringsAsFactors = F)

#replace column names in xdata with features data from previous step 
names(xdata) <- make.names(features$V2, unique = T)

#reduce columns to include only ones with mean or std
xdata <- select(xdata, matches("mean|std"))

#download subject train and subject test data
subtrain <- read.table("train/subject_train.txt")
subtest <- read.table("test/subject_test.txt")

#bind subtrain and subtest data by rows
subject <- rbind(subtrain, subtest)
fjdlfj


#add column named Subject to xdata with data with subject created above 
xdata$Subject <- subject$V1

#download ytrain and ytest data
ytrain <- read.table("train/y_train.txt")
ytest <- read.table("test/y_test.txt")

#bind ytrain and ytest by rows 
activity <- rbind(ytrain, ytest)

#add column named V1 to xdata with activity data created above
xdata$V1 <- activity$V1

#download activity labels data 
actlab <- read.table("activity_labels.txt")

#left join column to xdata with actlab created above
xdata <- left_join(xdata, actlab)

#select colunmns in desired order ommiting coulnmn V1
xdata <- select(xdata, Subject, V2, 1:86, -V1)

#change column 2 name to Activity
names(xdata)[2] <- "Activity"

#create tidy data that averages data by Subject then Activity 
tidy <- xdata%>%
  group_by(Subject, Activity)%>%
  summarize_all(mean)

#write tidy.txt file
write.table(tidy, "tidy.txt", row.name = FALSE)

getwd()
str(tidy)
str(xdata)
