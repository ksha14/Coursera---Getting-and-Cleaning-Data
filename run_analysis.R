##coursera getting-and-cleaning-data-course-project

library(plyr)

#function to download the external data
download.data = function(){
  
  if (!file.exists("./UCI HAR Dataset")){
    fileURL ="https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
    
    message("Downloading Data files")
    download.file(url = fileURL, destfile = "./UCI HAR Dataset.zip")
    
    message("Un-zip Data File")
    unzip('./UCI HAR Dataset.zip')
  }
}


#function to merge the data
create.datasets = function(){
  #Reading training Data
  x.train <- read.table('./UCI HAR Dataset/train/X_train.txt')
  y.train <- read.table('./UCI HAR Dataset/train/y_train.txt')
  
  #reading Test data
  x.test <- read.table('./UCI HAR Dataset/test/X_test.txt')
  y.test <- read.table('./UCI HAR Dataset/test/y_test.txt')
  
  #reading Subject data
  subj.train <- read.table('./UCI HAR Dataset/train/subject_train.txt')
  subj.test <- read.table('./UCI HAR Dataset/test/subject_test.txt')
  
  dataset.x <- rbind(x.train, x.test)
  dataset.y <- rbind(y.train, y.test)
  dataset.subject <- rbind(subj.train, subj.test)
  
  #return merged traing and test dataset
  list(x=dataset.x, y=dataset.y, subject=dataset.subject)
  
}


#Download data files
download.data()


#Step 1:
message("Merges the training and the test sets to create one data set.")
#call create.datasets function to merge training and test data

datasets <- create.datasets()


#Step 2:
message("Extracts only the measurements on the mean and standard deviation for each measurement.")

features <- read.table('./UCI HAR Dataset/features.txt')
MeanStdOnly <- grep("mean\\(\\)|std\\(\\)", features[,2]);MeanStdOnly
datasets$x<- datasets$x[,MeanStdOnly]
names(datasets$x) <-features[MeanStdOnly,2]


#Step 3:
message("Uses descriptive activity names to name the activities in the data set")

activity_labels <- read.table('./UCI HAR Dataset/activity_labels.txt')
datasets$y[,1] <- activity_labels[datasets$y[,1], 2]
names(datasets$y) <-"activity"


#Step 4:
message("Appropriately labels the data set with descriptive variable names")

names(datasets$subject) <- "subject"
dataset.complete <- cbind(datasets$x, datasets$y, datasets$subject)


#Step 5:
message("From the data set in step 4, creates a second, independent tidy data set with the 
        average of each variable for each activity and each subject.")

tidy_dataset <- ddply(dataset.complete, .(subject, activity), function(x) colMeans(x[, 1:66]))
write.table(tidy_dataset, "./tidy_data.txt", row.name=FALSE)

