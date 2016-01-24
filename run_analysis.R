# Loading the required packages to perform tidy data 
# operation.
if (!library(data.table)) {
  install.packages(data.table)
}
if (!library(reshape2)) {
  install.packages(reshape2)
}

library(data.table)
library(reshape2)

# Load the name dataset.
activity_labels <- read.table("./UCI HAR Dataset/activity_labels.txt")[ ,2]

## Extracts only the measurements on the mean and
## standard deviation for each measurement.

# Filter out the mean and std. dev. from the features var.
features <- read.table("./UCI HAR Dataset/features.txt")[ ,2]
features_mean_std <- grepl("mean|std", features)

# Processing the test dataset:
# a) Add column names to the numerical dataset Test_set:
Test_set <- read.table("./UCI HAR Dataset/test/X_test.txt")
colnames(Test_set) <- features
# Extract mean and std. dev. from the test set by using the
# features_mean_std and replace it to Test_set.
Test_set <- Test_set[ ,features_mean_std]

# b) Loading the Test_subject data
Test_subject <- read.table("./UCI HAR Dataset/test/subject_test.txt")
colnames(Test_subject) <- "Subject"

# c) Add label names into the Test_label from activity_labels
Test_label <- read.table("./UCI HAR Dataset/test/y_test.txt")
Test_label[ ,2] <- activity_labels[Test_label[ ,1]]
colnames(Test_label) <- c("Activity_ID", "Activity_Label")

# Column bind the test data
test_data <- cbind(Test_subject, Test_label, Test_set)


# Processing the training dataset:
# a) Add column names to the numerical dataset Train_set:
Train_set <- read.table("./UCI HAR Dataset/train/X_train.txt")
colnames(Train_set) <- features
# Extract mean and std. dev. from the training set by using the
# features_mean_std and replace it to Train_set.
Train_set <- Train_set[ ,features_mean_std]

# b) Loading the Train_subject data
Train_subject <- read.table("./UCI HAR Dataset/train/subject_train.txt")
colnames(Train_subject) <- "Subject"

# c) Add label names into the Train_label from activity_labels
Train_label <- read.table("./UCI HAR Dataset/train/y_train.txt")
Train_label[ ,2] <- activity_labels[Train_label[ ,1]]
colnames(Train_label) <- c("Activity_ID", "Activity_Label")

# Column bind the training data
train_data <- cbind(Train_subject, Train_label, Train_set)

## Full data: Merges the training and the test sets
## to create one dataset.
Full_data <- rbind(test_data, train_data)

## Appropriately labels the dataset with
## descriptive variable names.

## Note: In my opinion, the variable names 
## in original dataset is easy to understand:
## e.g. 'tBodyAcc-mean()-X', 'fBodyAccMag-std()'.
## So I didn't make any change for these variable 
## names, and keep the original variable names.

# Save the Full_data into a file
write.table(Full_data, file = "./Full_data.txt", row.names = FALSE)


## From the dataset in step 4,creates a second, independent tidy dataset 
## with the average of each variable for each activity
## and each subject.

# Convert the full data into long format
melt_data <- melt(Full_data, c("Subject", "Activity_ID", "Activity_Label"))

# Convert the melt data into column format, each
# variable is displayed into column, and then calculate
# the mean for each variable
avg_tidy_data <- dcast(melt_data, Subject + Activity_Label ~ variable, mean)

# Save the tidy data into working directory:
write.table(avg_tidy_data, file = "./avg_tidy_data.txt", row.names = FALSE)
