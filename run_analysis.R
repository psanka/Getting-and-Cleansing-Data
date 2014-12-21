###############################################################
## Getting and Cleaning Data Course Project
###############################################################

##############################################################
## Part 1: Merges the training and the test sets to create one data set.
##############################################################

# Download Dataset 
 
fileURL <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
download.file(fileURL, "./data/activity.zip")

# unzip the files
unzip("./data/activity.zip",exdir="./data")
setwd('./data/UCI HAR Dataset')

# Rename train data columns 

x_train <- read.table('./train/X_train.txt')

subject_train <- read.table('./train/subject_train.txt')
names(subject_train)[1] <- 'subject'

activity_train <- read.table('./train/y_train.txt')
names(activity_train)[1] <- 'activity'

# Rename test data columns

x_test <- read.table('./test/X_test.txt')

subject_test <- read.table('./test/subject_test.txt')
names(subject_test)[1] <- 'subject'

activity_test <- read.table('./test/y_test.txt')
names(activity_test)[1] <- 'activity'

# concatenate the train and test files

trainData <- cbind(subject_train, activity_train, x_train)
testData <- cbind(subject_test, activity_test, x_test)

# merge the files into one
actDat <- rbind(trainData, testData)


######################################################################################################
## Part 2: Extracts only the measurements on the mean and standard deviation for each measurement
######################################################################################################

# Average values 

avg_val <- apply(actDat[3:563], 2, mean) 

#Standard Deviation

std <- apply(actDat[3:563], 2, sd) 

# combine them
stats <- cbind(avg_val, std) 


############################################################################################
## Part 3: Uses descriptive activity names to name the activities in the data set
############################################################################################

# make sure of the column name for activities
names(actDat[1:2])

actDat$activity[which(actDat$activity == 1)] <- 'Walking'
actDat$activity[which(actDat$activity == 2)] <- 'Walking upstairs'
actDat$activity[which(actDat$activity == 3)] <- 'Walking downstairs'
actDat$activity[which(actDat$activity == 4)] <- 'Sitting'
actDat$activity[which(actDat$activity == 5)] <- 'Standing'
actDat$activity[which(actDat$activity == 6)] <- 'Laying'


########################################################################
## Part 4: Appropriately labels the data set with descriptive variable names.
########################################################################

# create column labels
features <- read.table('features.txt')
features$V1 <- NULL

# Assign each row name from the 'features' data frame to the appropriate column
# in the 'actDat' data frame

i <- 1
j <- i + 2

while (i < 562) {
        featnm <- features[i,]
        colnames(actDat)[j] <- paste(featnm)
        i = i + 1
        j = j + 1
}


########################################################################
## Part 5: From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.
########################################################################

# initialize a temporary data frame
sumdata <- aggregate(actDat[,3] ~ subject + activity, data = actDat, FUN = 'mean')

#calculate the means for each column
for (i in 4:ncol(actDat)) {
        sumdata[,i] <- aggregate(actDat[,i] ~ subject + activity, data = actDat, FUN = 'mean')[,3]
}

# renames the columns to the descriptive name
colnames(sumdata) <- colnames(actDat)



# go to the main data directory, and write the new tidy data file
setwd('..')
getwd()
write.table(sumdata, 'tidydata.txt',row.names=FALSE)
