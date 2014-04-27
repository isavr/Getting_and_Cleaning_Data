Here are the data for the project: 
https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip

A full description is available at the site where the data was obtained: 
http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones 

The attached R script (run_analysis.R) performs following actions to tidy up the data:

  1. Merges the training and test sets to create one data set
  2. Reads file features.txt and extracts only the measurements on the mean and standard deviation for each measurement.
  3. Reads activity_labels.txt and applies descriptive activity names to name the activities in the data set
    
    WALKING
    WALKING_UPSTAIRS
    WALKING_DOWNSTAIRS
    SITTING
    STANDING
    LAYING

  4. The script also appropriately labels the data set with descriptive names: brackets, hyphens are transformed to underscores. If more than 1 underscore lie together, only 1 is left.
    Example of column names:
      "Subject"
      "Activity"
      "tBodyAcc_mean_X"
      "tBodyAcc_mean_Y"
      "tBodyAcc_mean_Z"
      "tBodyAcc_std_X"
      "tBodyAcc_std_Y"
      "tBodyAcc_std_Z"
      "tGravityAcc_mean_X"
  5. The script creates a 2nd, independent tidy data set with the average of each measurement for each activity and each subject.
