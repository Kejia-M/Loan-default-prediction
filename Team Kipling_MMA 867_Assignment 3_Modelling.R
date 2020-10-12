# install_tensorflow()
# install.packages("ROSE")
library("readxl")
library("lubridate")
library("proto")
library("gsubfn")
library("RSQLite")
library("sqldf")
library("tidyverse")
library("ggplot2")
library("mice")
library("caret")
library("dplyr")
library("tidyr")
library("MASS")
library("car")
library("Metrics")
library("glmnet")
library("xgboost")
library("gbm")
library("mboost")
library("keras")
library("ROSE")
library("caret")
pacman::p_load("caret","partykit","ROCR","lift","rpart","e1071","randomForest","tensorflow")

use_condaenv("r-tensorflow")
use_condaenv("r-reticulate", required = TRUE)

str(credit) # See if some data types were misclassified when importing data from CSV
lapply(credit,class)
lapply(solutions,class)
#for w/ Features 1-9,12-19,23-28 had to remove $AGE_BUCKET and $CREDIT_LIMIT_BUCKET temporarily because 
#they are characters
#credit = credit[,!(names(credit) %in% c("AGE_BUCKET", "CREDIT_LIMIT_BUCKET"))]

set.seed(77850) #set a random number generation seed to ensure that the split is the same everytime
#out of 24000 obs, we gonna split 80% train, 20% test
inTrain <- createDataPartition(y = credit$default_0,
                               p = 22999/24000, list = FALSE)
training <- credit[ inTrain,]
testing <- credit[ -inTrain,]

#Model #1: No features - Logit
#Select the variables to be included in the "base-case" model
#First include all variables use glm(Retained.in.2012.~ ., data=training, family="binomial"(link="logit")) Then see which ones have "NA" in coefficients and remove those
model_logistic<-glm(data.balanced.un$default_0 ~ ., data=data.balanced.un, family="binomial"(link="logit"))

summary(model_logistic) 

#no NAs so, no need surrogate

#using Stepwise and Logit
#Stepwise regressions. There are three aproaches to runinng stepwise regressions: backward, forward and "both"
model_logistic_stepwiseAIC<-stepAIC(model_logistic,direction = c("both"),trace = 1) #AIC stepwise

summary(model_logistic_stepwiseAIC) 

par(mfrow=c(1,4))
plot(model_logistic_stepwiseAIC) #Error plots: similar nature to lm plots
par(mfrow=c(1,1))

###Finding predicitons: probabilities and classification
logistic_probabilities<-predict(model_logistic_stepwiseAIC,newdata=testing,type="response") #Predict probabilities
logistic_classification<-rep("1",1000)
#logistic_classification <- as.integer(logistic_probabilities > mean(testing$default_0 == "1"))
logistic_classification[logistic_probabilities<0.2210877]="0" #Predict classification using 0.6073 threshold. Why 0.6073 - that's the average probability of being retained in the data. An alternative code: logistic_classification <- as.integer(logistic_probabilities > mean(testing$Retained.in.2012. == "1"))
logistic_classification<-as.factor(logistic_classification)

###Confusion matrix  
cf <- confusionMatrix(logistic_classification,testing$default_0,positive = "1") #Display confusion matrix

cf
#profit
(cf$table[1,1] * 1500) - (cf$table[1,2] * 5000)

####ROC Curve
logistic_ROC_prediction <- prediction(logistic_probabilities, testing$default_0)
logistic_ROC <- performance(logistic_ROC_prediction,"tpr","fpr") #Create ROC curve data
plot(logistic_ROC) #Plot ROC curve

####AUC (area under curve)
auc.tmp <- performance(logistic_ROC_prediction,"auc") #Create AUC data
logistic_auc_testing <- as.numeric(auc.tmp@y.values) #Calculate AUC
#AUC: 0.7670249  Accuracy : 0.7722 
#1-4 - AUC: 0.7679142  Accuracy : 0.7706
#1-9,12 - AUC: 0.7692753  Accuracy : 0.771

logistic_auc_testing #Display AUC value: 90+% - excellent, 80-90% - very good, 70-80% - good, 60-70% - so so, below 60% - not much value

#### Lift chart
plotLift(logistic_probabilities, testing$default_0, cumulative = TRUE, n.buckets = 10) # Plot Lift chart

# There are two families of CART algorithms: conditoinal interence trees (ctree function; caret package) 
#and recursive partitioning (rpart function; partykit package)

#Model #2: using CTREE
ctree_tree<-ctree(data.balanced.both$default_0 ~ .,data=data.balanced.both) #Run ctree on training data
plot(ctree_tree, gp = gpar(fontsize = 8)) #Plotting the tree (adjust fontsize if needed)

ctree_probabilities<-predict(ctree_tree,newdata=testing,type="prob") #Predict probabilities
ctree_classification<-rep("1",1000)
mean(testing$default_0 == "1")
#ctree_classification <- as.integer(ctree_probabilities > mean(testing$default_0 == "1"))
ctree_classification[ctree_probabilities[,2]<0.221]="0" #Predict classification using 0.6073 threshold. Why 0.6073 - that's the average probability of being retained in the data. An alternative code: logistic_classification <- as.integer(logistic_probabilities > mean(testing$Retained.in.2012. == "1"))
ctree_classification<-as.factor(ctree_classification)

###Confusion matrix  
cf <- confusionMatrix(ctree_classification,testing$default_0,positive = "1")

cf
#profit
(cf$table[1,1] * 1500) - (cf$table[1,2] * 5000)

####ROC Curve
ctree_probabilities_testing <-predict(ctree_tree,newdata=testing,type = "prob") #Predict probabilities
ctree_pred_testing <- prediction(ctree_probabilities_testing[,2], testing$default_0) #Calculate errors
ctree_ROC_testing <- performance(ctree_pred_testing,"tpr","fpr") #Create ROC curve data
plot(ctree_ROC_testing) #Plot ROC curve

####AUC (area under curve)
auc.tmp <- performance(ctree_pred_testing,"auc") #Create AUC data
ctree_auc_testing <- as.numeric(auc.tmp@y.values) #Calculate AUC
#AUC: 0.7625036 Accuracy : 0.7485
#1-4 - AUC: 0.7616805  Accuracy : 0.7524
#1-9,12 - AUC: 0.7616805  Accuracy : 0.7570393
#1-9,12-19 - AUC: 0.7570577  Accuracy : 0.7777
#1-9,12-19,23-28 - AUC: 0.7571825  Accuracy : 0.7625
##29-34 - AUC: 0.7593259  Accuracy : 0.7499
##ALL - AUC: 0.765091  Accuracy : 0.7835
ctree_auc_testing #Display AUC value: 90+% - excellent, 80-90% - very good, 70-80% - good, 60-70% - so so, below 60% - not much value

#### Lift chart
plotLift(ctree_probabilities[,2],  testing$default_0, cumulative = TRUE, n.buckets = 10) # Plot Lift chart

#Model 3: No features - using RPART
# The rpart method has an important "complexity parameter", cp, which determines how big the tree is.  

results <- cbind("cp", "auctest", "auctrain")

CART_cp = rpart.control(cp = 0.0005) #set cp to a small number to "grow" a large tree

rpart_tree<-rpart(data.balanced.both$default_0 ~.,data=data.balanced.both, method="class", control=CART_cp) #"Grow" a tree on training data

prunned_rpart_tree<-prune(rpart_tree, cp=0.007) #Prun the tree. Play with cp to see how the resultant tree changes
plot(as.party(prunned_rpart_tree), type = "extended",gp = gpar(fontsize = 7)) #Plotting the tree (adjust fontsize if needed)

# Understand the relationship between the cross-validated error, size of the tree and cp.
plotcp(rpart_tree) # Use printcp(rpart_tree) to print the values. As a rule of thumb pick up the largest cp which does not give a substantial drop in error

rpart_prediction_class<-predict(prunned_rpart_tree,newdata=testing, type="class") #Predict classification (for confusion matrix)
cf <- confusionMatrix(rpart_prediction_class,testing$default_0,positive = "1") #Display confusion matrix

cf
#profit
(cf$table[1,1] * 1500) - (cf$table[1,2] * 5000)

rpart_probabilities_testing <-predict(prunned_rpart_tree,newdata=testing,type = "prob") #Predict probabilities
rpart_pred_testing <- prediction(rpart_probabilities_testing[,2], testing$default_0) #Calculate errors
rpart_ROC_testing <- performance(rpart_pred_testing,"tpr","fpr") #Create ROC curve data
plot(rpart_ROC_testing) #Plot ROC curve

auc.tmp <- performance(rpart_pred_testing,"auc") #Create AUC data
rpart_auc_testing <- as.numeric(auc.tmp@y.values) #Calculate AUC
#AUC: 0.6377481  Accuracy : 0.8158
#1-4 - AUC: 0.6377481  Accuracy : 0.8158 
#1-9,12-19 - AUC: 0.6377481  Accuracy : 0.8158 
#1-9,12-19,23-28 - AUC: 0.6377481  Accuracy : 0.8158
##29-34 - AUC: 0.6377481  Accuracy : 0.8158
##ALL - AUC: 0.6377481  Accuracy : 0.8158
rpart_auc_testing #Display AUC value

plotLift(rpart_prediction_class,  testing$default_0, cumulative = TRUE, n.buckets = 10) # Plot Lift chart

#Model 4: No features - using Random Forest
model_forest <- randomForest(training$default_0 ~ ., data=training, 
                             type="classification",
                             importance=TRUE,
                             ntree = 500,           # hyperparameter: number of trees in the forest
                             mtry = 10,             # hyperparameter: number of random columns to grow each tree
                             nodesize = 10,         # hyperparameter: min number of datapoints on the leaf of each tree
                             maxnodes = 10,         # hyperparameter: maximum number of leafs of a tree
                             cutoff = c(0.5, 0.5)   # hyperparameter: how the voting works; (0.5, 0.5) means majority vote
) 

plot(model_forest)  # plots error as a function of number of trees in the forest; use print(model_forest) to print the values on the plot

importance(model_forest)
varImpPlot(model_forest) # plots variable importances; use importance(model_forest) to print the values


###Finding predicitons: probabilities and classification
forest_probabilities<-predict(model_forest,newdata=testing,type="prob") #Predict probabilities -- an array with 2 columns: for not retained (class 0) and for retained (class 1)
forest_classification<-rep("1",1000)
forest_classification[forest_probabilities[,2]<0.221]="0" #Predict classification using 0.5 threshold. Why 0.5 and not 0.6073? Use the same as in cutoff above
forest_classification<-as.factor(forest_classification)

cf <- confusionMatrix(forest_classification,testing$default_0, positive="1") #Display confusion matrix. Note, confusion matrix actually displays a better accuracy with threshold of 50%
cf
#profit
(cf$table[1,1] * 1500) - (cf$table[1,2] * 5000)
#There is also a "shortcut" forest_prediction<-predict(model_forest,newdata=testing, type="response") 
#But it by default uses threshold of 50%: actually works better (more accuracy) on this data


####ROC Curve
forest_ROC_prediction <- prediction(forest_probabilities[,2], testing$default_0) #Calculate errors
forest_ROC <- performance(forest_ROC_prediction,"tpr","fpr") #Create ROC curve data
plot(forest_ROC) #Plot ROC curve

####AUC (area under curve)
AUC.tmp <- performance(forest_ROC_prediction,"auc") #Create AUC data
forest_AUC <- as.numeric(AUC.tmp@y.values) #Calculate AUC
#AUC: 0.7061529  Accuracy : 0.8183  
#1-9,12-19 - AUC: 0.724927  Accuracy : 0.8164  
#1-9,12-19,23-28 - AUC: 0.7241546  Accuracy : 0.8162
##29-34 - AUC: 0.7176697  Accuracy : 0.816
##ALL - AUC: 0.7250355  Accuracy : 0.8145
forest_AUC #Display AUC value: 90+% - excellent, 80-90% - very good, 70-80% - good, 60-70% - so so, below 60% - not much value

#### Lift chart
plotLift(forest_probabilities[,2],  testing$default_0, cumulative = TRUE, n.buckets = 10) # Plot Lift chart

### An alternative way is to plot a Lift curve not by buckets, but on all data points
Lift_forest <- performance(forest_ROC_prediction,"lift","rpp")
plot(Lift_forest)

####Now we try balancing the data
#https://www.analyticsvidhya.com/blog/2016/03/practical-guide-deal-imbalanced-classification-problems/

#let's balancing the training data
#check training table
table(training$default_0)
#we see alot of 0 - 14956 (0) and 4245(1)

#check classes distribution
prop.table(table(training$default_0))
#77.89% (0), 22.11% (1)

#undersampling 
data.balanced.un <- ovun.sample(default_0~., data=training,
                                N=10612,  seed=1, method="under")$data
table(data.balanced.un$default_0)

#both
data.balanced.both <- ovun.sample(default_0~., data=training,
                                p=0.5,  seed=1, method="both")$data
table(data.balanced.both$default_0)

#ROSE
data.rose <- ROSE(default_0 ~ ., data = training, seed = 1)$data
table(data.rose$default_0)

summary(data.balanced.un)

#define random forest model
model_forest <- randomForest(default_0~ ., data=data.balanced.un, 
                             type="classification",
                             importance=TRUE,
                             ntree = 500,         # hyperparameter: number of trees in the forest
                             mtry = 10,           # hyperparameter: number of random columns to grow each tree
                             nodesize = 1,       # hyperparameter: min number of datapoints on the leaf of each tree
                             maxnodes = 20,       # hyperparameter: maximum number of leafs of a tree
                             cutoff = c(0.75, 0.25) # hyperparameter: how the voting works; (0.5, 0.5) means majority vote
) 

plot(model_forest) # plots error as a function of number of trees in the forest; use print(model_forest) to print the values on the plot
print(model_forest)

#check variable importance
varImpPlot(model_forest) # plots variable importances; use importance(model_forest) to print the values
importance(model_forest)

#finding predicitons: probabilities and classification
forest_probabilities<-predict(model_forest,newdata=testing, type = "prob") #Predict probabilities -- an array with 2 columns: for not retained (class 0) and for retained (class 1)

#create vector of 1's that matches test set length
forest_classification<-rep("1",1000)

#Predict classification using 0.5 threshold. Why 0.5 and not 0.22104? Use the same as in cutoff above
forest_classification[forest_probabilities[,2]<0.221]="0"
forest_classification<-as.factor(forest_classification)

#confusion matrix
cf <- confusionMatrix(forest_classification,testing$default_0, positive="1") #Display confusion matrix. Note, confusion matrix actually displays a better accuracy with threshold of 50%

cf
#profit
(cf$table[1,1] * 1500) - (cf$table[1,2] * 5000)

#ROC Curve
forest_ROC_prediction <- prediction(forest_probabilities[,2], testing$default_0) #Calculate errors
forest_ROC <- performance(forest_ROC_prediction,"tpr","fpr") #Create ROC curve data
plot(forest_ROC) #Plot ROC curve

#AUC (area under curve)
AUC.tmp <- performance(forest_ROC_prediction,"auc") #Create AUC data
forest_AUC <- as.numeric(AUC.tmp@y.values) #Calculate AUC
forest_AUC #Display AUC value
#observations: AUC = 0.7132387 (decrease from logit model)

# Lift chart
plotLift(forest_probabilities[,2],  testing$default_0, cumulative = TRUE, n.buckets = 10) # Plot Lift chart

#This is the chosen model - write predictions
#finding predicitons: probabilities and classification
forest_probabilities<-predict(model_forest,newdata=solutions, type = "prob") #Predict probabilities -- an array with 2 columns: for not retained (class 0) and for retained (class 1)

#create vector of 1's that matches test set length
forest_classification<-rep("1",1000)

#Predict classification using 0.5 threshold. Why 0.5 and not 0.22104? Use the same as in cutoff above
forest_classification[forest_probabilities[,2]<0.221]="0"
forest_classification<-as.factor(forest_classification)
#write to csv
colnames(forest_classification) <- c("X")
write.csv(forest_probabilities, "Team Kipling.csv", row.names=FALSE)

#----- TEST SUPPORT VECTOR MACHINES MODEL -----
#define SVM model
model_svm <- svm(default_0 ~., data=data.balanced.both, probability=TRUE)
summary(model_svm)
#observations: # of support vectors = 8262

#predict classification
svm_probabilities<-attr(predict(model_svm,newdata=testing, probability=TRUE), "prob")
svm_prediction<-svm_probabilities[,1]

#create vector of 1's that matches test set length
svm_classification<-rep("1",1000)

#set threshold
svm_classification[svm_prediction<0.221]="0" 
svm_classification<-as.factor(svm_classification)

#confusion matrix
cf <- confusionMatrix(svm_classification,testing$default_0,positive = "1")
cf
#profit
(cf$table[1,1] * 1500) - (cf$table[1,2] * 5000)
#observations: Accuracy = 81.25% (highest thus far, slightly better than random forest model)

#ROC Curve
svm_ROC_prediction <- prediction(svm_prediction, testing$default_0) #Calculate errors
svm_ROC_testing <- performance(svm_ROC_prediction,"tpr","fpr") #Create ROC curve data
plot(svm_ROC_testing) #Plot ROC curve

#AUC
auc.tmp <- performance(svm_ROC_prediction,"auc") #Create AUC data
svm_auc_testing <- as.numeric(auc.tmp@y.values) #Calculate AUC
svm_auc_testing #Display AUC value
#observations: AUC = 0.7015 (worst thus far, slightly worse than random forest)

# Lift chart
plotLift(svm_prediction, testing$default_0, cumulative = TRUE, n.buckets = 10) # Plot Lift chart

#----- TEST NEURAL NET (ANN0) MODEL -----

x_ANNtrain <- model.matrix(default_0 ~ ., data = data.balanced.both)[,-1]
x_ANNtest <- model.matrix(default_0 ~ ., data = testing)[,-1]

str(x_ANNtrain) #this will give us #columns
str(x_ANNtest) #this will give us #columns

x_ANNtrain <- scale(x_ANNtrain) # scaling for X (like the z-score)
x_ANNtest <- scale(x_ANNtest) # scaling for X (like the z-score)

#grabbing the response var from original dataset
y_train <-data.balanced.both$default_0
y_test <-testing$default_0

#Keras interprets data using row-major semantics (as opposed to R's default column-major semantics). Must "reshape" the matrices 
#**NOTE**: The columns parameter below is subject to change (check # of columns in x_ANNtrain/test and replace the integer below)
x_ANNtrain <- array_reshape(x_ANNtrain, c(nrow(x_ANNtrain), 130))
x_ANNtest <- array_reshape(x_ANNtest, c(nrow(x_ANNtest), 130))

#convert to categoricals
y_ANNtrain <- to_categorical(y_train, 2) #this is python code (leveraging keras package)
y_ANNtest <- to_categorical(y_test, 2)

#define keras model
model_keras <- keras_model_sequential()

model_keras %>% 
  layer_dense(units = 128, activation = 'relu') %>% 
  layer_dropout(rate = 0.3) %>% 
  layer_dense(units = 64, activation = 'relu') %>%
  layer_dropout(rate = 0.2) %>%
  layer_dense(units = 2, activation = 'softmax')

model_keras %>% compile(
  loss = 'binary_crossentropy',
  optimizer = 'adam',
  metrics = c('accuracy')
)

#training / "fitting" the model
history <- model_keras %>% fit(
  x_ANNtrain, y_ANNtrain, # on what data to train
  epochs = 30, # how many repetitions to have
  batch_size = 128, # how many datapoints are fed to the network at a time 
  validation_split = 0.2  # percentage of training data to keep for cross-validation 
)

summary(model_keras)
#observations: 18,370 parameters

plot(history)
#observations: Need more epochs? They don't intersect within 30 epochs

# model %>% evaluate(x_test, y_test) # apply the model to testing data
#predict probabilities
TF_NN_probabilities <- model_keras %>% predict(x_ANNtest)
TF_NN_prediction <- TF_NN_probabilities[,2]

#create vector of 1's that matches test set length
TF_NN_classification<-rep("1",1000)
TF_NN_classification[TF_NN_prediction<0.221]="0" 
TF_NN_classification<-as.factor(TF_NN_classification)

cf <- confusionMatrix(TF_NN_classification,testing$default_0,positive = "1")
cf
#profit
(cf$table[1,1] * 1500) - (cf$table[1,2] * 5000)
####ROC Curve
TF_NN_ROC_prediction <- prediction(TF_NN_prediction, testing$default_0) #Calculate errors
TF_NN_ROC_testing <- performance(TF_NN_ROC_prediction,"tpr","fpr") #Create ROC curve data
plot(TF_NN_ROC_testing) #Plot ROC curve

####AUC
auc.tmp <- performance(TF_NN_ROC_prediction,"auc") #Create AUC data
TF_NN_auc_testing <- as.numeric(auc.tmp@y.values) #Calculate AUC
TF_NN_auc_testing #Display AUC value: 90+% - excellent, 80-90% - very good, 70-80% - good, 60-70% - so so, below 60% - not much value

#### Lift chart
plotLift(TF_NN_prediction, testing$default_0, cumulative = TRUE, n.buckets = 10) # Plot Lift chart
