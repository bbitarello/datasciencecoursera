#!/usr/bin/env Rscript

library(data.table)
library(dplyr)
library(readr)

#Merges the training and the test sets to create one data set.
#Extracts only the measurements on the mean and standard deviation for each measurement.
test<-fread('test/X_test.txt')
train<-fread('train/X_train.txt')
features<-fread('features.txt')[,V2]
paste(seq(1: length(features)), features, sep="_")-> features
colnames(train)<-features
colnames(test)<-features

fread('train/y_train.txt')-> train_labels
fread('test/y_test.txt')-> test_labels
fread('train/subject_train.txt')$V1-> subj_train_labels
fread('test/subject_test.txt')$V1-> subj_test_labels
select(train, contains('Mean'))-> train
select(test, contains('Mean'))-> test

train[, Activity_Labels:=train_labels]
test[, Activity_Labels:=test_labels]

test[, Group:='test']
train[, Group:='train']

rbind(test,train)-> combined
combined[, Subject_ID:=c(subj_test_labels, subj_train_labels)]

fread('activity_labels.txt')-> act_labels

#Uses descriptive activity names to name the activities in the data set
cat('checkpoint 1\n')
combined[,Activity_Labels:=ifelse(Activity_Labels==1, 'WALKING',ifelse(Activity_Labels==2, 'WALKING_UPSTAIRS', ifelse(Activity_Labels==3, 'WALKING_DOWNSTAIRS', ifelse(Activity_Labels==4, 'SITTING', ifelse(Activity_Labels==5, 'STANDING', 'LAYING')))))]



cat('checkpoint 2\n')
#From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.
combined[, Group:=NULL]
combined %>% group_by(Subject_ID, Activity_Labels) %>% select(contains('Mean')) %>% summarise_each(mean) %>% as.data.table-> final

#Appropriately labels the data set with descriptive variable names.

gsub("mean\\(\\)","mean",gsub("tGravity", "EuclideanNorm",gsub("tBody", "EuclideanNorm", gsub("fBody", "FastFourierTransformBody",gsub("Acc", "Acceleration", names(final))))))-> names(final)

cat('checkpoint 3\n')
write.table(final,file='tidy_data.txt', row.names=F)
