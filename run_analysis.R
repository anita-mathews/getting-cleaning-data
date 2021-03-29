library(dplyr)

# Read in data from the dataset
zipfilename <- "UCI HAR Dataset.zip"
download.file("https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip", zipfilename,
              method="curl")
unzip(zipfilename)
filename = "UCI HAR Dataset"
features <- read.table(paste0(filename, "/features.txt"), col.names = c("nfeature", "featurename"))
activity_labels <- read.table(paste0(filename, "/activity_labels.txt"), col.names = c("nactivity", "label"))

# training set data
x_train <- read.table(paste0(filename, "/train/X_train.txt"), col.names = features$featurename)
y_train <- read.table(paste0(filename, "/train/y_train.txt"), col.names = "nactivity")
subject_train <- read.table(paste0(filename, "/train/subject_train.txt"), col.names = "subject")

# test data 
x_test <- read.table(paste0(filename, "/test/X_test.txt"), col.names = features$featurename)
y_test <- read.table(paste0(filename, "/test/y_test.txt"), col.names = "nactivity")
subject_test <- read.table(paste0(filename, "/test/subject_test.txt"), col.names = "subject")

# merge training and test data 
x_merged <- rbind(x_train, x_test)
y_merged <- rbind(y_train, y_test)
subject_merged <- rbind(subject_train, subject_test)
merged_data <- cbind(x_merged, y_merged, subject_merged)

# extract columns with mean or standard deviation data
mean_std_data <- merged_data %>% select(contains("mean") | contains("std"), "nactivity", "subject")

# name the activities in mean_std_data based on the activity_labels
mean_std_data <- mean_std_data %>% rename(activityname = nactivity)
mean_std_data$activityname <- activity_labels$label[match(mean_std_data$activityname, 
                                                          activity_labels$nactivity)]

# label mean_std_data with descriptive variable names, first remove periods
names(mean_std_data) <- gsub("\\.", "", names(mean_std_data))

# replace parts of the names for greater readability 
# resulting names will all be in proper camelcase
names(mean_std_data) <- names(mean_std_data) %>%
                        gsub("bodybody", "Body", .) %>%
                        gsub("body", "Body", .) %>%
                        gsub("^t", "Time", .) %>%
                        gsub("tBody", "TimeBody", .) %>%
                        gsub("^f", "Freq", .) %>%
                        gsub("mean", "Mean", .) %>%
                        gsub("std", "Std", .) %>%
                        gsub("jerk", "Jerk", .) %>%
                        gsub("angle", "Angle", .) %>%
                        gsub("gravity", "Gravity", .) %>%
                        gsub("activity", "Activity", .) %>%
                        gsub("name", "Name", .) %>%
                        gsub("subject", "Subject", .)

# this contains the means for each subject and activity name
tidy_data_set <- mean_std_data %>% group_by(Subject, ActivityName) %>%
                 summarize_all(list(mean))

# writing tidy data to an output file
write.table(tidy_data_set, "tidy_data_set.txt", row.names = FALSE)
