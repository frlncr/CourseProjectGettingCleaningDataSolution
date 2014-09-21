
The GitHub repository CourseProjectGettingCleaningDataSolution contains 4 files:

run_analysis.R: 
This file contains all the R (version 3.1.0) code which reads the raw data, manipulates it and writes the final tidy data set

SubmitTidyCourseProjectGetting&Cleaning.txt: 
This file is the tidy data set which is  submitted as a requirement of the course project for Coursera course Getting & Cleaning Data  offered September 1-29,2014

CodeBook.md: 
This file documents all the variables in SubmitTidyCourseProjectGetting&Cleaning.txt. It explains what the tidy data is, how it was cleaned, any transformations applied  and how it is labeled

README.md: 
This file explains any preconditions for the data manipulation, all choices and reasoning regarding how the raw data was manipulated, the process followed to obtain the  tidy data set SubmitTidyCourseProjectGetting&Cleaning.txt and how it can be read
    
Please note that the tidy data set in this course project solution can be opened by making the   working directory a repo cloned from [here][11], or a working directory in which the run_analysis.R  file has been executed, and using the following R code

     submissionUrl<-".\\SubmitTidyCourseProjectGetting&Cleaning.txt"
     evaluateTidy<-read.table(submissionUrl,header=TRUE)
     
# The Raw Data #

The raw data originate from a study[1] on Human Activty Recognition. it is posted on the UCI Machine Learning [Repository][2].For the purposes of the Coursera course project the raw data was downloaded from a course [repository][3].
    
The documentation which comes in a README file in the directory structure of the raw data states that:
    
> "The experiments have been carried out with a group of 30 volunteers within an age bracket >of 19-48 years. Each person performed six activities (WALKING, WALKING UPSTAIRS, WALKING >DOWNSTAIRS, SITTING, STANDING, LAYING) wearing a smartphone (Samsung Galaxy S II) on the >waist. Using its embedded accelerometer and gyroscope, we captured [tri] axial linear >acceleration and [tri] axial angular velocity at a constant rate of 50Hz. The experiments >have been video recorded to label the data manually. The obtained dataset has been randomly >partitioned into two sets, where 70% of the volunteers was selected for generating the >training data and 30% the test data."
    
According to the README file which comes with the raw data, all the raw data are normalized and bounded within the interval from -1 to 1.
    
The actual raw data have been processed as set out in the feature info file which is in the directory structure of the raw data:
    
> "The features selected for this database come from the accelerometer and gyroscope [tri]  >axial raw signals tAcc-XYZ and tGyro-XYZ. These time domain signals (prefix 't' to denote >time) were captured at a constant rate of 50 Hz. Then they were filtered using a median >filter and a 3rd order low pass Butterworth filter with a corner frequency of 20 Hz to remove >noise. Similarly, the acceleration signal was then separated into body and gravity accelerati>on signals (tBodyAcc-XYZ and tGravityAcc-XYZ) using another low pass Butterworth filter with >a corner frequency of 0.3 Hz.                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                            
>    Subsequently, the body linear acceleration and angular velocity were derived in time to
>obtain Jerk signals (tBodyAccJerk-XYZ and tBodyGyroJerk-XYZ). Also the magnitude of these >three-dimensional signals were calculated using the Euclidean norm (tBodyAccMag, tGravityAccM>ag, tBodyAccJerkMag, tBodyGyroMag, tBodyGyroJerkMag).                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                         >Finally a Fast Fourier Transform (FFT) was applied to some of these signals producing >fBodyAcc-XYZ, fBodyAccJerk-XYZ, fBodyGyro-XYZ, fBodyAccJerkMag, fBodyGyroMag, fBodyGyroJerkMa>g. (Note The 'f' to indicate frequency domain signals).                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                           
>These signals were used to estimate variables of the feature vector for each pattern                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                     
>[Symbols]'-XYZ' is used to denote [tri]-axial signals in the X, Y and Z directions."                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                      
    
To ensure convenience for the user, the code in run_analysis.R does not assume any preconditions for the analysis of the data. The code downloads the zipped directory containing the data from the course repository, cited above, to the working directory. The code unzips the directory in a temp directory on the local computer and extracts all relavent components of the raw data to R objects for processing.
    
# Excluded Raw Data #

Within the directory structure of the zipped raw data are folders of inertial data. For purposes of creating the tidy data set, cited above, this data was not used because it does not contain mean or standard deviation measurements and so is specifically excluded from the data manipulation as a [requirement][4] of the course project.
    
# Reading the Raw Data #

The raw data is contained in several components of a complex directory structure. Within the zipped directory is a single "UCI HAR Dataset" directory containing further directories with the raw data. The UCI HAR directory contains:

- README file which documents what are the component files of the raw data and contains some information about the data itself and how it was obtained
- Features info file which provides an explanation of the the feature names in the raw data
- Labels for the activities performed by the subjects
- Labels assigned to the feature measurements (variables) in the raw data
- Directory containing the training set of raw data
- Directory containing the test set of raw data
    
Within each of the test and training set folders is contained:

- "Y" data set listing the activities  undertaken by each subject, as codes
- "X" data set containing all measurements for the subjects
- A folder of inertial data which is not relevant to this course project
- Subject ID codes for all subjects in the set
    
The code explores the directory structure in order to find the data. It also determines the size of each component of the raw data to help in determining how to put the components of the raw data together. It also tests whether the subjects in training and test sets are distinct, as they are supposed to be. The dimensions of the components suggests that the components fit together in the following way:

                     1 col        1 col    561 cols
       1 row  ->    subject     activity   features
    7352 rows -> subjecttrain |  ytrain  |  xtrain  |
                 -------------|----------|----------|
    2947 rows -> subjecttest  |  ytest   |  xtest   |
                
The inspiration for this diagram comes from a [post][5] by David Hood, TA for the course. There are no index variables within the raw data, so it is assumed that there is a positional match between the rows of the component files of raw data. At the same time as reading in the data the code looks to find all feature labels containing the word "mean" or the acronym std, since only those labeled features will be relevant for the project. However, some features containing the word "Mean"" are enclosed in the symbol "angle()" which the features info file states is an angle between vectors, so not a mean or standard deviation. These angle features are noted for elimination during data cleaning. 
    
# Merging training and test sets to create one data set #   
    
The training and test sets are merged using cbind() and rbind() according to the plan in the diagram above. Once the data components have been assembled the code tests to see that no subjects have missing activities or measurements. To free up RAM and system resources the connection to the temporary directory is closed and all utility objects in the environment are removed.
    
# Extracting only mean, standard deviation for each measurement from the raw data #

The angle() measurements in the data which contain the word "mean" in them but are not means themselves have capital "M" in the word "mean", so by only extracting features having "mean" with a lower case "m" or "std", the code extracts all relevant data. There are several features which contain the term "meanFreq(). According to the features info file contained in the raw data directory structure "meanFreq()" denotes a weighted average "of the frequency components to obtain a mean frequency." It is therefore a mean and is relevant to the course project. To do the extraction the code uses grepl() on the feature names. This results in a data set having 10,299 rows and 81 columns.
    
# Use descriptive activity names to name activities in the data #

The Activity column of the data file is composed of integer codes for activities. The code associates them with the activity labels which are in the feature label file in the UCI HAR Dataset. When the raw data is read into R the activity labels file is read in as a factor. First the code coerces the integer activity codes in the data to a factor, then coerces the activity labels to character values and assigns them as the levels of the newly created activity factor. The code prints multiple checks to ensure the process is working, since alternative methods have a tendency to introduce missing values into the data.
    
# Label the data with descriptive variable names #

There are three parts to this section: (1) determination of what constitutes a "descriptive variable name" in a tidy data set, (2) determination of the information components contained in the original feature names in the raw data and (3) using a method to assign descriptive names to all the features.
    
The course TA David Hood in his thread for advice on doing the course project gives an [example][6] of what a descriptive name means, e.g "Jerk of the body on the z axiz of the phone". His example is of course not directly applicable to the data since "Jerk" is a verb in his example, whereas it is a noun in the raw data. However, it clearly separates the information components "Jerk", "body", "z axis" and "the phone", using connecting phrases such as "of the". On page 16 of [lecture][7] number 1, "editing text variables", in the week 4 lectures of the course Getting and Cleaning Data Professor Leek gives several criteria which variable names must fulfill:

- All lower case
- Descriptive, with no short forms
- Not have underscores, dots or white spaces (generally: special characters)
    
There are nine information components which each original feature label in the raw data can be broken into, not all of which are used in any one feature label. One component is the statistic used which has three levels:

- weightedaveragefrequencycomponentofthe
- average
- standarddeviationofthe
    
The second information component states the domain of observation, or is blank in the case of weighted averages because the first component above already states they are in the frequency domain. This has the three levels:

- blank (for weighted average frequency components only)
- timecomponentof
- frequencycomponentof
    
The third information component is the measuring device:

- accelerometersignalof
- gyroscopesignalof
    
The fourth information component is to what the measurement is due:

- body
- gravity
    
The fifth information component is the type of physical phenomenon:

- linear           (associated with the accelerometer)
- angular          (associated with the gyroscope)
    
The sixth information component is the time derivative order:

- jerk             (third derivative)
- acceleration     (second derivative)
- velocity         (first derivative)
    
The seventh information component is an adjective describing the motion in relation to a spceific axis, but with a term to indicate if it is not associated with any one of the X, Y or Z axes:

- magnitude        (if not associated with one of the  X,Y or Z axes)
- alongthe         (linear motion, accelerometer)
- aroundthe        (angular motion, gyroscope)
    
The eighth information component is the specific axis involved, or blank if there isn't one:

- blank            (if not associated with one of the  X,Y or Z axes)
- xaxis
- yaxis
- zaxis
    
The ninth information component is simply the constant "ofthephone" since all measurements are relative to the axes of the phone, or are magnitudes associated with characteristics of the phone's motion vector.
    
This leads to extremely long descriptive labels which would be much easier to read if capital letters, spaces and dots were allowed in variable names, and if connecting phrases did not need to join the basic elements of each component. However, to satisfy all authorities with regard to what is an appropriate descriptive variable name in a data set, all the restrictions are applied in the code. Specifically the code defines a function called "prettylabel" which implements the above mentioned information schema by concatenating all nine information components. The descriptive labels are applied to the data set by successively applying the prettylabel function to each of the variable names, other than "subject" and "activity". See the CodeBook.md file for the relationship between the created labels and the original labels.

# Creating a new tidy data set with the average of each variable for each activity and each subject #

Based on a [post][8] by TA Wendel Hope in response to an earlier [question][9] from the class, the correct interpretation of this step is to obtain the average of every variable within every combination of subject and activity. Then to show that the data is in fact tidy. The aggregation of the data is accomplished using the ddply function of the plyr package of R, since it does not introduce extraneous variables and does not result in any missing data. The code checks that aggregating with the mean function across subjects and activities does not introduce any missing data, since some techniques are known to do that. It also checks the dimensions of the resulting tidy data set since some techniques are known to add on extraneous variables. The final tidy data set has 180 (30 subjects X 6 activites rows) and 81 (subject, activity and 79 features) variables.

The 180 X 81 data set produced at this stage is tidy because it satisfies all of the following tidy data criteria which were given on page 4 of lecture [notes][10] for the third lecture of week one of the Coursera course Getting & Cleaning Data:

- each column contains only one conceptual variable
- each observation, i.e. a specific subject doing a specific activity, is a single row
- all the variables are of the same kind,i.e. averages of features, so there is only one table
- there is a row at the top of the file with descriptive variable names
- the variable names are "human readable"", without abbreviations or acronyms
- the data is saved in one file per table
    
Please note that the tidy data set in this course project solution can be opened by making the working directory a repo cloned from [here][11], or a working directory in which the run_analysis.R file has been executed, and using the following R code

     submissionUrl<-".\\SubmitTidyCourseProjectGetting&Cleaning.txt"
     evaluateTidy<-read.table(submissionUrl,header=TRUE)
     
     
    
[1]: Davide Anguita, Alessandro Ghio, Luca Oneto, Xavier Parra and Jorge L. Reyes-Ortiz. 
         Human Activity Recognition on Smartphones using a Multiclass Hardware-Friendly
         Support Vector Machine. 
         International Workshop of Ambient Assisted Living (IWAAL 2012). 
         Vitoria-Gasteiz, Spain. Dec 2012
[2]: http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones
[3]: https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip
[4]: https://class.coursera.org/getdata-007/human_grading/view/courses/972585/assessments/3/submissions
[5]: https://class.coursera.org/getdata-007/forum/thread?thread_id=49#comment-570
[6]: https://class.coursera.org/getdata-007/forum/thread?thread_id=49#post-114
[7]: https://d396qusza40orc.cloudfront.net/getdata/lecture_slides/04_01_editingTextVariables.pdf
[8]: https://class.coursera.org/getdata-007/forum/thread?thread_id=233#post-948
[9]: https://class.coursera.org/getdata-007/forum/thread?thread_id=233#post-901
[10]: https://d396qusza40orc.cloudfront.net/getdata/lecture_slides/01_03_componentsOfTidyData.pdf
[11]: https://github.com/frlncr/CourseProjectGettingCleaningDataSolution
