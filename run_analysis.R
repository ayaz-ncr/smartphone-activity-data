
# set working directory
setwd("C:/projects/17-coursera-DS/3-getting and cleaning data")

# download data file
if(!file.exists("data")){
  dir.create("data")
}
fileURL<-"https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
download.file(fileURL, destfile = "./data/activitydata.zip")
list.files("./data")
datadownloaded<-date()

#Unzip file
unzip("./data/activitydata.zip", exdir = "./data")


# read the activity labels data, give descriptive column names
# activity_id should be defined as factor (numeric to factor)
activity_labels<-read.table("./data/UCI HAR Dataset/activity_labels.txt", header = FALSE)
names(activity_labels)<-c("activity_id", "activity_name")
activity_labels$activity_id<-as.factor(activity_labels$activity_id)

# read the features data, give descriptive column names
features<-read.table("./data/UCI HAR Dataset/features.txt", header = FALSE)
names(features)<-c("feature_id", "feature_name")

# read the subject train data
# subject_id should be defined as factor (numeric to factor)
subject_train<-read.table("./data/UCI HAR Dataset/train/subject_train.txt", header = FALSE)
names(subject_train)<-"subject_id"
subject_train$subject_id<-as.factor(subject_train$subject_id)

# read the X_train data, give descriptive column names
X_train<-read.table("./data/UCI HAR Dataset/train/X_train.txt", header = FALSE)
names(X_train)<-features$feature_name

# read the y_train data, give descriptive column names
# activity_id should be defined as factor (numeric to factor)
y_train<-read.table("./data/UCI HAR Dataset/train/y_train.txt", header = FALSE)
names(y_train)<-"activity_id"
y_train$activity_id<-as.factor(y_train$activity_id)

# read the subject_test data, give descriptive column names
# subject_id should be defined as factor (numeric to factor)
subject_test<-read.table("./data/UCI HAR Dataset/test/subject_test.txt", header = FALSE)
names(subject_test)<-"subject_id"
subject_test$subject_id<-as.factor(subject_test$subject_id)

# read the X_test data, give descriptive column names
X_test<-read.table("./data/UCI HAR Dataset/test/X_test.txt", header = FALSE)
names(X_test)<-features$feature_name

# read the y_test data, give descriptive column names
# activity_id should be defined as factor (numeric to factor)
y_test<-read.table("./data/UCI HAR Dataset/test/y_test.txt", header = FALSE)
names(y_test)<-"activity_id"
y_test$activity_id<-as.factor(y_test$activity_id)

# combine (column bind) subject_train, X_train, y_train data to get training_data
training_data<-cbind(subject_train, X_train, y_train)

# combine (column bind) subject_test, X_test, y_test data to get test_data
test_data<-cbind(subject_test, X_test, y_test)

# combine (row bind) training and test data to get full_data
full_data<-rbind(training_data, test_data)

# merge activity labels with full data to display activity name 
full_data<-merge(activity_labels, full_data)

# filter mean and std measurements from full_data 
mean_std_data<-full_data[,c(1:3, grep("mean|std", colnames(full_data)))]

# read into a data table
library(data.table)
DT<-data.table(mean_std_data)

# get average of each variable by activity and subject
DT<-DT[, lapply(.SD, mean, na.rm=TRUE), by=DT$activity_name:DT$subject_id, .SDcols=4:ncol(DT)]

# write the data table to a txt file
write.table(DT, file="./data/tidy_data.txt", row.names = FALSE)

# check the tidy data txt file validity by reading back into data table
tidy_data<-read.table("./data/tidy_data.txt", header = TRUE)
