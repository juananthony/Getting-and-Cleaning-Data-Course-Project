library(reshape2)
library(dplyr)

# Download and extract dataset
filename <- "dataset.zip"
datasetUrl <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"

if(!file.exists(filename)) {
  download.file(datasetUrl, filename)
  unzip(filename)
}

# Read feature and activity labels
activityLabels <- read.table("UCI HAR Dataset/activity_labels.txt")
featureLabels <- read.table("UCI HAR Dataset/features.txt")

# Look for wanted features and cleaning names
featuresWanted <- grep("(.*)mean(.*)|(.*)std(.*)",featureLabels[,2])
featuresWanted.names <- featureLabels[featuresWanted,2]
featuresWanted.names = gsub('-mean','Mean', featuresWanted.names)
featuresWanted.names = gsub('-std', 'Std', featuresWanted.names)
featuresWanted.names <- gsub('[-()]', '', featuresWanted.names)

# Load Train dataset
trainData <- read.table("UCI HAR Dataset/train/X_train.txt")[featuresWanted]
trainSubject <- read.table("UCI HAR Dataset/train/subject_train.txt")
trainActivities <- read.table("UCI HAR Dataset/train/y_train.txt")
trainData <- cbind(trainSubject, trainActivities, trainData)

# Load Test dataset
testData <- read.table("UCI HAR Dataset/test/X_test.txt")[featuresWanted]
testSubject <- read.table("UCI HAR Dataset/test/subject_test.txt")
testActivities <- read.table("UCI HAR Dataset/test/y_test.txt")
testData <- cbind(testSubject, testActivities, testData)

# Merge train and test data
dataset <- rbind(trainData, testData)
colnames(dataset) <- c("subject", "activity", featuresWanted.names)

# Replacing activity values into activity labels
dataset$activity <- factor(dataset$activity, levels = activityLabels[,1], labels = activityLabels[,2])

# Getting the mean
dataset.melted <- melt(dataset, id = c("subject", "activity"))
dataset.mean <- dcast(dataset.melted, subject + activity ~ variable, mean)

# Writing tidy data
write.table(dataset.mean, "tidyData.txt", row.names = FALSE, quote = FALSE)