# Introduction
The script run_analysis.R perform the following
1. download the zipped data file, unzip the data in UCI HAR Dataset folder.
2. Merges the training and the test sets using rbing() function and create one data set
3. Extract only those columns that has measured only mean and std.deviation. After data extraction correct names are given to dataset from features.txt
4. Read the activity_labels.txt and takes the activities names.
5. Merge the complete training, test and subject data set.
6. Create a tidy data set with the average of each variable for each activity and each subject

# Variables
1. x.train, y.train, x.test, y.test, subj.train and subj.test contain the training, test and subject data from the downloaded files.
2. dataset.x, dataset.y, dataset.subject contain the merged data.
3. features holds the correct names for x dataset.
4. MeanStdOnly contain the only mean and standard deviation columns.
5. activity_labels contain activity data from downloaded files.
6. dataset.complete used to hold the combined values craeted from dataset x, y and subject
7. tidy_dataset contains the relevant averages data of each variables.

