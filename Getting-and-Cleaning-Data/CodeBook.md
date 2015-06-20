Code Book
====================

This page builds on top of information provided by the
[UCI page](http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones#)
for the HAR data set.  Please consult this page, if you have not yet done so.

Dataset Columns
--------------------

### Output variable

* activity: one of "laying", "sitting", "standing", "walking", "walking_downstairs", "walking_upstairs"

### qualitative variable

* subject: test person's ID, 1..30

### numeric variables

* Mean-tBodyAcc-mean-X Mean-tBodyAcc-mean-Y Mean-tBodyAcc-mean-Z
* Mean-tBodyAcc-std-X Mean-tBodyAcc-std-Y Mean-tBodyAcc-std-Z
* Mean-tGravityAcc-mean-X Mean-tGravityAcc-mean-Y Mean-tGravityAcc-mean-Z
* Mean-tGravityAcc-std-X Mean-tGravityAcc-std-Y Mean-tGravityAcc-std-Z
* Mean-tBodyAccJerk-mean-X Mean-tBodyAccJerk-mean-Y Mean-tBodyAccJerk-mean-Z
* Mean-tBodyAccJerk-std-X Mean-tBodyAccJerk-std-Y Mean-tBodyAccJerk-std-Z
* Mean-tBodyGyro-mean-X Mean-tBodyGyro-mean-Y Mean-tBodyGyro-mean-Z
* Mean-tBodyGyro-std-X Mean-tBodyGyro-std-Y Mean-tBodyGyro-std-Z
* Mean-tBodyGyroJerk-mean-X Mean-tBodyGyroJerk-mean-Y Mean-tBodyGyroJerk-mean-Z
* Mean-tBodyGyroJerk-std-X Mean-tBodyGyroJerk-std-Y Mean-tBodyGyroJerk-std-Z
* Mean-tBodyAccMag-mean Mean-tBodyAccMag-std
* Mean-tGravityAccMag-mean Mean-tGravityAccMag-std
* Mean-tBodyAccJerkMag-mean Mean-tBodyAccJerkMag-std
* Mean-tBodyGyroMag-mean Mean-tBodyGyroMag-std
* Mean-tBodyGyroJerkMag-mean Mean-tBodyGyroJerkMag-std
* Mean-fBodyAcc-mean-X Mean-fBodyAcc-mean-Y Mean-fBodyAcc-mean-Z
* Mean-fBodyAcc-std-X Mean-fBodyAcc-std-Y Mean-fBodyAcc-std-Z
* Mean-fBodyAccJerk-mean-X Mean-fBodyAccJerk-mean-Y Mean-fBodyAccJerk-mean-Z
* Mean-fBodyAccJerk-std-X Mean-fBodyAccJerk-std-Y Mean-fBodyAccJerk-std-Z
* Mean-fBodyGyro-mean-X Mean-fBodyGyro-mean-Y Mean-fBodyGyro-mean-Z
* Mean-fBodyGyro-std-X Mean-fBodyGyro-std-Y Mean-fBodyGyro-std-Z
* Mean-fBodyAccMag-mean Mean-fBodyAccMag-std
* Mean-fBodyBodyAccJerkMag-mean Mean-fBodyBodyAccJerkMag-std
* Mean-fBodyBodyGyroMag-mean Mean-fBodyBodyGyroMag-std
* Mean-fBodyBodyGyroJerkMag-mean Mean-fBodyBodyGyroJerkMag-std

Numeric variables are means of variables of the original data set:
(tBodyAcc-XYZ-mean, ..., fBodyBodyGyroJerkMag-std) are mean and standard-deviation
values from measurement-values of the orignal data set. Thus the 
columns "Mean-..." refer to means-of-means and means-of-std.dev.
Only variables stemming from measurement-values are included.

Please refer to the UCI HAR web page for a description of the original
numeric variables.

Data Processing
---------------

Test- and training-set of the UCI HAR data set are merged, i.e., 
observations are appended, resulting in 10299 observations.

We are only interested in
* qualitative input variable: subject (ID of a test person)
* means and standard deviations of measurement input variables
* output variable: activity

The merged set is filtered for these columns, to a total of 68 columns
(67 input, 1 output). Columns are given meaningful names corresponding
to the names of the original data set, except for erasing the '()'.
Integer codes for activities are substituted by string values.

The data is then aggregated (forming a new data frame): We group by
activity and test person, and summarise each numeric column by
calculating the mean. Column names are changed by prepending "Mean-".
The final data frame is therefore a collection of means of means and
of means of standard deviations.


