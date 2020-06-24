#Getting And Cleaning Data Course Project: Script

#This script must be runned in the same directory as UCI HAR Dataset
#and after this file has been unzipped

#I will use data.table to manipulate the data since it's faster than it's counterparts
library(data.table)

#Reads  the names of the features that are measured
feature_names=fread('./UCI HAR Dataset/features.txt') 

#Reads  all subjects in the test group
Tesubject= fread('./UCI HAR Dataset/test/subject_test.txt')
setnames(Tesubject,'V1', 'subjectID') #changes the variable name

#reads the measurements of the test group
Teset= fread('./UCI HAR Dataset/test/X_test.txt')
setnames(Teset, names(Teset),feature_names$V2 ) #changes the variable names for
                                                #the actual name of each feature

#Reads and modifies the labels of each activity in the test group
Telabels= fread('./UCI HAR Dataset/test/y_test.txt')
setnames(Telabels,'V1','activitylabels') #changes the variable name
Telabels[,activitylabels:=sub("5","Standing",Telabels$activitylabels)][,
        activitylabels:=sub("4","Sitting",Telabels$activitylabels)][,
        activitylabels:=sub("3","WalkingDownstairs",Telabels$activitylabels)][,
        activitylabels:=sub("2","WalkingUpstairs",Telabels$activitylabels)][,
        activitylabels:=sub("1","Walking",Telabels$activitylabels)][,
        activitylabels:=sub("6","Laying",Telabels$activitylabels)        
        ]
#Group subcject info (subject_test), measurement of features (X_test)
#and activity labels (y_test) in one dataset 
testData= data.table(Tesubject, Telabels, Teset)

#removes all the variables that are not gonna be used
rm('Teset','Telabels', 'Tesubject')

#______________________________________________________________

#Reads  all the subjects in the train group
Trsubject= fread('./UCI HAR Dataset/train/subject_train.txt')
setnames(Trsubject,'V1', 'subjectID')

#Reads  all the measurements in the train group
Trset= fread('./UCI HAR Dataset/train/X_train.txt')
setnames(Trset, names(Trset), feature_names$V2) #Changes the variable names

#Reads and modifies all the labels in the train group
Trlabels= fread('./UCI HAR Dataset/train/y_train.txt')
setnames(Trlabels,'V1', 'activitylabels' )
#changes the activities labels for descriptive names
Trlabels[,activitylabels:=sub("5","Standing",Trlabels$activitylabels)][,
                        activitylabels:=sub("4","Sitting",Trlabels$activitylabels)][,
                        activitylabels:=sub("3","WalkingDownstairs",Trlabels$activitylabels)][,
                        activitylabels:=sub("2","WalkingUpstairs",Trlabels$activitylabels)][,
                        activitylabels:=sub("1","Walking",Trlabels$activitylabels)][,
                        activitylabels:=sub("6","Laying",Trlabels$activitylabels)]        
    
#Group subcject info (subject_train), measurement of features (X_train)
#and activity labels (y_train) in one dataset                            
trainData=data.table(Trsubject, Trlabels, Trset)
                                                                                                                                                                                                                                                                                                        
#removes all the variables that are not gonna be used
rm('Trset','Trlabels', 'Trsubject', 'feature_names')

#Merges the training and the test sets to create one data set.
combinedData= rbind(testData, trainData)
combinedData[,subjectID:=as.numeric(subjectID)]
combinedData= combinedData[order(subjectID)] #Orders the data by subject ID


#_________________________________________________________________________________

#Get the indexes of  all the measurements that corresponds
#to mean and standard deviation
ind1=grep("mean", names(combinedData))
ind2=grep("std", names(combinedData))

#vector with colnames that will be extracted 
selectcols=c("subjectID","activitylabels",names(combinedData)[ind1], 
             names(combinedData)[ind2] )

#Extracts only the measurements on the mean and 
#standard deviation for each measurement.
filteredData = combinedData[,..selectcols]

#removes the variables that are not gonna be used 
rm("ind1", "ind2", "selectcols")
#___________________________________________________________________________________

# average of each variable for each activity and each subject.
averagedData= filteredData[, lapply(.SD,mean), .(subjectID, activitylabels)]
fwrite(averagedData,'tidydata.txt') #creates a new independent tidy data


#A lot of this project was made taking advantage of the  great functionalities of
#data.table, especially the last part of it. See the data.table vignette to get all
# the related information at: https://cran.r-project.org/web/packages/data.table/vignettes/datatable-intro.html



