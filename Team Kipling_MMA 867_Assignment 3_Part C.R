# create a data frame with Threshold values

increment <- 0.01


credit.sex <- data.frame("Threshold" = numeric(1), "Profit" = numeric(1), "Accuracy" = numeric(1), "Sensitivity" = numeric(1), 
                         "Specificity " = numeric(1), "Percent_males" = numeric(1), "Percent_females" = numeric(1) )  
                        # creating blank data frame with the necessary columns
view(credit.sex)


i = 0

while (i <= 1) 
{
  
  #####
  #####
  #####
  
  #### insert Random Forest model here !!!! or whichever is best  
  
  

  
  #define random forest model
  #####
  ##### this is the random forest model for the underbalanced data
  #####
  model_forest <- randomForest(default_0~ ., data=data.balanced.un, 
                               type="classification",
                               importance=TRUE,
                               ntree = 500,         # hyperparameter: number of trees in the forest
                               mtry = 10,           # hyperparameter: number of random columns to grow each tree
                               nodesize = 10,       # hyperparameter: min number of datapoints on the leaf of each tree
                               maxnodes = 10,       # hyperparameter: maximum number of leafs of a tree
                               cutoff = c(0.5, 0.5) # hyperparameter: how the voting works; (0.5, 0.5) means majority vote
  ) 
  
  plot(model_forest) # plots error as a function of number of trees in the forest; use print(model_forest) to print the values on the plot
  print(model_forest)
  
  #check variable importance
  varImpPlot(model_forest) # plots variable importances; use importance(model_forest) to print the values
  importance(model_forest)
  
  #finding predicitons: probabilities and classification
  forest_probabilities<-predict(model_forest,newdata=testing,type="prob") #Predict probabilities -- an array with 2 columns: for not retained (class 0) and for retained (class 1)
  
  #create vector of 1's that matches test set length
  forest_classification<-rep("1",1000)
  
  #Predict classification using 0.5 threshold. Why 0.5 and not 0.22104? Use the same as in cutoff above
  forest_classification[forest_probabilities[,2]<i]="0"
  forest_classification<-as.factor(forest_classification)
  
  ### space in the following code right after: logistic_classification<-as.factor(logistic_classification)
  
  ####  !!!! here !!!!
  
  ###and before
  ###Confusion matrix  
  ###cf <- confusionMatrix(logistic_classification,testing$default_0,positive = "1") #Display confusion matrix
  
  
  # this block of code here is to get the stuff to plot
  
  #modelresuts <- logistic_classification
  # modelresuts <- ctree_classification
  # modelresuts <- rpart_prediction_class
  modelresuts <- forest_classification
  #str(modelresuts) 
  #summary(modelresuts)
  #length(modelresuts)
  #nrow(modelresuts)
  
  testing$Modelresults <- modelresuts   # add in a new column to the testing data
  
  #testing <- cbind(testing, modelresuts) using cbind here is not a good option  better to use $
  #testing$Modelresults
  #str(testing)
  #nrow(testing)
  #length(testing$Modelresults)
  #view(testing)
  
  #########################
  ####################################### # Percent males and Females
  #########################
  length(which(testing$Modelresults == 0 & testing$SEX == 1)) # to get the count of the number of predicted 0's - i.e. all the predicted customers that don't default
  percent_males <- length(which(testing$Modelresults == 0 & testing$SEX == 1)) * 100 / length(which(testing$Modelresults == 0)) # percent Males given credit
  percent_females <- length(which(testing$Modelresults == 0 & testing$SEX == 2)) * 100 / length(which(testing$Modelresults == 0)) # percent FeMales given credit
  
  #########################
  ####################################### # Profit Accuracy Sensitivity Specificity  
  #########################
  
  ###Confusion matrix  - Comment oout the others while the applicable model is in the while loop
  #cm <- confusionMatrix(logistic_classification,testing$default_0,positive = "1") #Display confusion matrix
  #cm <- confusionMatrix(ctree_classification,testing$default_0,positive = "1")
  #cm <- confusionMatrix(rpart_prediction_class,testing$default_0,positive = "1")
  cm <- confusionMatrix(forest_classification,testing$default_0, positive="1")
  
  str(cm)
  
  truenegatives <- cm$table[1,1]
  falsenegatives <- cm$table[1,2]
  profit <- 1500 * truenegatives - 5000 * falsenegatives
  
  accuracy <- as.numeric(cm$overall[1])
  sensitivity <- as.numeric(cm$byClass[1])
  specificity  <- as.numeric(cm$byClass[2])  
  
  
  #####
  #####
  #####
  
  credit.sex <-  rbind(credit.sex , c(i , profit, accuracy, sensitivity, specificity, percent_males, percent_females  ))
  
  i = i + increment
  
  #print (i)
  
  
  
  
  
  
  
  
  #confusion matrix
  #cf <- confusionMatrix(forest_classification,testing$default_0, positive="1") #Display confusion matrix. Note, confusion matrix actually displays a better accuracy with threshold of 50%
  #Accuracy : 0.8181 
  
  #cf    # Shangeris code  - not necessary here
  #profit
  #(cf$table[1,1] * 1500) - (cf$table[1,2] * 5000)
  
  #ROC Curve
  #forest_ROC_prediction <- prediction(forest_probabilities[,2], testing$default_0) #Calculate errors
  #forest_ROC <- performance(forest_ROC_prediction,"tpr","fpr") #Create ROC curve data
  #plot(forest_ROC) #Plot ROC curve
  
  #AUC (area under curve)
  #AUC.tmp <- performance(forest_ROC_prediction,"auc") #Create AUC data
  #forest_AUC <- as.numeric(AUC.tmp@y.values) #Calculate AUC
  #forest_AUC #Display AUC value
  #observations: AUC = 0.7132387 (decrease from logit model)
  
  # Lift chart
  #plotLift(forest_probabilities[,2],  testing$default_0, cumulative = TRUE, n.buckets = 10) # Plot Lift chart
  
 
  
  
  
  
}

credit.sex <- credit.sex[-1,] # to delete the first row

write.csv(credit.sex, file = "toplotintableau.csv")
view(credit.sex)
