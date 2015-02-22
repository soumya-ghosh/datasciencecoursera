# Step1. Merges the training and the test sets to create one data set.

trainData <- read.table("./data/train/X_train.txt")
trainLabel <- read.table("./data/train/y_train.txt")
trainSubject <- read.table("./data/train/subject_train.txt")

testData <- read.table("./data/test/X_test.txt")
testLabel <- read.table("./data/test/y_test.txt")
testSubject <- read.table("./data/test/subject_test.txt")

joinData <- rbind(trainData, testData)
joinLabel <- rbind(trainLabel, testLabel)
joinSubject <- rbind(trainSubject, testSubject)

# Step2. Extracts only the measurements on the mean and standard
# deviation for each measurement.
features <- read.table("./data/features.txt")
meanStdIndices <- grep("mean|std", features[, 2])
joinData <- joinData[, meanStdIndices]
names(joinData) <- gsub("\\(\\)", "", features[meanStdIndices, 2]) # remove "()"
names(joinData) <- gsub("-", "_", names(joinData)) # replace - with _ in column names

# Step3. Uses descriptive activity names to name the activities in
# the data set
activity <- read.table("./data/activity_labels.txt")
activity[, 2] <- gsub("_", " ", activity[, 2])
activityLabel <- activity[joinLabel[, 1], 2]
joinLabel[, 1] <- activityLabel
names(joinLabel) <- "ACTIVITY"

# Step4. Appropriately labels the data set with descriptive activity
# names.
names(joinSubject) <- "SUBJECT"
joinData <- cbind(joinSubject, joinLabel, joinData)

write.table(joinData, "merged_data.txt") # write out the 1st dataset


# Step5. Creates a second, independent tidy data set with the average of
# each variable for each activity and each subject.
library(reshape2)

melt_data <- melt(joinData, id = colnames(joinData)[1:2], 
                  measure.vars = colnames(joinData)[3:ncol(joinData)])

data_with_means = dcast(melt_data, SUBJECT + ACTIVITY ~ variable, mean)

write.table(data_with_means, "data_with_means.txt") # write out the 2nd dataset
