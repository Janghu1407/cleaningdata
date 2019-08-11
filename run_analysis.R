library(dplyr)

if(dir.exists("UCI HAR Dataset")){
        setwd("./UCI HAR Dataset")
}else if(file.exists("getdata_projectfiles_UCI HAR Dataset.zip")){
        unzip("getdata_projectfiles_UCI HAR Dataset.zip")
}else{
        tmp <- tempfile()
        url <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
        download.file(url, tmp)
        unzip(tmp)
        setwd("./UCI HAR Dataset")
        unlink(tmp)
}

p1 <- file.path("./test/X_test.txt")
p2 <- file.path("./train/X_train.txt")

testdata <- read.table(p1, header = TRUE, stringsAsFactors = FALSE)
testdata <- tbl_df(testdata)
test_lables<-read.table("test/Y_test.txt")
test_lables <- as.matrix(test_lables[(2:2947), ])

traindata<- read.table(p2, header = TRUE, stringsAsFactors = FALSE)
traindata <- tbl_df(traindata)
train_lables<-read.table("train/Y_train.txt")
train_lables <- as.matrix(train_lables[(2:7352), ])

col_names <- readLines("features.txt")
colnames(traindata)<-make.names(col_names)
colnames(testdata)<-make.names(col_names)
colnames(train_lables)<-"label"
colnames(test_lables)<-"label"

data<-rbind(traindata,testdata)
data <- data[ ,grep("[Mm]ean|[Ss]td", names(data))]
level <- rbind(train_lables, test_lables)
data <- cbind(data, level)

data <- transform(data, level=factor(level))
levels(data$level) <- activity_labels$V2

train_subjects <- read.table('train/subject_train.txt')
train_subjects <- as.matrix(train_subjects[2:7352, ]) 

test_subjects <- read.table('test/subject_test.txt')
test_subjects <- as.matrix(test_subjects[2:2947, ])

subjects <- rbind(train_subjects, test_subjects)
data <-cbind(subjects, data)

data[,1:ncol(data)] <- lapply(data[,1:ncol(data)], as.numeric)
names(data) <- gsub("\\.", "", names(data))
data <- group_by(data, level, subjects)
ans <- summarise_all(data, mean)
ans <- transform(ans, level=factor(level))
levels(ans$level) <- activity_labels$V2


write.table(ans,file="tidydata.txt",row.names = FALSE )
View(ans)

