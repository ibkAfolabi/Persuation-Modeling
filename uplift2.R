
#CLASSIFICATION USING KNN

#loading the data
course.df <- read.csv("TrainingDS3.csv")

# use head() to view the top 6 rows in the dataset
head(course.df)

# statistical analysis of the data generally 
summary(course.df)






library(ggplot2)

#loading the data
course.df <- read.csv("TrainingDS3.csv")

dat <- data.frame(table(course.df$Sex,course.df$Moved_AD))
names(dat) <- c("Sex","Moved_AD","Count")

ggplot(data=dat, aes(x=Sex, y=Count, fill=Moved_AD)) + geom_bar(stat="identity")


dat <- data.frame(table(course.df$LikeMaths,course.df$Moved_AD))
names(dat) <- c("LikeMaths","Moved_AD","Count")

ggplot(data=dat, aes(x=LikeMaths, y=Count, fill=Moved_AD)) + geom_bar(stat="identity")





# FITTING  RANDOM FOREST PREDICTIVE MODEL
#loading the data
course.df <- read.csv("TrainingDS3.csv")

# select variables
selected.var <- c(1,2,3,4,5,6,7,8,9,10,11)
# partition data
set.seed(1) # set seed for reproducing the partition
train.index <- sample(c(1:222), 89)
train.df <- politics.df[train.index, selected.var]
valid.df <- politics.df[-train.index, selected.var]


library(randomForest)
## random forest
rf <- randomForest(as.factor(Moved_AD)  ~ ., data = train.df, ntree = 500,
                   mtry = 4, nodesize = 5, importance = TRUE)

## calculating the accuracy
rf.pred <- predict(rf, valid.df)
tab <- table(rf.pred,valid.df$Moved_AD)
accuracy <- function(x){sum(diag(x)/(sum(rowSums(x)))) * 100}
accuracy(tab)




# FITTING  KNN PREDICTIVE MODEL
#loading the data
course.df <- read.csv("TrainingDS3knn.csv")

# select variables
selected.var <- c(1,2,3,4,5,6,7,8,9,10,11)

#new dataframe for the selected variables
course.df<-course.df[selected.var]

#converting all the categorical variables to dummies
library(dummies)
knitr::kable(course.df )
results <- fastDummies::dummy_cols(course.df )
head(results)


# partition data
set.seed(1)
train.index <- sample(c(1:dim(results)[1]), dim(results)[1]*0.6)
train.df <- voter.df[train.index, ]
valid.df <- voter.df[-train.index, ]


library(caret)
# initialize normalized training, validation data, complete data frames to originals
train.norm.df <- train.df
valid.norm.df <- valid.df
course.norm.df <- course.df



# code for getting the best k
library(caret)
library(FNN)
library(class)


# initialize a data frame with two columns: k, and accuracy.
accuracy.df <- data.frame(k = seq(1, 14, 1), accuracy = rep(0, 14))

# compute knn for different k on validation.
for(i in 1:14) {
  knn.pred <- knn(train.norm.df[, 1:9], valid.norm.df[, 1:9], 
                  cl = train.norm.df[, 10], k = i)
  
  tab <- table(knn.pred,valid.norm.df[, 10])
  
  ##this function divides the correct predictions by total number of predictions that tell us how accurate the model is.
  
  accuracy <- function(x){sum(diag(x)/(sum(rowSums(x)))) * 100}
  accuracy(tab)
  accuracy.df[i, 2] <- accuracy(tab)
  
}
accuracy.df




# use knn() to compute knn.
# knn() is available in library FNN (provides a list of the nearest neighbors)
# and library class (allows a numerical output variable).
library(FNN)
library(class)
##run knn function 
# we are supposed to use the 3rd data partition here and not the validation to check for the accuracy because # we used the validation to get the best value of k. But we used validation here because the data set is small
pr <- knn(train.norm.df[, 1:10],valid.norm.df[, 1:10],cl=train.norm.df[, 11],k=6)

##create confusion matrix
tab <- table(pr,valid.norm.df[, 11])

##this function divides the correct predictions by total number of predictions that tell us how accurate the model is.

accuracy <- function(x){sum(diag(x)/(sum(rowSums(x)))) * 100}
accuracy(tab)








#UPLIFT MODELING USING RANDOM FOREST ALGORITHM
library(uplift)
course.df <- read.csv("TrainingDS3.csv")

#converting all the categorical variables to dummies
library(dummies)
knitr::kable(course.df )
results <- fastDummies::dummy_cols(course.df )
head(results)


# partition the data
set.seed(1)
train.index <- sample(c(1:dim(results)[1]), dim(results)[1]*0.6)
train.df <- results[train.index, ]
valid.df <- results[-train.index, ]
head(valid.df)

names(results) # print a list of variables to the screen.
# did not use age
# use upliftRF().
up.fit <- upliftRF(Moved_AD ~  Sex_Female+
                     Sex_Male+ LikeMaths_Maybe  + LikeMaths_No+LikeMaths_Yes+LikeMarketing_Maybe+LikeMarketing_No+LikeMarketing_Yes+LikeBusiness_Maybe+LikeBusiness_No+LikeBusiness_Yes+LikeReading_Maybe+LikeReading_No+LikeReading_Yes+LikeProgramming_Maybe+LikeProgramming_No+          
                     +LikeProgramming_Yes+ITParents_Maybe+ITParents_No+ITParents_Yes+LikeToTakeCourse_Maybe+LikeToTakeCourse_No        
                   +LikeToTakeCourse_Yes+AmountToPay_L10000+AmountToPay_L20000+
                     +AmountToPay_L30000+AmountToPay_L40000+AmountToPay_L50000+
                     AmountToPay_G50000 +trt(Message),
                   data = train.df, mtry = 3, ntree = 100, split_method = "KL",
                   minsplit = 10, verbose = TRUE)
pred <- predict(up.fit, newdata = valid.df)

head(pred)
# first colunm: p(y | treatment)
# second colunm: p(y | control)
head(data.frame(pred, "uplift" = pred[,1] - pred[,2]))


#to calculate the uplift for the new data
new.df <- read.csv("TrainingDS3NewData.csv")

#converting all the categorical variables to dummies
library(dummies)
knitr::kable(new.df)
newresults <- fastDummies::dummy_cols(new.df)
names(newresults)
names(newresults)
pred <- predict(up.fit, newdata = newresults)

# first colunm: p(y | treatment)
# second colunm: p(y | control)
head(data.frame(pred2, "uplift" = pred2[,1] - pred2[,2]))


