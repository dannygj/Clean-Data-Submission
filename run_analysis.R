#Download File
fileURL <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
download.file(fileURL,destfile="wearable.zip")

#Unzip File
unzip("wearable.zip")

#Read data into R
testX=read.table("./UCI_HAR_Dataset/test/X_test.txt", stringsAsFactors = FALSE)
testY=read.table("./UCI_HAR_Dataset/test/Y_test.txt", stringsAsFactors = FALSE)
testZ=read.table("./UCI_HAR_Dataset/test/subject_test.txt", stringsAsFactors = FALSE)
test=cbind(testZ, testY, testX)

trainX=read.table("./UCI_HAR_Dataset/train/X_train.txt", stringsAsFactors = FALSE)
trainY=read.table("./UCI_HAR_Dataset/train/Y_train.txt", stringsAsFactors = FALSE)
trainZ=read.table("./UCI_HAR_Dataset/train/subject_train.txt", stringsAsFactors = FALSE)
train=cbind(trainZ, trainY, trainX)

#merge data into one dataset
dat=rbind(train,test)

#Read features table which contains variable names
features=read.table("./UCI_HAR_Dataset/features.txt", stringsAsFactors = FALSE)

#Move it over two because of the subject and activity columns
featuresmean=2+as.numeric(grep("mean",features$V2))
featuressd=2+as.numeric(grep("std",features$V2))
featuresneeded=sort(c(featuressd,featuresmean))

#Create new dataset with only wanted variables included
dat2=dat[,c(1,2,featuresneeded)]

#Rename variables
#Had to minus 2 to unwind from befores +2
variables=features[featuresneeded-2,2]

#Remove characters we don't want in titles
variables=gsub("-","_",variables)
variables=gsub("\\()","",variables)

#Assign Subject and Activity variable names
col1="Subject"
col2="Activity"

#Create vector of all names and assign names to dataset
variablenames=c(col1,col2,variables)
colnames(dat2)=variablenames

#Assign Activity Names from activity_labels.txt
dat2$Activity=gsub("1","WALKING",dat2$Activity)
dat2$Activity=gsub("2","WALKING_UPSTAIRS",dat2$Activity)
dat2$Activity=gsub("3","WALKING_DOWNSTAIRS",dat2$Activity)
dat2$Activity=gsub("4","SITTING",dat2$Activity)
dat2$Activity=gsub("5","STANDING",dat2$Activity)
dat2$Activity=gsub("6","LAYING",dat2$Activity)

#Install and load Reshape Package
install.packages("reshape2")
library(reshape2)

#Melt Data
datMelt <- melt(dat2, id=c("Subject", "Activity"), measure.vars=variables)

#Cast New Data
dat3 <- dcast(datMelt, Subject+Activity~variable, mean)
write.csv(dat3,"tidydata.csv")
