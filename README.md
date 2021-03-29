---
title: "Getting and Cleaning Data Final Assignment"
output: html_document
---
This repository is for the final assignment in the "Getting and Cleaning Data" course. 

## Data
The dataset used contains observations of a group of 30 volunteers (aged 19-48) as they performed 6 different activities (walking, walking upstairs, walking downstairs, sitting, standing and laying) while wearing a smart-phone on their waists. Measurements from the accelerometer and gyroscope sensors on the smart-phone were recorded (specificically, 3-axial linear acceleration and 3-axial angular velocity measurements). Full details of the experiments can be seen <a href="http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones">here</a>. The link to the dataset is <a href="https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip">here</a>.

## Analysis Script
The analysis script is called `run_analysis.R`. This script downloads, reads in the data set and stores the relevant files into different tables (features, activity_labels, training/test data). The training & test sets are merged into one large set. The data is then cleaned by extracting only the mean and standard deviation measurements and replacing the numbered activities by their activity name. The final tidy data set is obtained from this by calculating the mean of each measurement for each subject and activity. The tidy data set is then saved into "tidy_data_set.txt". Further details can be seen in the CodeBook.md file.