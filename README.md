Clean-Data-Submission
=====================

My submission for the Getting and Cleaning Data Course Project is contained in this repo. The R script R_Analysis.R when run in R creates two seperate tidy data sets per the course project instructions. The datasets output are called "dat2" and "dat3". "dat3" is uploaded on the Coursera project page as the submission for part 1 of the project. The R script creates these tidy datasets by performing the following operations:

1) Downloading the wearable technology data.

2) Unzipping the files

3) Reading data in to R-Here the script reads in the data for the motion variables (561 variables), the Activity variable, and the Subject variable for both the training and testing sets. 

4) Merging the data in to one data set-Here the data is stitched together using rbind to stack the training and testing sets on top of each other. The resulting data frame is called "dat" and contains 10299 observations of 563 variables. 

5) Creating a new data set with only the variables for mean and standard deviation-Here the "features.txt" dataframe is read in to R, it contains the names of each variable. This dataframe is searched for all variables containing "mean" or "sd". Numerical vectors featuresmean and featuressd are created, containing the number of each mean and sd variable in a sequence 1:561 containing all the variables *Note: here 2 is added to this vector to account for the "Subject" and "Activity" variables, because the data will be merged later on. These vectors are then combined to one numerical vector called "featuresneeded" that contains the numbers of all variables needed. Finally, the new tidy data set "dat2" is created by subsetting the original dataframe "dat" for only the column numbers 1 (for the Subject Column), 2 (for the Activity Column), and the numerical vector "featuresneeded" which contains the column number of all variables containing "mean" or "sd". 

6) Renaming all variables-Here the names of the variables from the dataset "features" are added to the remaining variables by subsetting "features" for only the column numbers in the numerical vector "featuresneeded" *Note, here 2 is subtracted from features needed to unaccount for the "Subject" and "Activity columns (undoing the previous addition of 2). 

7) Cleaning up the variable names-Here gsub is used to replace unwanted characters in the variable names

8) Assigning the names "Subect" and "Activity" to the Subject and activity columns.

9) Assigning all variable names to the dataframe "dat2" using the colnames() function. 

10) Replacing the activity numbers in the "Activity" variable with the activity names using activity_labels.txt

11) Creating an additional, seperate tidy data set by: 

11a) installing and loading the ReShape package.

11b) Melting the data into a data frame "datmelt"

11c) casting new data from the melted data frame and creating the tidy data set "dat 3". 


A full codebook with the names of all the objects in the R environment and the variable names can be found in this repository. 
