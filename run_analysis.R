library(reshape2)
getfile <- function(zipfilename = "HumanActivityRecognitionUsingSmartphonesDataSet.zip",
                         datapath = "./", 
                         fileUrl = "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip")
  {
if (!file.exists(paste(datapath,zipfilename,sep=""))){
  if (!file.exists(datapath)) {
    dir.create(datapath)
  }
  download.file(fileUrl, destfile = paste(datapath,zipfilename,sep=""), method = "curl")
  dateDownloaded <- date()
}
  extractedfiles <- unzip(paste(datapath,zipfilename,sep=""),exdir=datapath)
}

#set up zip file name, data path, and download file url
zipfilename <- "HumanActivityRecognitionUsingSmartphonesDataSet.zip"
datapath <- "./"
fileUrl <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"

#get data by download, unzip the file, return the file obtained. 
if (!file.exists(paste(datapath,"UCI HAR Dataset/",sep=""))){getfile(zipfilename,datapath,fileUrl)}

#read data
  test_set <- read.table(paste(datapath,"UCI HAR Dataset/test/X_test.txt",sep="")) 
  test_label <- read.table(paste(datapath,"UCI HAR Dataset/test/y_test.txt",sep=""))
  test_subject <- read.table(paste(datapath,"UCI HAR Dataset/test/subject_test.txt",sep=""))
  train_set <- read.table(paste(datapath,"UCI HAR Dataset/train/X_train.txt",sep=""))
  train_label  <- read.table(paste(datapath,"UCI HAR Dataset/train/y_train.txt",sep=""))
  train_subject <- read.table(paste(datapath,"UCI HAR Dataset/train/subject_train.txt",sep=""))

  features <- read.table(paste(datapath,"UCI HAR Dataset/features.txt",sep=""))
  activity_labels <- read.table(paste(datapath,"UCI HAR Dataset/activity_labels.txt",sep=""))

#1. Merges the training and the test sets to create one data set.
  label <- rbind(test_label, train_label)
  subject <- rbind(test_subject, train_subject) 
  dataset <- rbind(test_set, train_set)

#2.Extracts only the measurements on the mean and standard deviation for each measurement. 
  #Add the meaningful column names 
  featuresStr <- paste(features$V2)
  names(dataset) <- featuresStr
  names(subject) <- "subject"
  names(label) <- "label"
  #find index of the mean and std columns, and then create the new dataset of only the mean and standard deviation for each measurement with it. 
  ind <- ifelse(grepl("mean()", featuresStr, fixed=T) | grepl("std()",featuresStr,fixed=T),T,F)
  dataset <- dataset[,ind]

#3. Uses descriptive activity names to name the activities in the data set
label$activity <- ""
for (i in seq_along(activity_labels$V1)){
  label$activity[label$label == activity_labels$V1[i]] <- paste(activity_labels$V2[i])
}

#4. Appropriately labels the data set with descriptive activity names. 
dataset$activity <- factor(label$activity, levels= activity_labels$V2)

#5. Creates a second, independent tidy data set with the average of each variable for each activity and each subject. 
dataset$subject <- factor(subject$subject, levels = 1:30)
datamelt <- melt(dataset,id=c("subject","activity"))
newDataset <- dcast(datamelt, subject + activity ~ variable,mean)
#write the new data into a txt file.
write.table(newDataset, file = "tidyData.txt",sep="\t",row.names=F)