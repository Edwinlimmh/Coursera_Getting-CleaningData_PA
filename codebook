## Codebook:

This tidy data process require the data.table and reshape2 package. Make sure your R working directory contains the folder UCI HAR Dataset before executing the code in the run_script.R file.
Please look at the run_script.R file for more detail comments and the code. The overall process of tidy data is as follows:

1.	Load the name dataset from the file activity_labels.txt.
2.	Extracts only the measurements on the mean and standard deviation for each measurement. The extracting process is based on the features.txt file, and the filtering processing is done by the grepl() function, the results is saved into a variable and used to extract the mean and standard deviation.
3.	Processing the test dataset and the training dataset:
  a.	Add column names to the raw numerical dataset and then extract only the mean and standard deviation.
  b.	Processing the subject (person named as number) data.
  c.	Add activity label names.
  d.	Column bind.
4.	Merge both training and the test dataset into one complete and full dataset.
5.	In my opinion, the variable names in original dataset is easy to understand: e.g. 'tBodyAcc-mean()-X', 'fBodyAccMag-std()'. So I didn't make any change for these variable names, and keep the original variable names.
6.	Save the full complete tidy data into a file named Full_data.txt
7.	Based on the full complete tidy data, I create a second, independent tidy dataset which have the average of each variable for each activity and each subject: 
  a.	Convert the full data into long format (melt data)
  b.	Using the dcast() function to calculate and return another tidy dataset
  c.	Save the file into a file named avg_tidy_data.txt


