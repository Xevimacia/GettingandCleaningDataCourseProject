# Code Book

This is a document to describe the script inside run_analysis.R

run_analysis.R script is structured as explained below (by comments):

* Load Libraries
* Load "Features" and "Activity_labels" Data Sets 
* Load and Manipulate "Test" Data Sets
* Load and Manipulate "Train" Data Sets
* Merge "Test" and "Train" Data Sets and Create Tidy Data File
* Write final data to TXT

## Load Libraries
Load data.table library for reading the data and reshape2 tool for melt() and dcast() operations.

## Load "Features" and "Activity_labels" Data Sets
Read second column of "features.txt", which contains the information of the column names of "x_test" and "x_train". For instance, tBodyAcc-mean()-X, tBodyAcc-mean()-Y, tBodyAcc-mean()-Z, etc     
Read second column of "activity_labels", which contains the descriptive information of activities (WALKING, WALKING_UPSTAIRS, WALKING_DOWNSTAIRS, SITTING, STANDING)

## Load and Manipulate "Test" Data Sets
* Read dataset files from UCI HAR to given name ("train" and "test") and prefix ("X", "y" and "subject").
  Examples:
    * UCI HAR Dataset/train/X_test.txt
    * UCI HAR Dataset/train/y_test.txt
    * UCI HAR Dataset/train/subject_test.txt

