# Code Book

This is a document to describe the script inside run_analysis.R

run_analysis.R script is structured as explained below (by comments):

* Load Libraries
* Load "Features" and "Activity_labels" Data Sets 
* Load and Manipulate "Test" Data Sets
* Load and Manipulate "Train" Data Sets
* Merge "Test" and "Train" Data Sets and Create Tidy Data File
* Write Tidy Data to TXT

## Load Libraries
Load data.table library for reading the data and reshape2 tool for melt() and dcast() operations.

## Load "Features" and "Activity_labels" Data Sets
Read second column of "features.txt", which contains the information of the column names of "x_test" and "x_train".
  * For instance, tBodyAcc-mean()-X, tBodyAcc-mean()-Y, tBodyAcc-mean()-Z, etc     

Read second column of "activity_labels", which contains the descriptive information of activities
  * WALKING, WALKING_UPSTAIRS, WALKING_DOWNSTAIRS, SITTING, STANDING

## Load and Manipulate "Test" Data Sets
* Read dataset files from UCI HAR to given name ("test") and prefix ("X", "y" and "subject").
  Examples:
    * UCI HAR Dataset/test/X_test.txt
    * UCI HAR Dataset/test/y_test.txt
    * UCI HAR Dataset/test/subject_test.txt
* Get only columns with mean() or std() in their names using grepl() to subset "x_test"
* Rename column names of "y_test" and "subject_test"
* Bind all the 3 data sets by column in the following order "subject_test", "y_test" and "x_test"

## Load and Manipulate "Train" Data Sets
* Read dataset files from UCI HAR to given name ("train") and prefix ("X", "y" and "subject").
  Examples:
    * UCI HAR Dataset/train/X_train.txt
    * UCI HAR Dataset/train/y_train.txt
    * UCI HAR Dataset/train/subject_train.txt
* Subset "x_train" by columns with mean() or std() in their names
* Rename column names of "y_train" and "subject_train"
* Bind all the 3 data sets by column in the following order "subject_train", "y_train" and "x_train"
 
##  Merge "Test" and "Train" Data Sets and Create Tidy Data File
* Define ID variables ("subject", "activity_id", "activity_Label") and measured variables (= remove id_variables) for the melt function
* Use melt function to convert wide data to long data. Used to calculate mean by subject, activity level ("LAYING","SITTING",etc) and features ("tBodyAcc-mean()-X", "tBodyAcc-mean()-Y",etc) data using dcast() function

The final data tidy looks like below:

    > head(my_tidy_data[, 1:6], n=8)
      subject     activity_Label tBodyAcc-mean()-X tBodyAcc-mean()-Y tBodyAcc-mean()-Z tBodyAcc-std()-X
    1       1             LAYING         0.2215982      -0.040513953        -0.1132036      -0.92805647
    2       1            SITTING         0.2612376      -0.001308288        -0.1045442      -0.97722901
    3       1           STANDING         0.2789176      -0.016137590        -0.1106018      -0.99575990
    4       1            WALKING         0.2773308      -0.017383819        -0.1111481      -0.28374026
    5       1 WALKING_DOWNSTAIRS         0.2891883      -0.009918505        -0.1075662       0.03003534
    6       1   WALKING_UPSTAIRS         0.2554617      -0.023953149        -0.0973020      -0.35470803
    7       2             LAYING         0.2813734      -0.018158740        -0.1072456      -0.97405946
    8       2            SITTING         0.2770874      -0.015687994        -0.1092183      -0.98682228

## Write Tidy Data to TXT
* Save the "my_tidy_data" data set to "tidy_data.txt" file
