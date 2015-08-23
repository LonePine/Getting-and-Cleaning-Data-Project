
title: "Coursera-Getting-and-Cleaning-Data-Project/README.md"
author: "LonePine"
date: "August 16, 2015"
output: word_document

This is the markdown file that gives a summary of the run_analysis.R file that was written in RScript to create a tidy data set from the dataset given for the course project. The following steps were followed to generate the clean data set:
1. Load the project file in the working directory from the link below and unzip the file.

   https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip

2. Load the activity labels and the features labels from the text files in the UCI HAR Dataset.

3. Load the training and test data sets according to activity and subject.

4. Extract the indices for mean and standard deviation and subset only those variables from the  data from the features dataset.Clean the labels further by removing'()', and substituting 'M' for 'm' and 'S' for 's'.
 
5. Extract only the columns for mean and standard deviation values for training and test datasets.

6. Column bind the activity, subject data for mean and std deviation for test data and training data to make 'train' and 'test' datasets.

7. Rowbind and combine the training and test datasets into one single dataset,'joindata'.Assign columnnames for 'joindata'.

8. Change activity and subject into factors.

9. Find the mean of the single dataset for activity and subject variables.

10. Write the data into a table tidydata.txt.

