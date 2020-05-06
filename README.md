## Getting and Cleaning Data - Course Project


This is the course project for the Getting and Cleaning Data Coursera course. The included R script, ```run_analysis.R```, does the following :

1. Download the dataset from web.
2. Read both the train and test datasets and merge them into x(measurements), y(activity) and subject, respectively.
3. Load the data's activity and feature info.
4. Extract columns named 'mean'(```-mean```) and 'standard'(```-std```). Also, modify column names to descriptive. (```-mean``` to ```Mean```, ```-std``` to ```Std```, and remove symbols like -, (, ))
5. Extract data by selected columns, and merge x, y(activity) and subject data. Also, replace y(activity) column to it's name by refering activity label.
6. Generate 'Tidy Dataset' that consists of the average (mean) of each variable for each subject and each activity. The result is shown in the file ```tidy_dataset.txt```.
