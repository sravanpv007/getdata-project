
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

# SAVE THE TIDY DATASET
write.table(combo.tidy,"tidy.txt")

