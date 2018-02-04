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

# Load Train dataset
trainData <- read.table("UCI HAR Dataset/train/X_train.txt")
trainSubject <- read.table("UCI HAR Dataset/train/subject_train.txt")
trainActivities <- read.table("UCI HAR Dataset/train/y_train.txt")
trainData <- cbind(trainData, trainSubject, trainActivities)

# Load Test dataset
testData <- read.table("UCI HAR Dataset/test/X_test.txt")
testSubject <- read.table("UCI HAR Dataset/test/subject_test.txt")
testActivities <- read.table("UCI HAR Dataset/test/y_test.txt")
testData <- cbind(trainData, trainSubject, trainActivities)