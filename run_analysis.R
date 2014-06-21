# You should create one R script called run_analysis.R that does the following. 
# Merges the training and the test sets to create one data set.
# Extracts only the measurements on the mean and standard deviation for each measurement. 
# Uses descriptive activity names to name the activities in the data set
# Appropriately labels the data set with descriptive variable names. 
# Creates a second, independent tidy data set with the average of each variable for each activity and each subject. 


#Download the file unzip and set working directory
if(!file.exists("./data")){
    dir.create("./data")
}
if(!file.exists("./data/UCIHARDataset.zip")){
    download.file("https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip", destfile="./data/UCIHARDataset.zip")
    unzip(zipfile="./data/UCIHARDataset.zip",exdir="./data")
}


#Create data frames out of data
features <- read.table("./data/UCI HAR Dataset/features.txt")
activities <- read.table("./data/UCI HAR Dataset/activity_labels.txt")

subjectsTest <- read.table("./data/UCI HAR Dataset/test/subject_test.txt")
subjectsTrain <- read.table("./data/UCI HAR Dataset/train/subject_train.txt") 

testX <- read.table("./data/UCI HAR Dataset/test/X_test.txt",stringsAsFactors=FALSE) 
testY <- read.table("./data/UCI HAR Dataset/test/y_test.txt")

trainX <- read.table("./data/UCI HAR Dataset/train/X_train.txt")
trainY <- read.table("./data/UCI HAR Dataset/train/y_train.txt") 

#Name each column to meaningful names
names(testX) <- features$V2 
names(trainX) <- features$V2 

##merge together test and train data based on column names
#Add meainingful names to the activities
trainY <- merge(trainY,activities, by.x="V1", by.y="V1")
testY <- merge(testY,activities, by.x="V1", by.y="V1")

#Combine activities to subjects
testY <- cbind(testY$V2,subjectsTest)
trainY <- cbind(trainY$V2,subjectsTrain)

#Name activity and subject column
names(testY) <- c("Activity","Subject")
names(trainY) <- c("Activity","Subject")

#Add activities and subjects to the rest of the data.
testX <- cbind(testX,testY)
trainX <- cbind(trainX,trainY)  

#merge test and train data together into one dataset 
mergedResults = rbind(testX,trainX)

#Subset of the data for only mean and std measurements 
extractMean <- grep("-mean\\(\\)",names(mergedResults))
extractSTD <- grep("-std\\(\\)",names(mergedResults)) 
activity <- grep("Activity",names(mergedResults))
subjects <- grep("Subject",names(mergedResults))

extractedData <- mergedResults[,c(extractMean,extractSTD,activity,subjects)]  


#Create second tidy dataset of averages
library(reshape2)
meltedData <- melt(extractedData,id=c("Subject","Activity"),na.rm=TRUE)
DataSet2 <- dcast(meltedData, Subject+Activity ~ variable,mean)

write.csv(extractedData,file="./Getting and Cleaning Data Course Project/tidyDataSet1.csv",row.names=FALSE)
write.csv(DataSet2,file="./Getting and Cleaning Data Course Project/tidyDataSet2.csv",row.names=FALSE) 
