#The One Rule algorithm builds a model according 
#to the (OneR) machine learning classification algorithm to
#determine the class(explanotary variable)

library(kohonen)
library(tibble)
library(caTools)
library(OneR)


#load the data
data("wines", package = "kohonen")
df <- as.tibble(wines)

df <-  cbind(df, vintages)

#Examine the data 

str(df)
summary(df)
table(df$vintages)

#train and test
set.seed(123)  # for reproducibility

splitcc <- sample.split(df, SplitRatio = 0.8)
train <- subset(df, splitcc == "TRUE")
test <- subset(df, splitcc == "FALSE")


#OneR model

oner_model <- OneR(vintages~., train, verbose = TRUE)
oner_model
summary(oner_model)
plot(oner_model)

#Model Accuracy % 84.21
p <- predict(oner_model, newdata = test)
eval_model(p, test$vintages)



#Use optbin function to reduce the number of rules and increase accuracy

df_2 <- optbin(df)
head(df_2)

#train and test
set.seed(123)  # for reproducibility

splitcc <- sample.split(df_2, SplitRatio = 0.8)
train_2 <- subset(df_2, splitcc == "TRUE")
test_2 <- subset(df_2, splitcc == "FALSE")

#OneR model 2

oner_model_2 <- OneR(vintages~., train_2, verbose = TRUE)
oner_model_2
summary(oner_model_2)
plot(oner_model_2)

#Model Accuracy improved to % 86.84
p_2 <- predict(oner_model_2, newdata = test_2)
eval_model(p_2, test_2$vintages)

