Getting-and-Cleansing-Data
==========================
README: Samsung Galaxy Accelerometer Application Data Analysis

The R script (run_analysis.R) in this repository is a self-contained program to download, manipulate, summarize, and ultimately output a tidy data file as a requirement of the Coursera Getting and Cleaning Data Course Project.

The data is accelerometer information from a test among 30 subjects using the Samsung Galaxy smartphone app which measures physical activity.

The data for this project may be found here...

https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip

...and can also be access by running the R script itself.

The run_analysis.R script is completely documented for easy use. In summary, the R script...

downloads and unzips the appropriate data file into a working directory
Merges the training and the test sets to create one data set.
Extracts only the measurements on the mean and standard deviation for each measurement. 
Uses descriptive activity names to name the activities in the data set
Appropriately labels the data set with descriptive variable names. 
From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.
