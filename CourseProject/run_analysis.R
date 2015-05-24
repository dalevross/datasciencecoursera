# Load libraries
library(dplyr)
library(data.table)
features <- fread("features.txt")
activity_labels <- fread("activity_labels.txt")
meansstds <- grep("mean\\(|std\\(", features$V2) 


#merge training datasets
x_train <- read.table("train/X_train.txt",header=FALSE)
names(x_train) <- features$V2
meansstds <- grep("mean\\(|std\\(", features$V2) 
x_train <- x_train[,meansstds]
names(x_train)  <- gsub("\\(|\\)","",names(x_train))
y_train <- fread("train/y_train.txt")
y_train <- mutate(y_train, activity = factor(V1, labels=(activity_labels$V2)))
subject_train <- fread("train/subject_train.txt")
setnames(subject_train,"V1","subject")
train <- cbind(subject_train,y_train$activity,x_train)


#merge test datasets
x_test <- read.table("test/X_test.txt",header=FALSE)
names(x_test) <- features$V2
x_test <- x_test[,meansstds]
names(x_test)  <- gsub("\\(|\\)","",names(x_test))
y_test <- fread("test/y_test.txt")
y_test <- mutate(y_test, activity = factor(V1, labels=(activity_labels$V2)))
subject_test <- fread("test/subject_test.txt")
setnames(subject_test,"V1","subject")
test <- cbind(subject_test,y_test$activity,x_test)
merged <- rbind(test,train)
setnames(merged,"V2","activity")

final <- merged %>% group_by(subject,activity) %>% summarise_each(funs(mean))
arrange(final,subject,activity)

write.table(final,file="tidy.txt",row.names=FALSE)

