##############################################################################################
#This file contains all R (version 3.1.0) code used to conduct the steps of the Course Project
#for Coursera course: Getting & Cleaning Data offered September 1-29, 2014
#
#The raw data originate from: 
#Davide Anguita, Alessandro Ghio, Luca Oneto, Xavier Parra and Jorge L. Reyes-Ortiz. 
#Human Activity Recognition on Smartphones using a Multiclass Hardware-Friendly
#Support Vector Machine. 
#International Workshop of Ambient Assisted Living (IWAAL 2012). 
#Vitoria-Gasteiz, Spain. Dec 2012
#
#It is posted on the UCI Machine Learning Repository at:
#http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones
#
#On the UCI website the source for this raw data set is cited as:
#Jorge L. Reyes-Ortiz, Davide Anguita, Alessandro Ghio, Luca Oneto. 
#Smartlab - Non Linear Complex Systems Laboratory 
#DITEN - Universit√  degli Studi di Genova, Genoa I-16145, Italy. 
#activityrecognition '@' smartlab.ws 
#www.smartlab.ws
#
#For the purposes of the Coursera course project the raw data was downloaded from:
#https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip
#
#Refer to the README.md file at:
#https://github.com/frlncr/CourseProjectGettingCleaningDataSolution
#for details regarding the structure and contents of the raw data
#
#Note: the final tidy data set can be read into R by using the following code
#      when the working directory is a repo cloned from  
#      https://github.com/frlncr/CourseProjectGettingCleaningDataSolution
#
#      submissionUrl<-".\\SubmitTidyCourseProjectGetting&Cleaning.txt"
#      evaluateTidy<-read.table(submissionUrl,header=TRUE)
#
##############################################################################################

# Download the zipped directory of raw data from the course repository cited above
# This will place the zipped directory in the working directory of the local computer
# The target folder is called "CourseProjectActivity.zip"

fileUrl<-"https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
download.file(fileUrl,destfile="CourseProjectActivity.zip")

# Unzip the directory containing the raw data within a temporary directory on the local 
# computer. Explore the directory structure, loading as R objects only the components of
# the raw data cited as relevant in the README.md file cited above. In addition, extract the
# Readme.txt file contained in the directory. This contains information about the raw data

tempdir<-tempfile()
dir.create(tempdir)
unzip("CourseProjectActivity.zip",exdir=tempdir)

# Explore the first level of the directory

files1<-list.files(tempdir)
files1

# Explore the second level of the directory

filePath1<-paste(tempdir,files1,sep="\\")
files2<-list.files(filePath1[1])
files2
filePath2<-paste(filePath1,files2,sep="\\")

# Load the activity labels of the raw data

activityLabels<-read.table(filePath2[1])
activityLabels

# Load and examine the composition of the features vector for the raw data

features<-read.table(filePath2[2])
dim(features)                                              # Determine its size
namestest<-as.character(features$V2)                       # Make it a vector of labels                      
namestest<-namestest[grepl("mean|std",tolower(namestest))] # Look for relevant features
namestest
namestest<-namestest[grepl("angle",tolower(namestest))]    # Look for irrelevant features
namestest
head(features)
tail(features)

# Load text file which explains the features
# This is strictly expanatory and is not necessary for the code operation

featuresInfo<-readLines(filePath2[3])
featuresInfo

# Load the ReaMe text file which contains the codebook for the raw data
# This is strictly expanatory and is not necessary for the code operation

readMe<-readLines(filePath2[4])
readMe

# Explore the subdirectory of test set data
# Load relevant test set data and determine its size for later restructuring

files3<-list.files(filePath2[5])
files3
filePath3<-paste(filePath2[5],files3,sep="\\")
subjectTest<-read.table(filePath3[2])
dim(subjectTest)
head(subjectTest)
xTest<-read.table(filePath3[3])
dim(xTest)
yTest<-read.table(filePath3[4])
dim(yTest)

# Explore the subdirectory of training set data
# Load relevant training set data and determine its size for later restructuring

files4<-list.files(filePath2[6])
files4
filePath4<-paste(filePath2[6],files4,sep="\\")
subjectTrain<-read.table(filePath4[2])
dim(subjectTrain)
xTrain<-read.table(filePath4[3])
dim(xTrain)
yTrain<-read.table(filePath4[4])
dim(yTrain)

# Close the connection to the temporary directory

unlink(tempdir)
rm(tempdir)

# Test to ensure the subject id numbers in test and training sets are distinct

testForDuplicates<-length(intersect(subjectTrain,subjectTest))
testForDuplicates

# Connect together all the components of the raw data as outlined in the README.md file

data<-rbind(cbind(subjectTest,yTest,xTest),cbind(subjectTrain,yTrain,xTrain))
dim(data)

# Ensure that no subjects have missing activities or measurements

testForMissing<-sum(!complete.cases(data))
testForMissing

# Attach the feature names, as well as Subject and Activity identifiers, to the full raw data

names(data)<-c("subject","activity",as.character(features$V2))

# Clean out all utility objects to restrict the environment to relevant objects

rm(features,subjectTest,yTest,xTest,subjectTrain,yTrain,xTrain,
                     filePath1,filePath2,filePath3,filePath4,
                     fileUrl,files1,files2,files3,files4,
                     testForDuplicates,testForMissing,namestest
)

# Extract only features which are either mean or standard deviation measurements

data<-data[,c(TRUE,TRUE,grepl("mean|std",names(data)[3:length(names(data))]))]
dim(data)

# Assign descriptive activity names to name activities in the data

data$activity<-factor(data$activity) #Change the integer activity codes in the data to a factor
class(data$activity)
table(data$activity)
levels(data$activity)
class(activityLabels$V2)
levels(data$activity)<-as.character(activityLabels$V2) #Assign the activity labels as factor levels
table(data$activity)

# Label the data with descriptive variable names
# First define the prettylabel function according to the information schema indicated in
# the README.md file
# Then apply it to all the feature names

sum(grepl("mean&std",names(data))) #Check to ensure no labels contain both mean and std

prettylabel<-function(x) {
                     label<-character(9)
                     type<-"notWeightedAverage"
                     if(grepl("meanFreq",x)) {
                             label[1]<-"weightedaveragefrequencycomponentofthe"
                             type<-"weightedAverage"
                     } else if(grepl("mean",x)) {
                                    label[1]<-"average"
                            } else if(grepl("std",x)) {
                                           label[1]<-"standarddeviationofthe"
                     }
                     if(type=="weightedAverage") {
                             label[2]<-""
                     } else if(grepl("^t",x)) {
                                    label[2]<-"timecomponentof"
                            } else if(grepl("^f",x)) {
                                    label[2]<-"frequencycomponentof"
                     }
                     if(grepl("Acc",x)) {
                             label[3]<-"accelerometersignalof"
                             label[5]<-"linear"
                             device<-"accelerometer"
                     } else if(grepl("Gyro",x)) {
                                    label[3]<-"gyroscopesignalof"
                                    label[5]<-"angular"
                                    device<-"gyroscope"
                     }
                     if(grepl("Body",x)) {
                             label[4]<-"body"
                     } else if(grepl("Gravity",x)) {
                                    label[4]<-"gravity"
                     }
                     if(grepl("Jerk",x)) {
                             label[6]<-"jerk"
                     } else if(device=="accelerometer") {
                                   label[6]<-"acceleration"
                            } else if(device=="gyroscope") {
                                           label[6]<-"velocity"
                     }
                     if(grepl("Mag",x)) {
                             label[7]<-"magnitude"
                             label[8]<-""
                     } else if(device=="accelerometer") {
                                    label[7]<-"alongthe"
                            } else if(device=="gyroscope") {
                                    label[7]<-"aroundthe"
                     }
                     if(grepl("X",x)) {
                             label[8]<-"xaxis"
                     } else if(grepl("Y",x)) {
                                    label[8]<-"yaxis"
                            } else if(grepl("Z",x)) {
                                           label[8]<-"zaxis"
                     }
                     label[9]<-"ofthephone"
                     paste(label,collapse='')
}

# Apply the prettylabel function to all original feature names

descriptiveVariableNames<-sapply(names(data)[3:length(names(data))],
                                 FUN=prettylabel,
                                 USE.NAMES=FALSE
)

# Replace the variable names in the data with the new descriptive variable labels

names(data)<-c("subject","activity",descriptiveVariableNames)

# Create a new tidy data set with the average of each variable for
# each activity and each subject

suppressWarnings(library(plyr))
tidyData<-ddply(data,.(subject,activity),numcolwise(mean))
sum(!complete.cases(tidyData))            #Check this has not introduced missing values
dim(tidyData)                             #Check this has not introduced extraneous variables

# Write the final tidy data set to a text file

submissionUrl<-".\\SubmitTidyCourseProjectGetting&Cleaning.txt"
write.table(tidyData,submissionUrl,row.names=FALSE)

# The final tidy data set can be read into R from any repo cloned from the one at
# https://github.com/frlncr/CourseProjectGettingCleaningDataSolution
# or any worknig directory in which this run_analysis.R file has been executed
# by using the following code:

submissionUrl<-".\\SubmitTidyCourseProjectGetting&Cleaning.txt"
evaluateTidy<-read.table(submissionUrl,header=TRUE)