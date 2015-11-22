# Read the data from the different sources
# Read the training data
training = read.csv("./data/UCI HAR Dataset/train/X_train.txt", sep="", header=FALSE)
training[,562] = read.csv("./data/UCI HAR Dataset/train/Y_train.txt", sep="", header=FALSE)
training[,563] = read.csv("./data/UCI HAR Dataset/train/subject_train.txt", sep="", header=FALSE)
# Read the testing data
testing = read.csv("./data/UCI HAR Dataset/test/X_test.txt", sep="", header=FALSE)
testing[,562] = read.csv("./data/UCI HAR Dataset/test/Y_test.txt", sep="", header=FALSE)
testing[,563] = read.csv("./data/UCI HAR Dataset/test/subject_test.txt", sep="", header=FALSE)
# Read the labels of columns
labels = read.csv("./data/UCI HAR Dataset/activity_labels.txt", sep="", header=FALSE)
# join training and testing data
unique_df = rbind(training, testing)
# read the features specifications
features = read.csv("./data/UCI HAR Dataset/features.txt", sep="", header=FALSE)
# Keep only the features match with mean and standard measurments
mean_std_value <- grep(".*-mean.*|.*-std.*", features[,2])
# Add the features names to features
features <- features[mean_std_value,]
# Add the columns corresponding to activity and subject
mean_std_value <- c(mean_std_value, 562, 563)
# for the unique data frame, keep only the columns corresponding with the wanted features
unique_df <- unique_df[,mean_std_value]
# name the column
colnames(unique_df) <- c(features$V2, "Activity", "Subject")
colnames(unique_df) <- tolower(colnames(unique_df))


write.table(unique_df, "result_df.txt", row.names = FALSE)