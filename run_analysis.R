
# Merges the training and the test sets to create one data set.
activity_labels <- read.table("./dataset/activity_labels.txt", col.names=c("id","name"))
features <- read.table("./dataset/features.txt", col.names=c("id","name"))

x_train <- read.table("./dataset/train/X_train.txt", col.names=features$name)
y_train <- read.table("./dataset/train/y_train.txt", col.names=c("activity_id"))
subject_train <- read.table("./dataset/train/subject_train.txt", col.names=c("subject_id"))

x_test <- read.table("./dataset/test/X_test.txt", col.names=features$name)
y_test <- read.table("./dataset/test/y_test.txt", col.names=c("activity_id"))
subject_test <- read.table("./dataset/test/subject_test.txt", col.names=c("subject_id"))

# TODO: Make the x_train the columns and the y_train the labels of the columns in a new dataframe. The rows will be identified by features.
# TODO: merge the data frames by their common identifiers, namely the column names


# Extracts only the measurements on the mean and standard deviation for each measurement.

# Uses descriptive activity names to name the activities in the data set

# Appropriately labels the data set with descriptive activity names.

# Creates a second, independent tidy data set with the average of each variable for each activity and each subject.

