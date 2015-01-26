# Introduction 

Data Source: 
The data for this project can be downloaded from https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip

A full description of the source data is avaiable at http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones

# Data Files & directories

After unzipping the source data, the contents of the directory/folder 'UCI HAR dataset' are copied to a directory/folder called 'data' in the working directory of the R environment.

# run_analysis.R and its variables
Please note, the use of the melt function in run_anaysis.R requires use of the reshape2 package.
Here is the sequence of the steps performed,and associated variables :

### Step 1 : Merges the training and the test sets to create one data set

X_train.txt, y_train.txt and subject_train.txt are read from the "./data/train" folder and stored in trainingData, trainingLabel and trainingSubject variables

X_test.txt, y_test.txt and subject_test.txt are read from the "./data/test" folder and stored  testData, testLabel and testSubject variables respectively.

trainingData and testData are bound to create mergedData; trainingLabel and testLabel are bound to create mergedLabel ; trainingSubject and testSubject arebound to create mergedSubject 

### Step 2: Extracts only the measurements on the mean and standard deviation for each measurement. 

The variable, features is read in from the  "./data/features.txt". 
Using the column descriptions from features, and an index variable(mean_and_std_Indices), the
dataset mergedData is updated to only include columns relevant to Mean and Standard_deviation. 
66 columns that are relevant to Mean and Standard deviation are preserved.

The column names of mergedData are updated to remove Parentheses and hyphens. 'mean' and 'std' are changed to 'Mean' and 'Std' respectively- these changes were intended to improve readability of the output file.

### Step 3: Use descriptive activity names to name the activities in the data set

The variable activity is read from "./data/activity_labels.txt"
mergedLabel is updated to the appropriate activity_labels.
The column name of mergedLabel is changed to "ActivityName"

### Step 4: Appropriately labels the data set with descriptive variable names. 

The column name of mergedSubject is changed to "SubjectId"

The mergedSubject, mergedLabel and mergedData (representing subjects,activity and sensor data respectively)  are combined into one dataset called combinedData, using the cbind function in the following order (mergedSubject, mergedLabel, mergedData)

### Step5: From the data set in step 4, create a second, independent tidy data set with the average of each variable for each activity and each subject.

A variable, idList is initialized with the column indices for id columns(SubjectId and ActivityName) for combinedData
A variable, variable list is initialized with the column indices for the variables present in combinedData

A variable, meltedData is created from combinedData using the id & variable indices above
The variable tidy_data_averages is created by casting meltedData (grouping by SubjectId & ActivityName, and calculating the mean for each of the other 66 variables)

30 subjects, with 6 activities each - and 66 variables results in an output data set of dimension (180 * 68) for this specific source data.  

The variable tidy_data_averages is written to a text file "./data/tidy_data_averages.txt" using the write.table function

