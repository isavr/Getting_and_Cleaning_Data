
## check if file dir exists
	if (!file.exists("UCI HAR Dataset")){
   		##DOWNLOAD AND UNARCHIVE
		dirName <- "UCI HAR Dataset.zip" 
		download.file("http://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip", dirName, mode = "wb");
		unzip(dirName)
      }
## open files
## info files
	activityLabels<-read.table("UCI HAR Dataset/activity_labels.txt", header=FALSE)
	 allFeatures<-read.table("UCI HAR Dataset/features.txt", header=FALSE)
##renaming columns to something usable
	newNames<-gsub("(\\()|(\\))|\\,|\\-|(\\.+)","_",allFeatures[,2])
	newNames<-gsub("(_+)$","",newNames)
	newNames<-gsub("(_+)","_",newNames)


## test data
 	 testYData<-read.table("UCI HAR Dataset/test/y_test.txt")
       testXData<-read.table("UCI HAR Dataset/test/X_test.txt", header=FALSE,nrows=length(testYData[,1]),col.names=newNames)
	 subjectTest<-read.table("UCI HAR Dataset/test/subject_test.txt")

## training data
	 trainingYData<-read.table("UCI HAR Dataset/train/y_train.txt")
       trainingXData<-read.table("UCI HAR Dataset/train/X_train.txt", header=FALSE,nrows=length(trainingYData[,1]),col.names=newNames)
	 subjectTraining<-read.table("UCI HAR Dataset/train/subject_train.txt")

## merging data
## subject files
	 mergedDataSubject<-append(subjectTraining[,1], subjectTest[,1]);
## y-Files
	 mergedDataY<-append(trainingYData[,1], testYData[,1]);
## X-Files
	 mergedDataX<-merge(x=trainingXData,y=testXData, all = TRUE)
## add y-Files to x-Files
	 mergedDataX$Activity<-mergedDataY
 	 mergedDataX$Subject_To_Perform_Activity<-mergedDataSubject

##     Getting all needed column indexes
	 allNeededColumns<-grep("((_mean)|(_std))($|_)", newNames)
	 allNeededColumns<-append(allNeededColumns,  match(c("Activity","Subject_To_Perform_Activity"),names(mergedDataX)))

##     Uses descriptive activity names to name the activities in the data set
	transformedMergedActivity<-activityLabels[mergedDataY,]
## extracting needed columns
	preparedData<-mergedDataX[,allNeededColumns]
preparedData$Activity<-transformedMergedActivity[,2]
## creating tidy dataset
	uniqueSubjects <- unique(mergedDataSubject)
	countSubjects <- length(uniqueSubjects )
	countActivities <- length(activityLabels[,1])
	countColumns <- length(allNeededColumns)
	result <- data.frame(matrix(ncol = countColumns , nrow = (countSubjects * countActivities)))

	row = 1
	for (subject in 1:countSubjects) {
		for (activity in 1:countActivities ) {
			result[row, 1] = uniqueSubjects[subject]
			result[row, 2] = as.character(activityLabels[activity , 2])
			tmp <- preparedData[preparedData$Subject_To_Perform_Activity == subject & preparedData$Activity == activityLabels[activity, 2], ]
			result[row, 3:countColumns ] <- colMeans(tmp[, 1:(countColumns-2)])
			row = row+1;
		}
	}
	columnNamesForRez<-append(c("Subject","Activity"),newNames[allNeededColumns[1:(countColumns-2)]])
	colnames(result)<-columnNamesForRez
## writing the table
	write.table(result, "./AnalysisResult.txt")
