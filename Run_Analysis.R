gcd.zip <- download.file("https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip", destfile = "gcd.zip")
unzip("gcd.zip")
setwd("UCI HAR Dataset")
library(dplyr)

# Function to read in data as structured
read_har_data <- function(folder) {
  
  # Get x data
  xdat <- read.table(file = paste0(folder, "/", "X_", folder, ".txt"))
  # Get names of x variables
  xnames <- read.table(file = "features.txt", stringsAsFactors = F) 
  # Get training/test labels
  ydat <- read.table(file = paste0(folder, "/", "y_", folder, ".txt"))
  # Get subject information
  subj <- read.table(file = paste0(folder, "/", "subject_", folder, ".txt"))
  
  # Set names of x data
  names(xdat) <- make.names(xnames$V2, unique = T)
  
  # Add labels in as a column in the x data
  xdat$label <- ydat$V1
  xdat$Subject <- subj$V1
  
  xdat_keep <- select(xdat, matches("Subject|label|mean|std"))
  
  # Get activity labels
  activity <- read.table(file = "activity_labels.txt", stringsAsFactors = F)
  names(activity) <- c("label", "Activity")
  
  # Join activity information with xdat_keep
  # This will add an Activity column with useful labels
  xdat_keep <- left_join(xdat_keep, activity)
  
  xdat_keep <- select(xdat_keep, -label) # Get rid of label - we don't need it anymore
  return(xdat_keep)
}

alldata <- bind_rows(read_har_data("test"),
                     read_har_data("train")) %>%
  select(Subject, Activity, 1:86)

tidy_summary <- alldata %>%
  group_by(Subject, Activity) %>%
  summarize_all(mean)

tidy_summary2 <- alldata %>%
  group_by(Activity) %>%
  summarize_all(mean)
