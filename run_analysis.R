# requires the use of melt function from the reshape2 package
library(reshape2)

# Step 1
# Merge the training and test sets to create one data set
###########################################################

# Read Training Data
trainingData <- read.table("./data/train/X_train.txt")
trainingLabel <- read.table("./data/train/y_train.txt")
trainingSubject <- read.table("./data/train/subject_train.txt")

# Read Test Data
testData <- read.table("./data/test/X_test.txt")
testLabel <- read.table("./data/test/y_test.txt")
testSubject <- read.table("./data/test/subject_test.txt")

# Merge Training and Test data
mergedData<-rbind(trainingData,testData)
mergedLabel<-rbind(trainingLabel,testLabel)
mergedSubject<-rbind(trainingSubject,testSubject)

# Step 2
# Extract only the measurements on the mean and standard deviation 
# for each measurement
##################################################################

features <- read.table("./data/features.txt")
mean_and_std_Indices <- grep ("-mean\\(\\)|-std\\(\\)", features[, 2])
mergedData <- mergedData[,mean_and_std_Indices]
names(mergedData) <- features[mean_and_std_Indices,2]

# Improve readability of column names 
names(mergedData) <- gsub("\\(\\)", "", names(mergedData))   # Remove parentheses
names(mergedData) <- gsub("-", "", names(mergedData))        # Remove hyphen
names(mergedData) <- gsub("mean", "Mean", names(mergedData)) # Change 'mean' to 'Mean'
names(mergedData) <- gsub("std", "Std", names(mergedData))   # Change 'std' to 'Std'

# Step 3
# Uses descriptive activity names to name the activities in the data set
########################################################################

activity <- read.table("./data/activity_labels.txt")

# decode the numeric labels to the ActivityName
mergedLabel[,1] <- activity[mergedLabel[,1],2]

# Provide a descriptive column name
names(mergedLabel) <- c("ActivityName")

# Step 4
# Appropriately label the data set with descriptive variable names
##################################################################

# Provide a descriptive column name
names(mergedSubject) <- c("SubjectId")

# Combine into one DataSet for step5 
combinedData <- cbind(mergedSubject,mergedLabel,mergedData)

# Step 5
# Create a tidy data set with the average of each variable 
# for each activity and each subject.
##################################################################

# Generate an index of id & variable columns for use with melt()
# first two columns are id columns, third column onwards are the vars

idList <- names(combinedData)[1:2]
variableList <- names(combinedData)[3:length(names(combinedData))]

# Melt & recast 
meltedData <- melt(combinedData,id=idList, measure.vars=variableList)
tidy_data_averages <- dcast(meltedData, SubjectId + ActivityName ~ variable, mean)

# Write a tidy data set with averages
write.table(tidy_data_averages, "tidy_data_with_averages.txt", row.name=FALSE)



