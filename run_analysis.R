## Merge the training and test data sets to form one single data set 
## Set the current working directory

library(reshape2)

## Download and unzip the dataset
 filename <- "getdata_dataset.zip"
if (!file.exists(filename)){
fileUrl <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
   download.file(fileUrl, filename)
} 
if (!file.exists("UCI HAR Dataset")){
  unzip(filename)
}
 
#Load the activity labels and the features labels and convert them to characters
 activitylabel <- read.table("../UCI HAR Dataset/activity_labels.txt")
 activitylabel[,2] <- as.character(activitylabel[,2]) 
 features <-read.table("../UCI HAR Dataset/features.txt")
 features[,2] <- as.character(features[,2])
 
 # Load the training and test datasets
 traindata <- read.table("../UCI HAR Dataset/train/X_train.txt")
 trainlabel <- read.table("../UCI HAR Dataset/train/Y_train.txt")
 trainSubject <- read.table("../UCI HAR Dataset/train/subject_train.txt")
 testdata <- read.table("../UCI HAR Dataset/test/X_test.txt")
 testlabel <-read.table("../UCI HAR Dataset/test/y_test.txt")
 testSubject <- read.table("../UCI HAR Dataset/test/subject_test.txt")
 

## Extract the data on mean and Standard deviation
meanStdIndices <- grep("mean\\(\\)|std\\(\\)",features[,2])
featuresNames <- features[meanStdIndices, 2]
# Replacing mean, std,'[-()]'with Mean, Std and '' in the code
featuresNames <- gsub('-mean', 'Mean', featuresNames)
featuresNames <- gsub('-std','Std', featuresNames)
featuresNames <- gsub('-()', '', featuresNames)


## subset traindata and testdata to include only the mean and std indices values  
finaltrain <- traindata[meanStdIndices]
finaltest <- testdata[meanStdIndices]

## make one train and test dataset
train <- cbind(trainlabel,trainSubject, finaltrain)
test <- cbind(testlabel, testSubject, finaltest)

## combine the training and test datasets into one dataset
joindata <- rbind(train, test)
colnames(joindata) <- c("activity", "subject", featuresNames)

## change activities and subjects into factors
joindata$activity <- factor(joindata$activity, levels = activitylabel[,1], labels = activitylabel[,2])
joindata$subject <- as.factor(joindata$subject)

joindata.melted <- melt(joindata, id = c("activity", "subject" ))
joindata.mean <- dcast(joindata.melted, activity + subject ~ variable, mean)

write.table(joindata.mean,"tidydata.txt", row.names = FALSE, quote = FALSE)

 