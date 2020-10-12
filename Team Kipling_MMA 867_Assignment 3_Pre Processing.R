#Purpose: Build classification model to predict which new applicants for bank pilot should be offered credit

#import dataset (can save and use the CSV that's been saved on teams - "MMA867 A3 -- credit data.csv")
credit <- read.csv("Assignment\\Team\\Assignment 3\\MMA867 A3 -- credit data.csv", header=TRUE, sep = ",")
actual <- read.csv("Assignment\\Team\\Assignment 3\\MMA867 A3 -- new applications.csv", header=TRUE, sep = ",")

credit = credit[,!(names(credit) %in% c("ID"))]
actual = actual[,!(names(actual) %in% c("ID"))]
actual = actual[,!(names(actual) %in% c("CONCAT"))]
#explore data
summary(credit)
  #observation: notice no NA's (missing data)
str(credit)

#change necessary data types
  #we want to change these variables from integers to factor variables
credit$SEX <- as.factor(credit$SEX)
credit$EDUCATION <- as.factor(credit$EDUCATION)
credit$MARRIAGE <- as.factor(credit$MARRIAGE)
credit$PAY_1T <- as.factor(credit$PAY_1)
credit$PAY_2T <- as.factor(credit$PAY_2)
credit$PAY_3T <- as.factor(credit$PAY_3)
credit$PAY_4T <- as.factor(credit$PAY_4)
credit$PAY_5T <- as.factor(credit$PAY_5)
credit$PAY_6T <- as.factor(credit$PAY_6)
#keep status as num so we can do feature engineering later
credit$PAY_1 <- as.numeric(credit$PAY_1)
credit$PAY_2 <- as.numeric(credit$PAY_2)
credit$PAY_3 <- as.numeric(credit$PAY_3)
credit$PAY_4 <- as.numeric(credit$PAY_4)
credit$PAY_5 <- as.numeric(credit$PAY_5)
credit$PAY_6 <- as.numeric(credit$PAY_6)

credit$default_0 <- as.factor(credit$default_0)

str(credit)

#---NOTE: There are a handful of '0' values for Marriage (42 records) and Education (11 records).
#         '0' is unaccounted for in the data dictionary for these variables.
#         After conferring with TA, We will leave them as is (to not potentially contaminate the other buckets).

#for dem actuals
#explore data
summary(actual)
#observation: notice no NA's (missing data)
str(actual)

#change necessary data types
#we want to change these variables from integers to factor variables
actual$SEX <- as.factor(actual$SEX)
actual$EDUCATION <- as.factor(actual$EDUCATION)
actual$MARRIAGE <- as.factor(actual$MARRIAGE)
actual$PAY_1T <- as.factor(actual$PAY_1)
actual$PAY_2T <- as.factor(actual$PAY_2)
actual$PAY_3T <- as.factor(actual$PAY_3)
actual$PAY_4T <- as.factor(actual$PAY_4)
actual$PAY_5T <- as.factor(actual$PAY_5)
actual$PAY_6T <- as.factor(actual$PAY_6)
#keep status as num so we can do feature engineering later
actual$PAY_1 <- as.numeric(actual$PAY_1)
actual$PAY_2 <- as.numeric(actual$PAY_2)
actual$PAY_3 <- as.numeric(actual$PAY_3)
actual$PAY_4 <- as.numeric(actual$PAY_4)
actual$PAY_5 <- as.numeric(actual$PAY_5)
actual$PAY_6 <- as.numeric(actual$PAY_6)

actual$PAY_AMT1 <- as.numeric(actual$PAY_AMT1)
actual$PAY_AMT2 <- as.numeric(actual$PAY_AMT2)
actual$PAY_AMT3 <- as.numeric(actual$PAY_AMT3)
actual$PAY_AMT4 <- as.numeric(actual$PAY_AMT4)
actual$PAY_AMT5 <- as.numeric(actual$PAY_AMT5)
actual$PAY_AMT6 <- as.numeric(actual$PAY_AMT6)

actual$BILL_AMT1 <- as.numeric(actual$BILL_AMT1)
actual$BILL_AMT2 <- as.numeric(actual$BILL_AMT2)
actual$BILL_AMT3 <- as.numeric(actual$BILL_AMT3)
actual$BILL_AMT4 <- as.numeric(actual$BILL_AMT4)
actual$BILL_AMT5 <- as.numeric(actual$BILL_AMT5)
actual$BILL_AMT6 <- as.numeric(actual$BILL_AMT6)

#actual$default_0 <- as.factor(actual$default_0)

str(actual)

str(credit) # See if some data types were misclassified when importing data from CSV
lapply(credit,class)

solutions <- actual
#for w/ Features 1-9,12-19,23-28 had to remove $AGE_BUCKET and $CREDIT_LIMIT_BUCKET temporarily because 
#they are characters
#credit = credit[,!(names(credit) %in% c("AGE_BUCKET", "CREDIT_LIMIT_BUCKET"))]
