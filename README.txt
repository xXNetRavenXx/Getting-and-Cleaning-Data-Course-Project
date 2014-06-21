==================================================
Tidy data sets for analysis from Human Activity Recognition Using Smartphones Dataset
==================================================
Processed by: Austin Kearly

----------------------------
Data Sources
----------------------------
Original data source: http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones
Data set used pre-processing:https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip 

Data used in tidy sets:
	* 'features.txt': List of all features.
	* 'activity_labels.txt': Links the class labels with their activity name.
	* 'train/X_train.txt': Training set.
	* 'train/y_train.txt': Training labels.
	* 'test/X_test.txt': Test set.
	* 'test/y_test.txt': Test labels.
----------------------------
Data proccessing
----------------------------
tidyDataSet1
The data was proccess using R, first extracting all data, making meaningful column names, then combining all test subjects with the activities they 
were involved in during the study for both testing and training. Afterwards combining the results for both testing and training and subsetting the 
data to only give results for the mean and standard deviation results and combining subjects and activities to the dataset.

tidyDataSet2:
Using the subsetting data from before I pivoted the table to show the average of each variable by each subject and the activies they were evaluated on.

----------------------------
Scripts
----------------------------
The original scripts used to obtain the data and create the two tidy datasets are included (run_analysis.R)
