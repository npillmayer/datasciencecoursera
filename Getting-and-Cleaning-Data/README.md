Getting and Cleaning Data
=========================

Course Project: Human Activity Recognition (HAR)
------------------------------------------------

Files:
------

* run_analysis.R
* CodeBook.md
* README.md (this file)
* HAR-avgs.txt

Howto:
------

The script `run_analysis.R` operates on the UCI HAR Dataset
(see the Coursera page for *Getting and Cleaning Data*).
Either put the dataset in the current directory or uncomment
the `setwd()`-Line in the script and point it to the correct folder.
The script processes the input data and creates an output data_frame
`HAR.avgs`, which is exported immediately into a file 
`HAR-avgs.txt`.

### 1. Merge the training and the test sets to create one data set.

The script loads files under `test/` and `train/`.  Loading the files
will take some time, so please be patient. A textual progress bar
will be displayed.

The loaded tables will be merged using conventional R data frames.
Then, for further processing, this will be converted to a
'dplyr' data_frame.

### 2. Extract only the measurements on the mean and standard deviation for each measurement

The script extracts columns with the patterns "-mean(" and "-std(".
Approaching it with dplyr's `select()` does not work due to the method
dplyr uses for column name comparison.

### 4. Appropriately label the data set with descriptive variable names 

I find it easier to first label the columns and afterwards change the
activity-column's data type.

### 3. Use descriptive activity names to name the activities in the data set.

We transform the integer values by strings (lowercase variants) and
factorize the column.

### 5. From the data set in step 4, creates a second, independent tidy data set.

This is done easily using dplyr-means.
