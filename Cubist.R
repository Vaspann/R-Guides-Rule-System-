#Rule based machine learning algorithms work on set of rules that are 
#either predefined by us or they develop those rules themselves.
#These algorithms are less agile when creating a model or making predictions 
#based on that model, however, as a result they much faster.

#In this example we will be using  a cubist model which combines decision trees
#and linear regression to predict median house value

library(caTools)
library(Cubist)
library(mlbench)
data(BostonHousing)


summary(BostonHousing)
str(BostonHousing)


#create training and test set -------------------------------------------

set.seed(123)
splitcc <- sample.split(BostonHousing, SplitRatio = 0.8)
train <- subset(BostonHousing, splitcc == "TRUE")
test <- subset(BostonHousing, splitcc == "FALSE")



#Create a model
cb_model_1 <- cubist(train[,-14], train$medv)
cb_model_1
summary(cb_model_1)

#Model testing
pred_test_1 <- predict(cb_model_1, newdata = test)
plot(pred_test_1, test$medv)
cor(pred_test_1, test$medv) # 0.93 correlation
mean(abs(pred_test_1 - test$medv)) # 2.5 MAE


#The model seems to have overfit but it did reasonably well on the test set
#We can further improve the model by altering committees and 
#control arguments


