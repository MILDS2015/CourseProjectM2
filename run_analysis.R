features <- read.table("./month2Project/features.txt")
columnsofinterest <- grep("(.*)([Mm]ean|[Ss]td)",features$V2)

testdatafile <- read.table(file = "./month2Project/test/X_test.txt")
testdatafile1 <- testdatafile[,columnsofinterest]

testSubjects <- read.table("./month2Project/test/subject_test.txt")
testdatatmp1 <- cbind(testdatafile1, subjects=testSubjects$V1)

testdatafile <- NULL
testdatafile1 <- NULL
testSubjects <- NULL


testactivitylevelData <- read.table("./month2Project/test/y_test.txt")
testdata <- cbind(testdatatmp1, activity=testactivitylevelData$V1)

testdatatmp1 <- NULL
testactivitylevelData <- NULL

## training data	
trainingdatafile <- read.table(file = "./month2Project/train/X_train.txt")
trainingdatafile1 <- trainingdatafile[,columnsofinterest]
trainingdatafile <- NULL

trainingSubjects <- read.table("./month2Project/train/subject_train.txt")
trainingdatatmp1 <- cbind(trainingdatafile1, subjects=trainingSubjects$V1)

trainingdatafile1 <- NULL
trainingSubjects  <-  NULL

trainactivitylevelData <- read.table("./month2Project/train/y_train.txt")
trainingData <- cbind(trainingdatatmp1,activity=trainactivitylevelData$V1)

trainingdatatmp1<- NULL
trainactivitylevelData <- NULL

dataset <- rbind(testdata,trainingData)
testdata <- NULL
trainingData  <- NULL

activitylabels <- read.table("./month2Project/activity_labels.txt",col.names = c("activity","activitylabel"))

datasetlabelt <- merge(dataset,activitylabels, by.x = "activity",by.y = "activity",all.x = FALSE,all.y =FALSE )

datasetlabel <- select(datasetlabelt,-activity)

datasetlabelt <- NULL
dataset <- NULL


df <- data.frame(V2=c("subject","activity") )
names <- features[grepl("(.*)([Mm]ean|[Ss]td)",features$V2),][2]
tmp <- rbind(names,df)
col <- gsub("[()]|[-]","",tmp$V2)
colnames(datasetlabel) <- col



tidyDatat <- aggregate(datasetlabel, by=list(datasetlabel$subject,datasetlabel$activity), mean)

tidyData <-tidyDatat[,1:(ncol(tidyDatat)-2)]
tmp1 <- rbind(df,names)
col1 <- gsub("[()]|[-]","",tmp1$V2)
colnames(tidyData) <- col1

write.table(x = tidyData,file="./month2Project/TidyDataSet.txt",row.names = FALSE)


df<-NULL
names<-NULL
tmp<-NULL
tmp1<-NULL
col<- NULL
tidyDatat <-NULL