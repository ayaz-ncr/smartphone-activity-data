
# Analysis steps to create one tidy data set from smartphone activity data files:

1 set working directory

2 check if the data folder exists and download data file

3 Unzip file

4 read the activity labels data, give descriptive column names and convert activity_id from numeric to factor

5 read the features data, give descriptive column names

6a read the subject train data, give descriptive column names and convert subject_id from numeric to factor

6b read the X_train data, give descriptive column names

6c read the y_train data, give descriptive column names and convert activity_id from numeric to factor

6d read the subject_test data, give descriptive column names and convert subject_id from numeric to factor

6e read the X_test data, give descriptive column names

6f read the y_test data, give descriptive column names and convert activity_id from numeric to factor

7 combine (column bind) subject_train, X_train, y_train data to get training data - activity, subject and all variables in one data set

8 combine (column bind) subject_test, X_test, y_test data to get test_data - activity, subject and all variables in one data set

9 combine (row bind) training and test data to get full_data in a single dataset

10 merge activity labels with full data obtained in last step to display activity name instead of activity id

11 filter the dataset to include only mean and std measurements

12 read data into a data table, get average of each variable by activity and subject

13 write the data table to a txt file (tidy_data.txt)

14 check the tidy data txt file validity by reading back into data table
