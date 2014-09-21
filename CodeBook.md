This file is the code book for the tidy data set submitted for the course project of Coursera course Getting & Cleaning Data offered September 1-29, 2014. The set is also available in the Git Hub repository at https://github.com/frlncr/CourseProjectGettingCleaningDataSolution .

Please note that the tidy data set in this course project solution can be opened by making the working directory a repo cloned from [here][11], or a working directory in which the run_analysis.R file has been executed, and using the following R code

     submissionUrl<-".\\SubmitTidyCourseProjectGetting&Cleaning.txt"
     evaluateTidy<-read.table(submissionUrl,header=TRUE)

#   The Raw Data

    The raw data originate from a study[1] on Human Activty Recognition. it is posted on the UCI Machine Learning [Repository][2].For the purposes of the Coursera course project the raw data was downloaded from a course [repository][3].
    
    The documentation which comes in a README file in the directory structure of the raw data states that:
    
    "The experiments have been carried out with a group of 30 volunteers within an age bracket of 19-48 years. Each person performed six activities (WALKING, WALKING UPSTAIRS, WALKING DOWNSTAIRS, SITTING, STANDING, LAYING) wearing a smartphone (Samsung Galaxy S II) on the waist. Using its embedded accelerometer and gyroscope, we captured [tri] axial linear acceleration and [tri] axial angular velocity at a constant rate of 50Hz. The experiments have been video recorded to label the data manually. The obtained dataset has been randomly partitioned into two sets, where 70% of the volunteers was selected for generating the training data and 30% the test data."
    
    According to the README file which comes with the raw data, all the raw data are normalized and bounded within the interval from -1 to 1.
    
    The actual raw data have been processed as set out in the feature info file which is in the directory structure of the raw data:
    
    "The features selected for this database come from the accelerometer and gyroscope [tri]  axial raw signals tAcc-XYZ and tGyro-XYZ. These time domain signals (prefix 't' to denote time) were captured at a constant rate of 50 Hz. Then they were filtered using a median filter and a 3rd order low pass Butterworth filter with a corner frequency of 20 Hz to remove noise. Similarly, the acceleration signal was then separated into body and gravity acceleration signals (tBodyAcc-XYZ and tGravityAcc-XYZ) using another low pass Butterworth filter with a corner frequency of 0.3 Hz.                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                            
    Subsequently, the body linear acceleration and angular velocity were derived in time to
obtain Jerk signals (tBodyAccJerk-XYZ and tBodyGyroJerk-XYZ). Also the magnitude of these three-dimensional signals were calculated using the Euclidean norm (tBodyAccMag, tGravityAccMag, tBodyAccJerkMag, tBodyGyroMag, tBodyGyroJerkMag).                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                         Finally a Fast Fourier Transform (FFT) was applied to some of these signals producing fBodyAcc-XYZ, fBodyAccJerk-XYZ, fBodyGyro-XYZ, fBodyAccJerkMag, fBodyGyroMag, fBodyGyroJerkMag. (Note The 'f' to indicate frequency domain signals).                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                           
These signals were used to estimate variables of the feature vector for each pattern                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                     
[Symbols]'-XYZ' is used to denote [tri]-axial signals in the X, Y and Z directions."           

#   Variables from the raw data which are not included in the tidy data set

    All variables in the raw data which were not mean values or standard deviations have been excluded. These variables are any which represented the following and the labels of which contain any of the indicated symbols:
    
    - median absolute deviation (mad())
    - largest value (max())
    - smallest value (min())
    - signal magnitude area (sma())
    - energy, measured as sum of squares devided by number of values (energy())
    - inter quartile range (iqr())
    - signal entropy (entropy())
    - Autorregresion coefficients with Burg order equal to 4 (arcoeff())
    - correlation coefficient between two signals (correlation())
    - index of the frequency component with largest magnitude (maxInds())
    - skewness of the frequency domain signal (skewness())
    - kurtosis of the frequency domain signal (kurtosis())
    - Energy of a frequency interval within the 64 bins of the FFT of each window (bandsEnergy())
    - Angle between two vectors (variable names of the form angle([vector1],[vector2]))
    
#   The tidy data set

    To form the tidy data set the raw data is joined together in the pattern indicated in the README.md file [here][11]. There are no index variables in the raw data, so it is assumed that there is a positional match of rows between the separate data files when merging them. The variables from the raw data file which are processed to obtain the tidy data file represent:
    - Mean value (mean())
    - Standard deviation (std())
    - Weighted average of the frequency components to obtain a mean frequency (meanFreq())
    
    The tidy data set has one row for each observation of a subject doing an activity. There are therefore 180 rows (30 subjects X 6 activities). There are 81 variables as listed below:
    
- subject
  A unique numeric code for each subject, ranges from 1-30
  
- activity
  A factor having the levels: WALKING, WALKING UPSTAIRS, WALKING DOWNSTAIRS, SITTING, STANDING, LAYING

averagetimecomponentofaccelerometersignalofbodylinearaccelerationalongthexaxisofthephone   
The average of tBodyAcc-mean()-X within each subject X activity combination   
bounded between -1 and 1   
    
averagetimecomponentofaccelerometersignalofbodylinearaccelerationalongtheyaxisofthephone   
The average of tBodyAcc-mean()-Y within each subject X activity combination   
bounded between -1 and 1   
    
averagetimecomponentofaccelerometersignalofbodylinearaccelerationalongthezaxisofthephone   
The average of tBodyAcc-mean()-Z within each subject X activity combination   
bounded between -1 and 1   
    
standarddeviationofthetimecomponentofaccelerometersignalofbodylinearaccelerationalongthexaxisofthephone   
The average of tBodyAcc-std()-X within each subject X activity combination   
bounded between -1 and 1   
    
standarddeviationofthetimecomponentofaccelerometersignalofbodylinearaccelerationalongtheyaxisofthephone   
The average of tBodyAcc-std()-Y within each subject X activity combination   
bounded between -1 and 1   
    
standarddeviationofthetimecomponentofaccelerometersignalofbodylinearaccelerationalongthezaxisofthephone   
The average of tBodyAcc-std()-Z within each subject X activity combination   
bounded between -1 and 1   
    
averagetimecomponentofaccelerometersignalofgravitylinearaccelerationalongthexaxisofthephone   
The average of tGravityAcc-mean()-X within each subject X activity combination   
bounded between -1 and 1   
    
averagetimecomponentofaccelerometersignalofgravitylinearaccelerationalongtheyaxisofthephone   
The average of tGravityAcc-mean()-Y within each subject X activity combination   
bounded between -1 and 1   
    
averagetimecomponentofaccelerometersignalofgravitylinearaccelerationalongthezaxisofthephone   
The average of tGravityAcc-mean()-Z within each subject X activity combination   
bounded between -1 and 1   
    
standarddeviationofthetimecomponentofaccelerometersignalofgravitylinearaccelerationalongthexaxisofthephone   
The average of tGravityAcc-std()-X within each subject X activity combination   
bounded between -1 and 1   
    
standarddeviationofthetimecomponentofaccelerometersignalofgravitylinearaccelerationalongtheyaxisofthephone   
The average of tGravityAcc-std()-Y within each subject X activity combination   
bounded between -1 and 1   
    
standarddeviationofthetimecomponentofaccelerometersignalofgravitylinearaccelerationalongthezaxisofthephone   
The average of tGravityAcc-std()-Z within each subject X activity combination   
bounded between -1 and 1   
    
averagetimecomponentofaccelerometersignalofbodylinearjerkalongthexaxisofthephone   
The average of tBodyAccJerk-mean()-X within each subject X activity combination   
bounded between -1 and 1   
    
averagetimecomponentofaccelerometersignalofbodylinearjerkalongtheyaxisofthephone   
The average of tBodyAccJerk-mean()-Y within each subject X activity combination   
bounded between -1 and 1   
    
averagetimecomponentofaccelerometersignalofbodylinearjerkalongthezaxisofthephone   
The average of tBodyAccJerk-mean()-Z within each subject X activity combination   
bounded between -1 and 1   
    
standarddeviationofthetimecomponentofaccelerometersignalofbodylinearjerkalongthexaxisofthephone   
The average of tBodyAccJerk-std()-X within each subject X activity combination   
bounded between -1 and 1   
    
standarddeviationofthetimecomponentofaccelerometersignalofbodylinearjerkalongtheyaxisofthephone   
The average of tBodyAccJerk-std()-Y within each subject X activity combination   
bounded between -1 and 1   
    
standarddeviationofthetimecomponentofaccelerometersignalofbodylinearjerkalongthezaxisofthephone   
The average of tBodyAccJerk-std()-Z within each subject X activity combination   
bounded between -1 and 1   
    
averagetimecomponentofgyroscopesignalofbodyangularvelocityaroundthexaxisofthephone   
The average of tBodyGyro-mean()-X within each subject X activity combination   
bounded between -1 and 1   
    
averagetimecomponentofgyroscopesignalofbodyangularvelocityaroundtheyaxisofthephone   
The average of tBodyGyro-mean()-Y within each subject X activity combination   
bounded between -1 and 1   
    
averagetimecomponentofgyroscopesignalofbodyangularvelocityaroundthezaxisofthephone   
The average of tBodyGyro-mean()-Z within each subject X activity combination   
bounded between -1 and 1   
    
standarddeviationofthetimecomponentofgyroscopesignalofbodyangularvelocityaroundthexaxisofthephone   
The average of tBodyGyro-std()-X within each subject X activity combination   
bounded between -1 and 1   
    
standarddeviationofthetimecomponentofgyroscopesignalofbodyangularvelocityaroundtheyaxisofthephone   
The average of tBodyGyro-std()-Y within each subject X activity combination   
bounded between -1 and 1   
    
standarddeviationofthetimecomponentofgyroscopesignalofbodyangularvelocityaroundthezaxisofthephone   
The average of tBodyGyro-std()-Z within each subject X activity combination   
bounded between -1 and 1   
    
averagetimecomponentofgyroscopesignalofbodyangularjerkaroundthexaxisofthephone   
The average of tBodyGyroJerk-mean()-X within each subject X activity combination   
bounded between -1 and 1   
    
averagetimecomponentofgyroscopesignalofbodyangularjerkaroundtheyaxisofthephone   
The average of tBodyGyroJerk-mean()-Y within each subject X activity combination   
bounded between -1 and 1   
    
averagetimecomponentofgyroscopesignalofbodyangularjerkaroundthezaxisofthephone   
The average of tBodyGyroJerk-mean()-Z within each subject X activity combination   
bounded between -1 and 1   
    
standarddeviationofthetimecomponentofgyroscopesignalofbodyangularjerkaroundthexaxisofthephone   
The average of tBodyGyroJerk-std()-X within each subject X activity combination   
bounded between -1 and 1   
    
standarddeviationofthetimecomponentofgyroscopesignalofbodyangularjerkaroundtheyaxisofthephone   
The average of tBodyGyroJerk-std()-Y within each subject X activity combination   
bounded between -1 and 1   
    
standarddeviationofthetimecomponentofgyroscopesignalofbodyangularjerkaroundthezaxisofthephone   
The average of tBodyGyroJerk-std()-Z within each subject X activity combination   
bounded between -1 and 1   
    
averagetimecomponentofaccelerometersignalofbodylinearaccelerationmagnitudeofthephone   
The average of tBodyAccMag-mean() within each subject X activity combination   
bounded between -1 and 1   
    
standarddeviationofthetimecomponentofaccelerometersignalofbodylinearaccelerationmagnitudeofthephone   
The average of tBodyAccMag-std() within each subject X activity combination   
bounded between -1 and 1   
    
averagetimecomponentofaccelerometersignalofgravitylinearaccelerationmagnitudeofthephone   
The average of tGravityAccMag-mean() within each subject X activity combination   
bounded between -1 and 1   
    
standarddeviationofthetimecomponentofaccelerometersignalofgravitylinearaccelerationmagnitudeofthephone   
The average of tGravityAccMag-std() within each subject X activity combination   
bounded between -1 and 1   
    
averagetimecomponentofaccelerometersignalofbodylinearjerkmagnitudeofthephone   
The average of tBodyAccJerkMag-mean() within each subject X activity combination   
bounded between -1 and 1   
    
standarddeviationofthetimecomponentofaccelerometersignalofbodylinearjerkmagnitudeofthephone   
The average of tBodyAccJerkMag-std() within each subject X activity combination   
bounded between -1 and 1   
    
averagetimecomponentofgyroscopesignalofbodyangularvelocitymagnitudeofthephone   
The average of tBodyGyroMag-mean() within each subject X activity combination   
bounded between -1 and 1   
    
standarddeviationofthetimecomponentofgyroscopesignalofbodyangularvelocitymagnitudeofthephone   
The average of tBodyGyroMag-std() within each subject X activity combination   
bounded between -1 and 1   
    
averagetimecomponentofgyroscopesignalofbodyangularjerkmagnitudeofthephone   
The average of tBodyGyroJerkMag-mean() within each subject X activity combination   
bounded between -1 and 1   
    
standarddeviationofthetimecomponentofgyroscopesignalofbodyangularjerkmagnitudeofthephone   
The average of tBodyGyroJerkMag-std() within each subject X activity combination   
bounded between -1 and 1   
    
averagefrequencycomponentofaccelerometersignalofbodylinearaccelerationalongthexaxisofthephone   
The average of fBodyAcc-mean()-X within each subject X activity combination   
bounded between -1 and 1   
    
averagefrequencycomponentofaccelerometersignalofbodylinearaccelerationalongtheyaxisofthephone   
The average of fBodyAcc-mean()-Y within each subject X activity combination   
bounded between -1 and 1   
    
averagefrequencycomponentofaccelerometersignalofbodylinearaccelerationalongthezaxisofthephone   
The average of fBodyAcc-mean()-Z within each subject X activity combination   
bounded between -1 and 1   
    
standarddeviationofthefrequencycomponentofaccelerometersignalofbodylinearaccelerationalongthexaxisofthephone   
The average of fBodyAcc-std()-X within each subject X activity combination   
bounded between -1 and 1   
    
standarddeviationofthefrequencycomponentofaccelerometersignalofbodylinearaccelerationalongtheyaxisofthephone   
The average of fBodyAcc-std()-Y within each subject X activity combination   
bounded between -1 and 1   
    
standarddeviationofthefrequencycomponentofaccelerometersignalofbodylinearaccelerationalongthezaxisofthephone   
The average of fBodyAcc-std()-Z within each subject X activity combination   
bounded between -1 and 1   
    
weightedaveragefrequencycomponentoftheaccelerometersignalofbodylinearaccelerationalongthexaxisofthephone   
The average of fBodyAcc-meanFreq()-X within each subject X activity combination   
bounded between -1 and 1   
    
weightedaveragefrequencycomponentoftheaccelerometersignalofbodylinearaccelerationalongtheyaxisofthephone   
The average of fBodyAcc-meanFreq()-Y within each subject X activity combination   
bounded between -1 and 1   
    
weightedaveragefrequencycomponentoftheaccelerometersignalofbodylinearaccelerationalongthezaxisofthephone   
The average of fBodyAcc-meanFreq()-Z within each subject X activity combination   
bounded between -1 and 1   
    
averagefrequencycomponentofaccelerometersignalofbodylinearjerkalongthexaxisofthephone   
The average of fBodyAccJerk-mean()-X within each subject X activity combination   
bounded between -1 and 1   
    
averagefrequencycomponentofaccelerometersignalofbodylinearjerkalongtheyaxisofthephone   
The average of fBodyAccJerk-mean()-Y within each subject X activity combination   
bounded between -1 and 1   
    
averagefrequencycomponentofaccelerometersignalofbodylinearjerkalongthezaxisofthephone   
The average of fBodyAccJerk-mean()-Z within each subject X activity combination   
bounded between -1 and 1   
    
standarddeviationofthefrequencycomponentofaccelerometersignalofbodylinearjerkalongthexaxisofthephone   
The average of fBodyAccJerk-std()-X within each subject X activity combination   
bounded between -1 and 1   
    
standarddeviationofthefrequencycomponentofaccelerometersignalofbodylinearjerkalongtheyaxisofthephone   
The average of fBodyAccJerk-std()-Y within each subject X activity combination   
bounded between -1 and 1   
    
standarddeviationofthefrequencycomponentofaccelerometersignalofbodylinearjerkalongthezaxisofthephone   
The average of fBodyAccJerk-std()-Z within each subject X activity combination   
bounded between -1 and 1   
    
weightedaveragefrequencycomponentoftheaccelerometersignalofbodylinearjerkalongthexaxisofthephone   
The average of fBodyAccJerk-meanFreq()-X within each subject X activity combination   
bounded between -1 and 1   
    
weightedaveragefrequencycomponentoftheaccelerometersignalofbodylinearjerkalongtheyaxisofthephone   
The average of fBodyAccJerk-meanFreq()-Y within each subject X activity combination   
bounded between -1 and 1   
    
weightedaveragefrequencycomponentoftheaccelerometersignalofbodylinearjerkalongthezaxisofthephone   
The average of fBodyAccJerk-meanFreq()-Z within each subject X activity combination   
bounded between -1 and 1   
    
averagefrequencycomponentofgyroscopesignalofbodyangularvelocityaroundthexaxisofthephone   
The average of fBodyGyro-mean()-X within each subject X activity combination   
bounded between -1 and 1   
    
averagefrequencycomponentofgyroscopesignalofbodyangularvelocityaroundtheyaxisofthephone   
The average of fBodyGyro-mean()-Y within each subject X activity combination   
bounded between -1 and 1   
    
averagefrequencycomponentofgyroscopesignalofbodyangularvelocityaroundthezaxisofthephone   
The average of fBodyGyro-mean()-Z within each subject X activity combination   
bounded between -1 and 1   
    
standarddeviationofthefrequencycomponentofgyroscopesignalofbodyangularvelocityaroundthexaxisofthephone   
The average of fBodyGyro-std()-X within each subject X activity combination   
bounded between -1 and 1   
    
standarddeviationofthefrequencycomponentofgyroscopesignalofbodyangularvelocityaroundtheyaxisofthephone   
The average of fBodyGyro-std()-Y within each subject X activity combination   
bounded between -1 and 1   
    
standarddeviationofthefrequencycomponentofgyroscopesignalofbodyangularvelocityaroundthezaxisofthephone   
The average of fBodyGyro-std()-Z within each subject X activity combination   
bounded between -1 and 1   
    
weightedaveragefrequencycomponentofthegyroscopesignalofbodyangularvelocityaroundthexaxisofthephone   
The average of fBodyGyro-meanFreq()-X within each subject X activity combination   
bounded between -1 and 1   
    
weightedaveragefrequencycomponentofthegyroscopesignalofbodyangularvelocityaroundtheyaxisofthephone   
The average of fBodyGyro-meanFreq()-Y within each subject X activity combination   
bounded between -1 and 1   
    
weightedaveragefrequencycomponentofthegyroscopesignalofbodyangularvelocityaroundthezaxisofthephone   
The average of fBodyGyro-meanFreq()-Z within each subject X activity combination   
bounded between -1 and 1   
    
averagefrequencycomponentofaccelerometersignalofbodylinearaccelerationmagnitudeofthephone   
The average of fBodyAccMag-mean() within each subject X activity combination   
bounded between -1 and 1   
    
standarddeviationofthefrequencycomponentofaccelerometersignalofbodylinearaccelerationmagnitudeofthephone   
The average of fBodyAccMag-std() within each subject X activity combination   
bounded between -1 and 1   
    
weightedaveragefrequencycomponentoftheaccelerometersignalofbodylinearaccelerationmagnitudeofthephone   
The average of fBodyAccMag-meanFreq() within each subject X activity combination   
bounded between -1 and 1   
    
averagefrequencycomponentofaccelerometersignalofbodylinearjerkmagnitudeofthephone   
The average of fBodyBodyAccJerkMag-mean() within each subject X activity combination   
bounded between -1 and 1   
    
standarddeviationofthefrequencycomponentofaccelerometersignalofbodylinearjerkmagnitudeofthephone   
The average of fBodyBodyAccJerkMag-std() within each subject X activity combination   
bounded between -1 and 1   
    
weightedaveragefrequencycomponentoftheaccelerometersignalofbodylinearjerkmagnitudeofthephone   
The average of fBodyBodyAccJerkMag-meanFreq() within each subject X activity combination   
bounded between -1 and 1   
    
averagefrequencycomponentofgyroscopesignalofbodyangularvelocitymagnitudeofthephone   
The average of fBodyBodyGyroMag-mean() within each subject X activity combination   
bounded between -1 and 1   
    
standarddeviationofthefrequencycomponentofgyroscopesignalofbodyangularvelocitymagnitudeofthephone   
The average of fBodyBodyGyroMag-std() within each subject X activity combination   
bounded between -1 and 1   
    
weightedaveragefrequencycomponentofthegyroscopesignalofbodyangularvelocitymagnitudeofthephone   
The average of fBodyBodyGyroMag-meanFreq() within each subject X activity combination   
bounded between -1 and 1   
    
averagefrequencycomponentofgyroscopesignalofbodyangularjerkmagnitudeofthephone   
The average of fBodyBodyGyroJerkMag-mean() within each subject X activity combination   
bounded between -1 and 1   
    
standarddeviationofthefrequencycomponentofgyroscopesignalofbodyangularjerkmagnitudeofthephone   
The average of fBodyBodyGyroJerkMag-std() within each subject X activity combination   
bounded between -1 and 1   
    
weightedaveragefrequencycomponentofthegyroscopesignalofbodyangularjerkmagnitudeofthephone   
The average of fBodyBodyGyroJerkMag-meanFreq() within each subject X activity combination   
bounded between -1 and 1   
    

 

    [1]: Davide Anguita, Alessandro Ghio, Luca Oneto, Xavier Parra and Jorge L. Reyes-Ortiz. 
         Human Activity Recognition on Smartphones using a Multiclass Hardware-Friendly
         Support Vector Machine. 
         International Workshop of Ambient Assisted Living (IWAAL 2012). 
         Vitoria-Gasteiz, Spain. Dec 2012
    [2]: http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones
    [3]: https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip
    [11]: https://github.com/frlncr/CourseProjectGettingCleaningDataSolution
