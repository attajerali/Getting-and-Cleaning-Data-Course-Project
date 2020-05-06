library(reshape2)
library(data.table)


#1. get dataset 

rawDataUrl <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
rawDataDFn <- paste("./rawData", "/", "rawData.zip", sep = "")
dataDir <- "./data"

if (!file.exists(rawDataDir)) {
  dir.create(rawDataDir)
  download.file(url = rawDataUrl, destfile = rawDataDFn)
}
if (!file.exists(dataDir)) {
  dir.create(dataDir)
  unzip(zipfile = rawDataDFn, exdir = dataDir)
}



#2. Merges the training and the test sets to create one data set

x_train <- read.table(paste(sep = "", dataDir, "/UCI HAR Dataset/train/X_train.txt"))
y_train <- read.table(paste(sep = "", dataDir, "/UCI HAR Dataset/train/Y_train.txt"))
subject_train <- read.table(paste(sep = "", dataDir, "/UCI HAR Dataset/train/subject_train.txt"))

x_test <- read.table(paste(sep = "", dataDir, "/UCI HAR Dataset/test/X_test.txt"))
y_test <- read.table(paste(sep = "", dataDir, "/UCI HAR Dataset/test/Y_test.txt"))
subject_test <- read.table(paste(sep = "", dataDir, "/UCI HAR Dataset/test/subject_test.txt"))

x_data <- rbind(x_train, x_test)
y_data <- rbind(y_train, y_test)
subject_data <- rbind(subject_train, subject_test)





# load feature Info
feature <- read.table(paste(sep = "", dataDir, "/UCI HAR Dataset/features.txt"))

# load activity labels Info
activity_labels <- read.table(paste(sep = "", dataDir, "/UCI HAR Dataset/activity_labels.txt"))
activity_labels[,2] <- as.character(activity_labels[,2])




# 3. extract feature cols & names named 'mean, std'
selectedCols <- grep("-(mean|std).*", as.character(feature[,2]))
selectedColNames <- feature[selectedCols, 2]
selectedColNames <- gsub("-mean", "Mean", selectedColNames)
selectedColNames <- gsub("-std", "Std", selectedColNames)
selectedColNames <- gsub("[-()]", "", selectedColNames)




#4. extract data by cols & using descriptive name
x_data <- x_data[selectedCols]
allData <- cbind(subject_data, y_data, x_data)
View(allData)
colnames(allData) <- c("Subject", "Activity", selectedColNames)
View(allData)

allData$Activity <- factor(allData$Activity, levels = activity_labels[,1], labels = activity_labels[,2])
allData$Subject <- as.factor(allData$Subject)



#5. tidy data set
meltedData <- melt(allData, id = c("Subject", "Activity"))
tidyData <- dcast(meltedData, Subject + Activity ~ variable, mean)
View(tidyData)
write.table(tidyData, "./tidy_dataset.txt", row.names = FALSE, quote = FALSE)
