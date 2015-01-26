# Get features labels
features        <- read.table("./UCI HAR Dataset/features.txt")
# Get activity labels
activity_labels <- read.table("./UCI HAR Dataset/activity_labels.txt")

# Get test data
subject_test    <- read.table("./UCI HAR Dataset/test/subject_test.txt")
X_test          <- read.table("./UCI HAR Dataset/test/X_test.txt")
y_test          <- read.table("./UCI HAR Dataset/test/y_test.txt")

# Get train data
subject_train   <- read.table("./UCI HAR Dataset/train/subject_train.txt")
X_train         <- read.table("./UCI HAR Dataset/train/X_train.txt")
y_train         <- read.table("./UCI HAR Dataset/train/y_train.txt")

# Label test and train sets with features labels
names(X_test) <- features[,2]
names(X_train) <- features[,2]

# Merge all sets
subject_merge <- rbind(subject_test, subject_train)
X_merge <- rbind(X_test, X_train)
y_merge <- rbind(y_test, y_train)

# Label test and train subjects
names(subject_merge) <- "Subject"

# Label y_merge with corresponding activities
activity_merge <- merge(y_merge, activity_labels, by.x="V1", by.y = "V1")

# Build final table
final <- cbind(subject_merge, activity_merge[,2], X_merge[,grepl("mean|std", features[,2])])
colnames(final)[2] <- "Activity"

write.table(final, file = "./final.txt")