Cook Book for Human Activity Recognition Using Smartphones Dataset
---------
*Details about the dataset please refer to  [Human Activity Recognition Using Smartphones Dataset](https://)

Rountine fun_analysis.R is used to clean up the data and transform it into a new tidy dataset.   
The following procedures are done in sequence:

1. The code will first search the data folder "UCI HAR Dataset", which is the data source folder. If not, it will looking for the assigined zip filename in the assigined the file path. If there is no such a file, it will download the data from internet ([url: https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip](:https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip). 

2. Read the test and training data set, their subjects and activities, as well as features and activity_labels. 

3. Merges the training and the test data to create one data set. The result data frames are "dataset", "subject" and "label"  

4. Add the meaningful column names to the dataset, using features.

5. Find index of the mean and std columns. Using the index, update the "dataset"" with only the columns/variables that measure mean and standard deviations.

6. Translate the numeric label in "label" data into corresponding descriptive activity names and add it to the "label" data frame.

7. Add descriptive activity names in the "label" to the "dataset" as the factor "activity".

8. Adding "subject"" as another factor to "dataset"

9. Melt the dataset into "datamelt"

10. Recast the dataset using both "subject" and "activity" as id, and mean as the casting formula. The result is new data set "newDataset"

11. Write the "newDataset" into file "tidyData.txt" with no row name. number of columns: 68 (2 factors and 66 variables) number of rows: 180 (30 subjects and 6 activities)

The reuslt of this data cleaning analysis is to create a tidy data set with the average of each variable for each activity and each subject. 