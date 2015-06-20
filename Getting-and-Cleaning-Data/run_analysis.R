# Getting and Cleaning Data Course Project
# ========================================
# You should create one R script called run_analysis.R that does the following. 
# Merges the training and the test sets to create one data set.
# Extracts only the measurements on the mean and standard deviation for each measurement. 
# Uses descriptive activity names to name the activities in the data set
# Appropriately labels the data set with descriptive variable names. 
# From the data set in step 4, creates a second, independent tidy data set with the 
# average of each variable for each activity and each subject.

library(dplyr)

# Use current directory or set WD
setwd('~/prg/data-science/data/Getting-and-Cleaning-Data/assignment-HAR/UCI HAR Dataset')

# Load meta information
features <- read.table('features.txt', stringsAsFactors=FALSE)
column.names <- cbind('subject', t(unlist(features$V2)), 'activity')

# 1. Merge the training and the test sets to create one data set
# We'll display a progress bar.
# ----------------------------------------------------------------------
cat('Loading data, please be patient...\n')
prbar <- txtProgressBar(0, 7, initial=1, style=3)  # show progress

# Load and merge test data
test.subject <- read.table('test/subject_test.txt', stringsAsFactors=FALSE)
test.set <- read.table('test/X_test.txt', stringsAsFactors=FALSE)
setTxtProgressBar(prbar, 2)
test.activity <- read.table('test/y_test.txt', stringsAsFactors=FALSE)
test.df  <- cbind(test.subject$V1, test.set, test.activity$V1)
setTxtProgressBar(prbar, 3)
names(test.df) <- column.names
rm('test.subject', 'test.set', 'test.activity')

# Load and merge training data
train.subject <- read.table('train/subject_train.txt', stringsAsFactors=FALSE)
train.set <- read.table('train/X_train.txt', stringsAsFactors=FALSE)
setTxtProgressBar(prbar, 4)
train.activity <- read.table('train/y_train.txt', stringsAsFactors=FALSE)
train.df <- cbind(train.subject$V1, train.set, train.activity$V1)
setTxtProgressBar(prbar, 5)
names(train.df) <- column.names
rm('train.subject', 'train.set', 'train.activity')

# Merge the two data sets
setTxtProgressBar(prbar, 6)
HAR.df <- rbind(train.df, test.df)  # merge the two sets
HAR <- as_data_frame(HAR.df)  # make it a dplyr data frame
rm('train.df', 'test.df', 'HAR.df')

setTxtProgressBar(prbar, 7)
close(prbar)

# 2. Extract only the measurements on the mean and standard deviation for
#    each measurement. => I'll go for "...-mean(" and "...-std(".
#    See the README file for explanation.
# ----------------------------------------------------------------------
ms.inx <- grep('(mean|std)[(]', names(HAR), ignore.case=TRUE, value=FALSE)
ms <- grep('(mean|std)[(]', names(HAR), ignore.case=TRUE, value=TRUE)
names(HAR) <- 1:ncol(HAR)  # avoid [duplicate column names]-error
HAR <- select(HAR, 1, ms.inx, ncol(HAR))

# 4. Appropriately label the data set with descriptive variable names 
# ----------------------------------------------------------------------
ms <- gsub("[()]", "", ms)
names(HAR) <- c('subject', ms, 'activity')

# 3. Use descriptive activity names to name the activities in the data set.
# We transform the integer values by strings (lowercase variants) and
# factorize the column.
# ----------------------------------------------------------------------
activities <- read.table('activity_labels.txt', stringsAsFactors=FALSE)
activities <- sapply(activities$V2, function(act) {
  sub('(.+)', '\\L\\1', act, perl=TRUE)   # make activity names lowercase
})
HAR <- HAR %>%
  mutate(activity=activities[activity]) %>%
  mutate(activity=factor(activity))

# 5. From the data set in step 4, creates a second, independent tidy
#    data set with the average of each variable for each activity and
#    each subject.
# ----------------------------------------------------------------------
HAR.avgs <- HAR %>%
  group_by(activity, subject) %>%
  summarise_each(funs(mean))
mms <- paste("Mean-", ms, sep="")
names(HAR.avgs) <- c('activity', 'subject', mms)

cat('Result is: HAR.avgs\n')
cat('Exporting to TXT..')
write.table(HAR.avgs, file="HAR-avgs.txt", quote=FALSE, row.names=FALSE)
cat('.done\n')
