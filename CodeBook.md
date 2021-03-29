---
title: "Code Book for Getting and Cleaning Data Final Assignment"
output: html_document
---

This code book describes the data, variables and the transformations performed in order to produce a tidy data set seen in "tidy_data_set.txt".

## 1. Downloading and Reading in the Data
The dataset used contains observations of a group of 30 volunteers (aged 19-48) as they performed 6 different activities (walking, walking upstairs, walking downstairs, sitting, standing and laying) while wearing a smart-phone on their waists. Measurements from the accelerometer and gyroscope sensors on the smart-phone were recorded (specificically, 3-axial linear acceleration and 3-axial angular velocity measurements). Full details of the experiments can be seen <a href="http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones">here</a>. The link to the dataset is <a href="https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip">here</a>.

The data were downloaded and then unzipped into the working directory (using `download.file()` and `unzip()`). There were two main sets (a training set and a test set obtained from partitioning the volunteers in the experiment) along with files describing the numbered activities and the various features/observations.

The relevant files were then loaded into R as tables using `dplyr`. Specifically:
<ul>
<li>`features.txt` was loaded in as `features`</li>
<li>`activity_labels.txt` was loaded in as `activity_labels`</li>
</ul>

The training files were:
<ul>
<li>`/train/X_train.txt` was loaded in as `x_train`</li>
<li>`/train/y_train.txt` was loaded in as `y_train`</li>
<li>`/train/subject_train.txt` was loaded in as `subject_train`</li>
</ul>

The test files were:
<ul>
<li>`/test/X_test.txt` was loaded in as `x_test`</li>
<li>`/test/y_test.txt` was loaded in as `y_test`</li>
<li>`/test/subject_test.txt` was loaded in as `subject_test`</li>
</ul>

As the `X_train` and `X_test` data were loaded in, the columns were renamed using the named features in `features.txt`.

## 2: Merging the testing and training datasets together
The `x_train` and `x_test` sets were merged into a variable named `x_merged` using `rbind()`.
The `y_train` and `y_test` sets were merged into a variable named `y_merged` using `rbind()`.
The `subject_train` and `subject_test` sets were merged into a variable named `subject_merged` using `rbind()`.
The `x_merged`, `y_merged` and `subject_merged` sets were then merged together into a variable called `merged_data` (the final merged set) using `cbind()`.

## 3. Extracting the mean and standard deviation measurements for each measurement
At this point, the column names in `merged_data` included the subject (`subject`), the numbered activity (`nactivity`) and the various features.
The `subject`, `nactivity` columns as well as those containing "mean" or "std" in the name were extracted (using `select`) and then saved into another variable called `mean_std_data`. 

## 4. Naming the activities
The `nactivity` representing the numbered activity was first renamed to `activityname`. Then, the numbered values in that column were replaced with the activity name by matching with the label names in the `activity_label` table. 

## 5. Labeling the dataset with appropriate variable names
First the periods in the names were removed. Then the following changes were made to the names in order to increase overall readability:
<ul>
<li>"bodybody" was changed to "Body"</li>
<li>"body" was changed to "Body"</li>
<li>"t" at the beginning of the name was changed to "Time"</li>
<li>"tBody" was changed to "TimeBody"</li>
<li>"f" at the beginning of the name was changed to "Freq"</li>
<li>"mean" was changed to "Mean"</li>
<li>"std" was changed to "Std"</li>
<li>"angle" was changed to "Angle"</li>
<li>"gravity" was changed to "Gravity"</li>
<li>"activity" was changed to "Activity"</li>
<li>"name" was changed to "Name"</li>
<li>"subject" was changed to "Subject"</li>
</ul>

In this way, the resulting variable names are readable and are in proper camelcase.

## 6. Final tidy data set
The final tidy data set (variable named `tidy_data_set`) was then obtained by grouping the data in `mean_std_data` by the `Subject` and `ActivityName` columns and then taking the mean of all the measurements (using the `mean` function in `summarize_all()`). This final tidy data set then contains the mean of each measurement for each subject and activity pair. This set is then saved into "tidy_data_set.txt".