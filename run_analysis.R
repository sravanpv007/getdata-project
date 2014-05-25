
# Merges the training and the test sets to create one data set.
# LOAD THE DATA
features <- read.table("./dataset/features.txt", col.names=c("id","name"))

train.set <- read.table("./dataset/train/X_train.txt", col.names=features$name)
train.labels <- read.table("./dataset/train/y_train.txt", col.names=c("activity.id"))
train.subject <- read.table("./dataset/train/subject_train.txt", col.names=c("subject.id"))

# LOAD THE DATA
test.set <- read.table("./dataset/test/X_test.txt", col.names=features$name)
test.labels <- read.table("./dataset/test/y_test.txt", col.names=c("activity.id"))
test.subject <- read.table("./dataset/test/subject_test.txt", col.names=c("subject.id"))

# Extracts only the measurements on the mean and standard deviation for each measurement.
# SUBSET THE DATASETS
nm <- colnames(train.set)
mean_or_std <- grepl("(mean|std)\\.\\.", nm)
train.subset <- train.set[mean_or_std]
test.subset <- test.set[mean_or_std]

# CREATE NEW VARIABLES
# Activity Id
train.subset$activity.id <- train.labels$activity.id
test.subset$activity.id <- test.labels$activity.id
# Subject Id
train.subset$subject.id <- train.subject$subject.id
test.subset$subject.id <- test.subject$subject.id
# Origin
train.subset$origin <- "train"
test.subset$origin <- "test"

# COMBINE THE DATASETS
combo.sets <- rbind(train.subset,test.subset)



# Uses descriptive activity names to name the activities in the data set
# Appropriately labels the data set with descriptive activity names.
# LOAD DATA
activity.labels <- read.table("./dataset/activity_labels.txt", col.names=c("activity.id","activity.label"))
combo.sets <- merge(combo.sets,activity.labels, by="activity.id")


# Creates a second, independent tidy data set with the average of each variable for each activity and each subject.
library(reshape2)
nm.combo <- colnames(combo.sets)[!(nm.combo %in% c("activity.id","subject.id","origin","activity.label"))]
combo.melt <- melt(combo.sets, id=nm.combo, measure.vars=c("activity.id","subject.id"))


combo.tidy <- dcast(combo.melt, nm.combo ~ variable, mean)

# HUMAN READABLE NAMES
names <- c("Mean of time domain body acceleration signal of X"
  , "Mean of time domain body acceleration signal of Y"
  , "Mean of time domain body acceleration signal of Z"
  , "Standard deviation of time domain body acceleration signal of X"
  , "Standard deviation of time domain body acceleration signal of Y"
  , "Standard deviation of time domain body acceleration signal of Z"
  , "Mean of frequency domain linear acceleration of X"
  , "Mean of frequency domain linear acceleration of Y"
  , "Mean of frequency domain linear acceleration of Z"
  , "Standard deviation of frequency domain linear acceleration of X"
  , "Standard deviation of frequency domain linear acceleration of Y"
  , "Standard deviation of frequency domain linear acceleration of Z"
  , "Mean of frequency domain body acceleration signal magnitude"
  , "Standard deviation of frequency domain body acceleration signal magnitude"
  , "Mean of fBodyBodyAccJerkMag"
  , "Standard deviation of fBodyBodyAccJerkMag"
  , "Mean of fBodyBodyGyroJerkMag"
  , "Standard deviation of fBodyBodyGyroJerkMag"
  , "Mean of fBodyBodyGyroMag"
  , "Standard deviation of fBodyBodyGyroMag"
  , "Mean of fBodyGyro of X"
  , "Mean of fBodyGyro of Y"
  , "Mean of fBodyGyro of Z"
  , "Standard deviation of fBodyGyro of X"
  , "Standard deviation of fBodyGyro of Y"
  , "Standard deviation of fBodyGyro of Z"
  , "Mean of tBodyAcc of X"
  , "Mean of tBodyAcc of Y"
  , "Mean of tBodyAcc of Z"
  , "Standard deviation of tBodyAcc of X"
  , "Standard deviation of tBodyAcc of Y"
  , "Standard deviation of tBodyAcc of Z"
  , "Mean of tBodyAccJerk of X"
  , "Mean of tBodyAccJerk of Y"
  , "Mean of tBodyAccJerk of Z"
  , "Standard deviation of tBodyAccJerk of X"
  , "Standard deviation of tBodyAccJerk of Y"
  , "Standard deviation of tBodyAccJerk of Z"
  , "Mean of tBodyAccJerkMag"
  , "Standard deviation of tBodyAccJerkMag"
  , "Mean of tBodyAccMag"
  , "Standard deviation of tBodyAccMag"
  , "Mean of tBodyGyro of X"
  , "Mean of tBodyGyro of Y"
  , "Mean of tBodyGyro of Z"
  , "Standard deviation of tBodyGyro of X"
  , "Standard deviation of tBodyGyro of Y"
  , "Standard deviation of tBodyGyro of Z"
  , "Mean of tBodyGyroJerk of X"
  , "Mean of tBodyGyroJerk of Y"
  , "Mean of tBodyGyroJerk of Z"
  , "Standard deviation of tBodyGyroJerk of X"
  , "Standard deviation of tBodyGyroJerk of Y"
  , "Standard deviation of tBodyGyroJerk of Z"
  , "Mean of tBodyGyroJerkMag"
  , "Standard deviation of tBodyGyroJerkMag"
  , "Mean of tBodyGyroMag"
  , "Standard deviation of tBodyGyroMag"
  , "Mean of tGravityAcc of X"
  , "Mean of tGravityAcc of Y"
  , "Mean of tGravityAcc of Z"
  , "Standard deviation of tGravityAcc of X"
  , "Standard deviation of tGravityAcc of Y"
  , "Standard deviation of tGravityAcc of Z"
  , "Mean of tGravityAccMag"
  , "Standard deviation of tGravityAccMag")

# SAVE THE TIDY DATASET
write.table(combo.tidy,"tidy.txt")

