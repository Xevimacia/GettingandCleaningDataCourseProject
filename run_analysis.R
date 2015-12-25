# You should create one R script called run_analysis.R that does the following. 
# 1. Merges the training and the test sets to create one data set.
# 2. Extracts only the measurements on the mean and standard deviation for each measurement. 
# 3. Uses descriptive activity names to name the activities in the data set
# 4. Appropriately labels the data set with descriptive variable names. 
# 5. From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.

# Set working directory
setwd("C:/Users/xavier.macia/Documents/Coursera")

####### LOAD LIBRARIES

# install.packages("data.table") # to run this if package is not already installed
# load data.table library for reading the data
library(data.table)

# install.packages("reshape2") # to run this if package is not already installed
# load reshape2 tool for melt() and dcast() operations.
library(reshape2)

####### LOAD "FEATURES" AND "ACTIVITY_LABELS" DATA SETS 

# Read second column of "features.txt", which contains the information of the column names of "x_test" and "x_train"
features <- read.table("DataTidy/UCI HAR Dataset/features.txt")[,2]

# Read second column of "activity_labels", which contains the descriptive information of activities 
activity_labels <- read.table("DataTidy/UCI HAR Dataset/activity_labels.txt")[,2]

####### LOAD AND MANIPULATE "TEST" DATA SETS 

######## Read test data sets -> "x_test", "y_test" and "subject_test" data sets  
x_test <- read.table("DataTidy/UCI HAR Dataset/test/X_test.txt")
y_test <- read.table("DataTidy/UCI HAR Dataset/test/y_test.txt")
subject_test <- read.table("DataTidy/UCI HAR Dataset/test/subject_test.txt")

# Edit the column names of "x_test" data set
names(x_test) = features

# get only columns with mean() or std() in their names
mean_and_std_features <- grepl("(mean|std)\\(\\)", features) # \\ must be added for the reserved operators in R
# subset the desired columns of "x_test" data set
x_test <- x_test[,mean_and_std_features]

# Load activity labels to "y_test"
y_test[,2] = activity_labels[y_test[,1]]

# Rename columns of "y_test"
names(y_test) = c("activity_id", "activity_Label")

# Rename columns of "subject_test"
names(subject_test) = "subject"

# Bind all the 3 data sets by column in the following order "subject_test", "y_test" and "x_test"
binded_test_data <- cbind(subject_test, y_test, x_test)

####### LOAD AND MANIPULATE "TRAIN" DATA SETS 

######## Read training data sets -> "x_train", "y_train" and "subject_train" data sets  
x_train <- read.table("DataTidy/UCI HAR Dataset/train/X_train.txt")
y_train <- read.table("DataTidy/UCI HAR Dataset/train/y_train.txt")
subject_train <- read.table("DataTidy/UCI HAR Dataset/train/subject_train.txt")

# Edit the column names of "x_train" data set
names(x_train) = features

# subset the desired columns of "x_train" data set
x_train <- x_train[,mean_and_std_features]

# Load activity labels to "y_train"
y_train[,2] = activity_labels[y_train[,1]]

# Rename columns of "y_train"
names(y_train) = c("activity_id", "activity_Label")

# Rename columns of "subject_train"
names(subject_train) = "subject"

# Bind all the 3 data sets by column in the following order "subject_train", "y_train" and "x_train"
binded_train_data <- cbind(subject_train, y_train, x_train)

####### MERGE "TEST" AND "TRAIN" DATA SETS AND CREATE TIDY DATA FILE

# Merge test and train data by row into one data set
total_data = rbind(binded_test_data, binded_train_data)

# define ID variables for the melt function
id_variables = c("subject", "activity_id", "activity_Label")
# define vector of measured variables (= remove id_variables)
measured_variables = setdiff(colnames(total_data), id_variables)

# Use melt function to convert wide data to long data
# to calculate mean by subject, activity label ("LAYING","SITTING",etc)
# and features ("tBodyAcc-mean()-X", "tBodyAcc-mean()-Y",etc) data using dcast() function
melted_data = melt(total_data, id = id_variables, measure.vars = measured_variables)

# Calculate the mean function from "melted_data" data set using dcast() function
my_tidy_data = dcast(melted_data, subject + activity_Label ~ variable, mean)

####### WRITE TIDY DATA TO TXT
# Save the "my_tidy_data" data set to "tidy_data.txt" file
write.table(my_tidy_data, file = "DataTidy/UCI HAR Dataset/my_tidy_data.txt", row.name=FALSE)
