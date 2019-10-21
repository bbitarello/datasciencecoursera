This is a final programming assingment for the Data Analysis Specialization Course "Getting and cleaning data".

The assignment consists in using the data provided here (http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones) to use the acquired skills in this course and produce a tidy data set for further analysis.

Specifically, this consists of combining multiple files into one dataset as follows.


1. Merge tests and train subjects: in total, there is data for 70 subjects in the 'train' dataset and 30 subjects in the 'test'dataset. For this analysis we want to merge them, regardless of rather they were assigned to the 'train'or test groups. This is done in the first part of the run_analysis.R script by combining the observations from test/X_test.txt and train/X_train.txt

2. Extracts only the measurements on the mean and standard deviation for each measurement: the labels for these two dataset columns are in features.txt. Only columns containing the word 'Mean' and 'std'were selected.

3.Uses descriptive activity names to name the activities in the data set: for this data from activity_labels.txt was used.

4. Appropriately labels the data set with descriptive variable names: see Codebook.md

5. From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.: see tidy_data.txt
Run the script below to produce a tidy data set:

```
Rscript --vanilla run_analysis.R
```

