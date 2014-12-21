## Load Training files
train_x<-read.table("UCI HAR Dataset\\train\\X_train.txt",header=FALSE)
train_y<-read.table("UCI HAR Dataset\\train\\Y_train.txt",header=FALSE)
train_sub<-read.table("UCI HAR Dataset\\train\\subject_train.txt",header=FALSE)

## Load Test files
test_x<-read.table("UCI HAR Dataset\\test\\X_test.txt",header=FALSE)
test_y<-read.table("UCI HAR Dataset\\test\\Y_test.txt",header=FALSE)
test_sub<-read.table("UCI HAR Dataset\\test\\subject_test.txt",header=FALSE)

## Load activity codes and features. Select fields that are relevant to the assignment (mean and std)
activities<-read.table("UCI HAR Dataset\\activity_labels.txt")
features<-read.table("UCI HAR Dataset\\features.txt",header=FALSE)
fields<-features[grep(".*(mean|std).*", features[,2], ignore.case=F),]

## Subset x files to keep only relevant field
train_x<-train_x[,c(fields[,1])]
test_x<-test_x[,c(fields[,1])]

## Add names to variables in all tables
names(train_x)<-fields[,2]
names(test_x)<-fields[,2]
names(train_y)<-c("code")
names(test_y)<-c("code")
names(train_sub)<-c("subject")
names(test_sub)<-c("subject")
names(activities)<-c("code","activity")

## Create tidy table
train_data<-cbind(train_sub,train_y)
train_data<-cbind(train_data,train_x)
test_data<-cbind(test_sub,test_y)
test_data<-cbind(test_data,test_x)
tidy_table<-rbind(train_data,test_data)

## Get labels for activities, remove activity codes and reorder columns in final table
tidy_table<-merge(activities,tidy_table,by="code")
tidy_table<-tidy_table[c(3,2,4:length(names(tidy_table)))]

##Create file tidy_table.txt
write.table(tidy_table,"tidy_table.txt",row.name=FALSE)
