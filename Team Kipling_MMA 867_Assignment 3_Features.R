## CREDIT DATA

#1 Pay_Amt/Age
credit$PAY_AMT1_DIV_AGE <- credit$PAY_AMT1/credit$AGE
credit$PAY_AMT2_DIV_AGE <- credit$PAY_AMT2/credit$AGE
credit$PAY_AMT3_DIV_AGE <- credit$PAY_AMT3/credit$AGE
credit$PAY_AMT4_DIV_AGE <- credit$PAY_AMT4/credit$AGE
credit$PAY_AMT5_DIV_AGE <- credit$PAY_AMT5/credit$AGE
credit$PAY_AMT6_DIV_AGE <- credit$PAY_AMT6/credit$AGE

#2 Pay_Amt/Education
#convert Education to numeric type, engineer new variable, convert Education back to factor
credit$EDUCATION <- as.numeric(credit$EDUCATION)

credit$PAY_AMT1_DIV_EDU <- credit$PAY_AMT1/credit$EDUCATION
credit$PAY_AMT2_DIV_EDU <- credit$PAY_AMT2/credit$EDUCATION
credit$PAY_AMT3_DIV_EDU <- credit$PAY_AMT3/credit$EDUCATION
credit$PAY_AMT4_DIV_EDU <- credit$PAY_AMT4/credit$EDUCATION
credit$PAY_AMT5_DIV_EDU <- credit$PAY_AMT5/credit$EDUCATION
credit$PAY_AMT6_DIV_EDU <- credit$PAY_AMT6/credit$EDUCATION

credit$EDUCATION <- credit$EDUCATION-1 #for whatever reason, converting to numeric above added +1
credit$EDUCATION <- as.factor(credit$EDUCATION)

#3 Bill_Amt/Age
#Creating 6 variables - 1 for each Bill_Amt
credit$BILL_AMT1_DIV_AGE <- credit$BILL_AMT1/credit$AGE
credit$BILL_AMT2_DIV_AGE <- credit$BILL_AMT2/credit$AGE
credit$BILL_AMT3_DIV_AGE <- credit$BILL_AMT3/credit$AGE
credit$BILL_AMT4_DIV_AGE <- credit$BILL_AMT4/credit$AGE
credit$BILL_AMT5_DIV_AGE <- credit$BILL_AMT5/credit$AGE
credit$BILL_AMT6_DIV_AGE <- credit$BILL_AMT6/credit$AGE

#4 Bill_Amt/Education
#Creating 6 variables - 1 for each Bill_Amt
#convert Education to numeric type, engineer new variable, convert Education back to factor
credit$EDUCATION <- as.numeric(credit$EDUCATION)

credit$BILL_AMT1_DIV_EDU <- credit$BILL_AMT1/credit$EDUCATION
credit$BILL_AMT2_DIV_EDU <- credit$BILL_AMT2/credit$EDUCATION
credit$BILL_AMT3_DIV_EDU <- credit$BILL_AMT3/credit$EDUCATION
credit$BILL_AMT4_DIV_EDU <- credit$BILL_AMT4/credit$EDUCATION
credit$BILL_AMT5_DIV_EDU <- credit$BILL_AMT5/credit$EDUCATION
credit$BILL_AMT6_DIV_EDU <- credit$BILL_AMT6/credit$EDUCATION

credit$EDUCATION <- credit$EDUCATION-1 #for whatever reason, converting to numeric above added +1
credit$EDUCATION <- as.factor(credit$EDUCATION)

#5 Bill_Amt - Pay_Amt
#Creating 5 variables - 1 for each pair of Bill-Pay period (Pay_Amt1 is payment for Bill_Amt2)
credit$PAY_DIFFERENCE_AMT1 <- credit$BILL_AMT2-credit$PAY_AMT1
credit$PAY_DIFFERENCE_AMT2 <- credit$BILL_AMT3-credit$PAY_AMT2
credit$PAY_DIFFERENCE_AMT3 <- credit$BILL_AMT4-credit$PAY_AMT3
credit$PAY_DIFFERENCE_AMT4 <- credit$BILL_AMT5-credit$PAY_AMT4
credit$PAY_DIFFERENCE_AMT5 <- credit$BILL_AMT6-credit$PAY_AMT5

#6 (Bill_Amt-Pay_Amt)/Age
#Creating 5 variables - 1 for each Bill-Pay pair
credit$PAY_DIFFERENCE_AMT1_DIV_AGE <- credit$PAY_DIFFERENCE_AMT1/credit$AGE
credit$PAY_DIFFERENCE_AMT2_DIV_AGE <- credit$PAY_DIFFERENCE_AMT2/credit$AGE
credit$PAY_DIFFERENCE_AMT3_DIV_AGE <- credit$PAY_DIFFERENCE_AMT3/credit$AGE
credit$PAY_DIFFERENCE_AMT4_DIV_AGE <- credit$PAY_DIFFERENCE_AMT4/credit$AGE
credit$PAY_DIFFERENCE_AMT5_DIV_AGE <- credit$PAY_DIFFERENCE_AMT5/credit$AGE

#7 Bill_Amt-Pay amt/Education
#Creating 5 variables - 1 for each Bill-pay pair
#convert Education to numeric type, engineer new variable, convert Education back to factor
credit$EDUCATION <- as.numeric(credit$EDUCATION)

credit$PAY_DIFFERENCE_AMT1_DIV_EDU <- credit$PAY_DIFFERENCE_AMT1/credit$EDUCATION
credit$PAY_DIFFERENCE_AMT2_DIV_EDU <- credit$PAY_DIFFERENCE_AMT2/credit$EDUCATION
credit$PAY_DIFFERENCE_AMT3_DIV_EDU <- credit$PAY_DIFFERENCE_AMT3/credit$EDUCATION
credit$PAY_DIFFERENCE_AMT4_DIV_EDU <- credit$PAY_DIFFERENCE_AMT4/credit$EDUCATION
credit$PAY_DIFFERENCE_AMT5_DIV_EDU <- credit$PAY_DIFFERENCE_AMT5/credit$EDUCATION

credit$EDUCATION <- credit$EDUCATION-1 #for whatever reason, converting to numeric above added +1
credit$EDUCATION <- as.factor(credit$EDUCATION)

#8 Credit limit/Age
#Creating 1 variable
credit$CREDIT_LIMIT_DIV_AGE <- credit$LIMIT_BAL/credit$AGE

#9 Credit Limit/Education
#Creating 1 variable
#convert Education to numeric type, engineer new variable, convert Education back to factor
credit$EDUCATION <- as.numeric(credit$EDUCATION)

credit$CREDIT_LIMIT_DIV_EDU <- credit$LIMIT_BAL/credit$EDUCATION

credit$EDUCATION <- credit$EDUCATION-1 #for whatever reason, converting to numeric above added +1
credit$EDUCATION <- as.factor(credit$EDUCATION)

#12 Total Payments Satisfied
#can check for only 5 bill-pay pairs so this number will range from 0 to 5
credit$TOTAL_PAYMENTS_SATISFIED <- 0

credit$TOTAL_PAYMENTS_SATISFIED <- if_else(credit$PAY_AMT1>=credit$BILL_AMT2,1+credit$TOTAL_PAYMENTS_SATISFIED, credit$TOTAL_PAYMENTS_SATISFIED)
credit$TOTAL_PAYMENTS_SATISFIED <- if_else(credit$PAY_AMT2>=credit$BILL_AMT3,1+credit$TOTAL_PAYMENTS_SATISFIED, credit$TOTAL_PAYMENTS_SATISFIED)
credit$TOTAL_PAYMENTS_SATISFIED <- if_else(credit$PAY_AMT3>=credit$BILL_AMT4,1+credit$TOTAL_PAYMENTS_SATISFIED, credit$TOTAL_PAYMENTS_SATISFIED)
credit$TOTAL_PAYMENTS_SATISFIED <- if_else(credit$PAY_AMT4>=credit$BILL_AMT5,1+credit$TOTAL_PAYMENTS_SATISFIED, credit$TOTAL_PAYMENTS_SATISFIED)
credit$TOTAL_PAYMENTS_SATISFIED <- if_else(credit$PAY_AMT5>=credit$BILL_AMT6,1+credit$TOTAL_PAYMENTS_SATISFIED, credit$TOTAL_PAYMENTS_SATISFIED)

#13 Total Payments Missed - need to run code for FE #12 to run this
#exact inverse of Total Payments Satisfied
credit$TOTAL_PAYMENTS_MISSED <- 5 - credit$TOTAL_PAYMENTS_SATISFIED
#collinearity?

#16 Zero Bill
#Creating 6 variables, change to factors
credit$ZERO_BILL1 <- if_else(credit$BILL_AMT1==0,1,0)
credit$ZERO_BILL2 <- if_else(credit$BILL_AMT2==0,1,0)
credit$ZERO_BILL3 <- if_else(credit$BILL_AMT3==0,1,0)
credit$ZERO_BILL4 <- if_else(credit$BILL_AMT4==0,1,0)
credit$ZERO_BILL5 <- if_else(credit$BILL_AMT5==0,1,0)
credit$ZERO_BILL6 <- if_else(credit$BILL_AMT6==0,1,0)

#17 Zero Pay
#Creating 6 variables, change to factors
credit$ZERO_PAY1 <- if_else(credit$PAY_AMT1==0,1,0)
credit$ZERO_PAY2 <- if_else(credit$PAY_AMT2==0,1,0)
credit$ZERO_PAY3 <- if_else(credit$PAY_AMT3==0,1,0)
credit$ZERO_PAY4 <- if_else(credit$PAY_AMT4==0,1,0)
credit$ZERO_PAY5 <- if_else(credit$PAY_AMT5==0,1,0)
credit$ZERO_PAY6 <- if_else(credit$PAY_AMT6==0,1,0)

#14 Total Zero Bill Months - need FE #16 to run this
credit$TOTAL_ZERO_BILL_MONTHS <- credit$ZERO_BILL1+credit$ZERO_BILL2+credit$ZERO_BILL3+credit$ZERO_BILL4+credit$ZERO_BILL5+credit$ZERO_BILL6

credit$ZERO_BILL1 <- as.factor(credit$ZERO_BILL1)
credit$ZERO_BILL2 <- as.factor(credit$ZERO_BILL2)
credit$ZERO_BILL3 <- as.factor(credit$ZERO_BILL3)
credit$ZERO_BILL4 <- as.factor(credit$ZERO_BILL4)
credit$ZERO_BILL5 <- as.factor(credit$ZERO_BILL5)
credit$ZERO_BILL6 <- as.factor(credit$ZERO_BILL6)

#15 Total Zero Pay Months - need FE #17 to run this
#change FE #17 back to numeric, then return to factor
credit$TOTAL_ZERO_PAY_MONTHS <- credit$ZERO_PAY1+credit$ZERO_PAY2+credit$ZERO_PAY3+credit$ZERO_PAY4+credit$ZERO_PAY5+credit$ZERO_PAY6

credit$ZERO_PAY1 <- as.factor(credit$ZERO_PAY1)
credit$ZERO_PAY2 <- as.factor(credit$ZERO_PAY2)
credit$ZERO_PAY3 <- as.factor(credit$ZERO_PAY3)
credit$ZERO_PAY4 <- as.factor(credit$ZERO_PAY4)
credit$ZERO_PAY5 <- as.factor(credit$ZERO_PAY5)
credit$ZERO_PAY6 <- as.factor(credit$ZERO_PAY6)

#18 Bill Range
i <- 1
credit$BILL_RANGE <- 0

for (i in 1:nrow(credit)){
  credit$BILL_RANGE[i] <- max(credit$BILL_AMT1[i], credit$BILL_AMT2[i], credit$BILL_AMT3[i], credit$BILL_AMT4[i], credit$BILL_AMT5[i], credit$BILL_AMT6[i]) - min(credit$BILL_AMT1[i], credit$BILL_AMT2[i], credit$BILL_AMT3[i], credit$BILL_AMT4[i], credit$BILL_AMT5[i], credit$BILL_AMT6[i])
}

#19 Pay Range
i <- 1
credit$PAY_RANGE <- 0

for (i in 1:nrow(credit)){
  credit$PAY_RANGE[i] <- max(credit$PAY_AMT1[i], credit$PAY_AMT2[i], credit$PAY_AMT3[i], credit$PAY_AMT4[i], credit$PAY_AMT5[i], credit$PAY_AMT6[i]) - min(credit$PAY_AMT1[i], credit$PAY_AMT2[i], credit$PAY_AMT3[i], credit$PAY_AMT4[i], credit$PAY_AMT5[i], credit$PAY_AMT6[i])
}

#23 Cumulative % of Bill Paid
credit$CUMU_PERCENT_BILL_PAID1 <- if_else(credit$BILL_AMT1 == 0,1,credit$PAY_AMT1/credit$BILL_AMT1)
credit$CUMU_PERCENT_BILL_PAID2 <- if_else(credit$BILL_AMT2 == 0,1,credit$PAY_AMT2/credit$BILL_AMT2)
credit$CUMU_PERCENT_BILL_PAID3 <- if_else(credit$BILL_AMT3 == 0,1,credit$PAY_AMT3/credit$BILL_AMT3)
credit$CUMU_PERCENT_BILL_PAID4 <- if_else(credit$BILL_AMT4 == 0,1,credit$PAY_AMT4/credit$BILL_AMT4)
credit$CUMU_PERCENT_BILL_PAID5 <- if_else(credit$BILL_AMT5 == 0,1,credit$PAY_AMT5/credit$BILL_AMT5)
credit$CUMU_PERCENT_BILL_PAID6 <- if_else(credit$BILL_AMT6 == 0,1,credit$PAY_AMT6/credit$BILL_AMT6)

#24 Dummy: Bill Amount is 1 SD away
#creating 6 variables, 1 for each Bill Amt month, convert to factors
credit$BILL_AMT1_1_SD_AWAY <- 0
credit$BILL_AMT2_1_SD_AWAY <- 0
credit$BILL_AMT3_1_SD_AWAY <- 0
credit$BILL_AMT4_1_SD_AWAY <- 0
credit$BILL_AMT5_1_SD_AWAY <- 0
credit$BILL_AMT6_1_SD_AWAY <- 0

credit$BILL_AMT1_1_SD_AWAY <- if_else(credit$BILL_AMT1 >= mean(credit$BILL_AMT1)+sqrt(var(credit$BILL_AMT1)), 1, credit$BILL_AMT1_1_SD_AWAY)
credit$BILL_AMT1_1_SD_AWAY <- if_else(credit$BILL_AMT1 <= mean(credit$BILL_AMT1)-sqrt(var(credit$BILL_AMT1)), 1, credit$BILL_AMT1_1_SD_AWAY)

credit$BILL_AMT2_1_SD_AWAY <- if_else(credit$BILL_AMT2 >= mean(credit$BILL_AMT2)+sqrt(var(credit$BILL_AMT2)), 1, credit$BILL_AMT2_1_SD_AWAY)
credit$BILL_AMT2_1_SD_AWAY <- if_else(credit$BILL_AMT2 <= mean(credit$BILL_AMT2)-sqrt(var(credit$BILL_AMT2)), 1, credit$BILL_AMT2_1_SD_AWAY)

credit$BILL_AMT3_1_SD_AWAY <- if_else(credit$BILL_AMT3 >= mean(credit$BILL_AMT3)+sqrt(var(credit$BILL_AMT3)), 1, credit$BILL_AMT3_1_SD_AWAY)
credit$BILL_AMT3_1_SD_AWAY <- if_else(credit$BILL_AMT3 <= mean(credit$BILL_AMT3)-sqrt(var(credit$BILL_AMT3)), 1, credit$BILL_AMT3_1_SD_AWAY)

credit$BILL_AMT4_1_SD_AWAY <- if_else(credit$BILL_AMT4 >= mean(credit$BILL_AMT4)+sqrt(var(credit$BILL_AMT4)), 1, credit$BILL_AMT4_1_SD_AWAY)
credit$BILL_AMT4_1_SD_AWAY <- if_else(credit$BILL_AMT4 <= mean(credit$BILL_AMT4)-sqrt(var(credit$BILL_AMT4)), 1, credit$BILL_AMT4_1_SD_AWAY)

credit$BILL_AMT5_1_SD_AWAY <- if_else(credit$BILL_AMT5 >= mean(credit$BILL_AMT5)+sqrt(var(credit$BILL_AMT5)), 1, credit$BILL_AMT5_1_SD_AWAY)
credit$BILL_AMT5_1_SD_AWAY <- if_else(credit$BILL_AMT5 <= mean(credit$BILL_AMT5)-sqrt(var(credit$BILL_AMT5)), 1, credit$BILL_AMT5_1_SD_AWAY)

credit$BILL_AMT6_1_SD_AWAY <- if_else(credit$BILL_AMT6 >= mean(credit$BILL_AMT6)+sqrt(var(credit$BILL_AMT6)), 1, credit$BILL_AMT6_1_SD_AWAY)
credit$BILL_AMT6_1_SD_AWAY <- if_else(credit$BILL_AMT6 <= mean(credit$BILL_AMT6)-sqrt(var(credit$BILL_AMT6)), 1, credit$BILL_AMT6_1_SD_AWAY)

credit$BILL_AMT1_1_SD_AWAY <- as.factor(credit$BILL_AMT1_1_SD_AWAY)
credit$BILL_AMT2_1_SD_AWAY <- as.factor(credit$BILL_AMT2_1_SD_AWAY)
credit$BILL_AMT3_1_SD_AWAY <- as.factor(credit$BILL_AMT3_1_SD_AWAY)
credit$BILL_AMT4_1_SD_AWAY <- as.factor(credit$BILL_AMT4_1_SD_AWAY)
credit$BILL_AMT5_1_SD_AWAY <- as.factor(credit$BILL_AMT5_1_SD_AWAY)
credit$BILL_AMT6_1_SD_AWAY <- as.factor(credit$BILL_AMT6_1_SD_AWAY)

#25 Dummy: Paid Amount is 1 SD away
#creating 6 variables, 1 for each Pay Amt month, convert to factors
credit$PAY_AMT1_1_SD_AWAY <- 0
credit$PAY_AMT2_1_SD_AWAY <- 0
credit$PAY_AMT3_1_SD_AWAY <- 0
credit$PAY_AMT4_1_SD_AWAY <- 0
credit$PAY_AMT5_1_SD_AWAY <- 0
credit$PAY_AMT6_1_SD_AWAY <- 0

credit$PAY_AMT1_1_SD_AWAY <- if_else(credit$PAY_AMT1 >= mean(credit$PAY_AMT1)+sqrt(var(credit$PAY_AMT1)), 1, credit$PAY_AMT1_1_SD_AWAY)
credit$PAY_AMT1_1_SD_AWAY <- if_else(credit$PAY_AMT1 <= mean(credit$PAY_AMT1)-sqrt(var(credit$PAY_AMT1)), 1, credit$PAY_AMT1_1_SD_AWAY)

credit$PAY_AMT2_1_SD_AWAY <- if_else(credit$PAY_AMT2 >= mean(credit$PAY_AMT2)+sqrt(var(credit$PAY_AMT2)), 1, credit$PAY_AMT2_1_SD_AWAY)
credit$PAY_AMT2_1_SD_AWAY <- if_else(credit$PAY_AMT2 <= mean(credit$PAY_AMT2)-sqrt(var(credit$PAY_AMT2)), 1, credit$PAY_AMT2_1_SD_AWAY)

credit$PAY_AMT3_1_SD_AWAY <- if_else(credit$PAY_AMT3 >= mean(credit$PAY_AMT3)+sqrt(var(credit$PAY_AMT3)), 1, credit$PAY_AMT3_1_SD_AWAY)
credit$PAY_AMT3_1_SD_AWAY <- if_else(credit$PAY_AMT3 <= mean(credit$PAY_AMT3)-sqrt(var(credit$PAY_AMT3)), 1, credit$PAY_AMT3_1_SD_AWAY)

credit$PAY_AMT4_1_SD_AWAY <- if_else(credit$PAY_AMT4 >= mean(credit$PAY_AMT4)+sqrt(var(credit$PAY_AMT4)), 1, credit$PAY_AMT4_1_SD_AWAY)
credit$PAY_AMT4_1_SD_AWAY <- if_else(credit$PAY_AMT4 <= mean(credit$PAY_AMT4)-sqrt(var(credit$PAY_AMT4)), 1, credit$PAY_AMT4_1_SD_AWAY)

credit$PAY_AMT5_1_SD_AWAY <- if_else(credit$PAY_AMT5 >= mean(credit$PAY_AMT5)+sqrt(var(credit$PAY_AMT5)), 1, credit$PAY_AMT5_1_SD_AWAY)
credit$PAY_AMT5_1_SD_AWAY <- if_else(credit$PAY_AMT5 <= mean(credit$PAY_AMT5)-sqrt(var(credit$PAY_AMT5)), 1, credit$PAY_AMT5_1_SD_AWAY)

credit$PAY_AMT6_1_SD_AWAY <- if_else(credit$PAY_AMT6 >= mean(credit$PAY_AMT6)+sqrt(var(credit$PAY_AMT6)), 1, credit$PAY_AMT6_1_SD_AWAY)
credit$PAY_AMT6_1_SD_AWAY <- if_else(credit$PAY_AMT6 <= mean(credit$PAY_AMT6)-sqrt(var(credit$PAY_AMT6)), 1, credit$PAY_AMT6_1_SD_AWAY)

credit$PAY_AMT1_1_SD_AWAY <- as.factor(credit$PAY_AMT1_1_SD_AWAY)
credit$PAY_AMT2_1_SD_AWAY <- as.factor(credit$PAY_AMT2_1_SD_AWAY)
credit$PAY_AMT3_1_SD_AWAY <- as.factor(credit$PAY_AMT3_1_SD_AWAY)
credit$PAY_AMT4_1_SD_AWAY <- as.factor(credit$PAY_AMT4_1_SD_AWAY)
credit$PAY_AMT5_1_SD_AWAY <- as.factor(credit$PAY_AMT5_1_SD_AWAY)
credit$PAY_AMT6_1_SD_AWAY <- as.factor(credit$PAY_AMT6_1_SD_AWAY)

#26 Dummy: Bill amt - Paid amt 1 SD away - you need FE variable #5 to use code for this variable
#creating 5 variables, 1 for each Bill-Pay pair, convert to factors
credit$PAY_DIFFERENCE_AMT1_1_SD_AWAY <- 0
credit$PAY_DIFFERENCE_AMT2_1_SD_AWAY <- 0
credit$PAY_DIFFERENCE_AMT3_1_SD_AWAY <- 0
credit$PAY_DIFFERENCE_AMT4_1_SD_AWAY <- 0
credit$PAY_DIFFERENCE_AMT5_1_SD_AWAY <- 0

credit$PAY_DIFFERENCE_AMT1_1_SD_AWAY <- if_else(credit$PAY_DIFFERENCE_AMT1 >= mean(credit$PAY_DIFFERENCE_AMT1)+sqrt(var(credit$PAY_DIFFERENCE_AMT1)), 1, credit$PAY_DIFFERENCE_AMT1_1_SD_AWAY)
credit$PAY_DIFFERENCE_AMT1_1_SD_AWAY <- if_else(credit$PAY_DIFFERENCE_AMT1 <= mean(credit$PAY_DIFFERENCE_AMT1)-sqrt(var(credit$PAY_DIFFERENCE_AMT1)), 1, credit$PAY_DIFFERENCE_AMT1_1_SD_AWAY)

credit$PAY_DIFFERENCE_AMT2_1_SD_AWAY <- if_else(credit$PAY_DIFFERENCE_AMT2 >= mean(credit$PAY_DIFFERENCE_AMT2)+sqrt(var(credit$PAY_DIFFERENCE_AMT2)), 1, credit$PAY_DIFFERENCE_AMT2_1_SD_AWAY)
credit$PAY_DIFFERENCE_AMT2_1_SD_AWAY <- if_else(credit$PAY_DIFFERENCE_AMT2 <= mean(credit$PAY_DIFFERENCE_AMT2)-sqrt(var(credit$PAY_DIFFERENCE_AMT2)), 1, credit$PAY_DIFFERENCE_AMT2_1_SD_AWAY)

credit$PAY_DIFFERENCE_AMT3_1_SD_AWAY <- if_else(credit$PAY_DIFFERENCE_AMT3 >= mean(credit$PAY_DIFFERENCE_AMT3)+sqrt(var(credit$PAY_DIFFERENCE_AMT3)), 1, credit$PAY_DIFFERENCE_AMT3_1_SD_AWAY)
credit$PAY_DIFFERENCE_AMT3_1_SD_AWAY <- if_else(credit$PAY_DIFFERENCE_AMT3 <= mean(credit$PAY_DIFFERENCE_AMT3)-sqrt(var(credit$PAY_DIFFERENCE_AMT3)), 1, credit$PAY_DIFFERENCE_AMT3_1_SD_AWAY)

credit$PAY_DIFFERENCE_AMT4_1_SD_AWAY <- if_else(credit$PAY_DIFFERENCE_AMT4 >= mean(credit$PAY_DIFFERENCE_AMT4)+sqrt(var(credit$PAY_DIFFERENCE_AMT4)), 1, credit$PAY_DIFFERENCE_AMT4_1_SD_AWAY)
credit$PAY_DIFFERENCE_AMT4_1_SD_AWAY <- if_else(credit$PAY_DIFFERENCE_AMT4 <= mean(credit$PAY_DIFFERENCE_AMT4)-sqrt(var(credit$PAY_DIFFERENCE_AMT4)), 1, credit$PAY_DIFFERENCE_AMT4_1_SD_AWAY)

credit$PAY_DIFFERENCE_AMT5_1_SD_AWAY <- if_else(credit$PAY_DIFFERENCE_AMT5 >= mean(credit$PAY_DIFFERENCE_AMT5)+sqrt(var(credit$PAY_DIFFERENCE_AMT5)), 1, credit$PAY_DIFFERENCE_AMT5_1_SD_AWAY)
credit$PAY_DIFFERENCE_AMT5_1_SD_AWAY <- if_else(credit$PAY_DIFFERENCE_AMT5 <= mean(credit$PAY_DIFFERENCE_AMT5)-sqrt(var(credit$PAY_DIFFERENCE_AMT5)), 1, credit$PAY_DIFFERENCE_AMT5_1_SD_AWAY)

credit$PAY_DIFFERENCE_AMT1_1_SD_AWAY <- as.factor(credit$PAY_DIFFERENCE_AMT1_1_SD_AWAY)
credit$PAY_DIFFERENCE_AMT2_1_SD_AWAY <- as.factor(credit$PAY_DIFFERENCE_AMT2_1_SD_AWAY)
credit$PAY_DIFFERENCE_AMT3_1_SD_AWAY <- as.factor(credit$PAY_DIFFERENCE_AMT3_1_SD_AWAY)
credit$PAY_DIFFERENCE_AMT4_1_SD_AWAY <- as.factor(credit$PAY_DIFFERENCE_AMT4_1_SD_AWAY)
credit$PAY_DIFFERENCE_AMT5_1_SD_AWAY <- as.factor(credit$PAY_DIFFERENCE_AMT5_1_SD_AWAY)

#27 Age Buckets
#convert to factor
credit$AGE_BUCKET <- "a"

credit$AGE_BUCKET <- if_else(credit$AGE < 18,"< 18 yrs",credit$AGE_BUCKET)
credit$AGE_BUCKET <- if_else(credit$AGE >= 18 & credit$AGE < 25,"18-24 yrs",credit$AGE_BUCKET)
credit$AGE_BUCKET <- if_else(credit$AGE >= 25 & credit$AGE < 35,"25-34 yrs",credit$AGE_BUCKET)
credit$AGE_BUCKET <- if_else(credit$AGE >= 35 & credit$AGE < 45,"35-44 yrs",credit$AGE_BUCKET)
credit$AGE_BUCKET <- if_else(credit$AGE >= 45 & credit$AGE < 55,"45-54 yrs",credit$AGE_BUCKET)
credit$AGE_BUCKET <- if_else(credit$AGE >= 55,"> 55 yrs",credit$AGE_BUCKET)

credit$AGE_BUCKET <- as.factor((credit$AGE_BUCKET))

#28 Limit_Bal Buckets i.e. Credit Limit Buckets
#convert to factor
credit$CREDIT_LIMIT_BUCKET <- "a"

credit$CREDIT_LIMIT_BUCKET <- if_else(credit$LIMIT_BAL < 25000,"< 25K",credit$CREDIT_LIMIT_BUCKET)
credit$CREDIT_LIMIT_BUCKET <- if_else(credit$LIMIT_BAL >= 25000 & credit$LIMIT_BAL < 50000,"25-50K",credit$CREDIT_LIMIT_BUCKET)
credit$CREDIT_LIMIT_BUCKET <- if_else(credit$LIMIT_BAL >= 50000 & credit$LIMIT_BAL < 75000,"50-75K",credit$CREDIT_LIMIT_BUCKET)
credit$CREDIT_LIMIT_BUCKET <- if_else(credit$LIMIT_BAL >= 75000 & credit$LIMIT_BAL < 100000,"75-100K",credit$CREDIT_LIMIT_BUCKET)
credit$CREDIT_LIMIT_BUCKET <- if_else(credit$LIMIT_BAL >= 100000 & credit$LIMIT_BAL < 125000,"100-125K",credit$CREDIT_LIMIT_BUCKET)
credit$CREDIT_LIMIT_BUCKET <- if_else(credit$LIMIT_BAL >= 125000 & credit$LIMIT_BAL < 150000,"125-150K",credit$CREDIT_LIMIT_BUCKET)
credit$CREDIT_LIMIT_BUCKET <- if_else(credit$LIMIT_BAL >= 150000 & credit$LIMIT_BAL < 175000,"150-175K",credit$CREDIT_LIMIT_BUCKET)
credit$CREDIT_LIMIT_BUCKET <- if_else(credit$LIMIT_BAL >= 175000 & credit$LIMIT_BAL < 200000,"175-200K",credit$CREDIT_LIMIT_BUCKET)
credit$CREDIT_LIMIT_BUCKET <- if_else(credit$LIMIT_BAL >= 200000 & credit$LIMIT_BAL < 225000,"200-225K",credit$CREDIT_LIMIT_BUCKET)
credit$CREDIT_LIMIT_BUCKET <- if_else(credit$LIMIT_BAL >= 225000 & credit$LIMIT_BAL < 250000,"225-250K",credit$CREDIT_LIMIT_BUCKET)
credit$CREDIT_LIMIT_BUCKET <- if_else(credit$LIMIT_BAL >= 250000 & credit$LIMIT_BAL < 300000,"250-300K",credit$CREDIT_LIMIT_BUCKET)
credit$CREDIT_LIMIT_BUCKET <- if_else(credit$LIMIT_BAL >= 300000 & credit$LIMIT_BAL < 400000,"300-400K",credit$CREDIT_LIMIT_BUCKET)
credit$CREDIT_LIMIT_BUCKET <- if_else(credit$LIMIT_BAL >= 400000 & credit$LIMIT_BAL < 500000,"400-500K",credit$CREDIT_LIMIT_BUCKET)
credit$CREDIT_LIMIT_BUCKET <- if_else(credit$LIMIT_BAL >= 500000 & credit$LIMIT_BAL < 700000,"500-700K",credit$CREDIT_LIMIT_BUCKET)
credit$CREDIT_LIMIT_BUCKET <- if_else(credit$LIMIT_BAL >= 700000 & credit$LIMIT_BAL < 900000,"700-900K",credit$CREDIT_LIMIT_BUCKET)
credit$CREDIT_LIMIT_BUCKET <- if_else(credit$LIMIT_BAL >= 900000 & credit$LIMIT_BAL < 1000000,"900K-1Mn",credit$CREDIT_LIMIT_BUCKET)
credit$CREDIT_LIMIT_BUCKET <- if_else(credit$LIMIT_BAL >= 1000000,"> 1Mn",credit$CREDIT_LIMIT_BUCKET)

credit$CREDIT_LIMIT_BUCKET <- as.factor(credit$CREDIT_LIMIT_BUCKET)

#29a Frequency of Late Payments - capturing count of payments that are 3 or more months late
credit$LATE_PAYMENT_FREQUENCY3 <- 0

credit$LATE_PAYMENT_FREQUENCY3 <- if_else(credit$PAY_1 >= 3,credit$LATE_PAYMENT_FREQUENCY3+1,credit$LATE_PAYMENT_FREQUENCY3)
credit$LATE_PAYMENT_FREQUENCY3 <- if_else(credit$PAY_2 >= 3,credit$LATE_PAYMENT_FREQUENCY3+1,credit$LATE_PAYMENT_FREQUENCY3)
credit$LATE_PAYMENT_FREQUENCY3 <- if_else(credit$PAY_3 >= 3,credit$LATE_PAYMENT_FREQUENCY3+1,credit$LATE_PAYMENT_FREQUENCY3)
credit$LATE_PAYMENT_FREQUENCY3 <- if_else(credit$PAY_4 >= 3,credit$LATE_PAYMENT_FREQUENCY3+1,credit$LATE_PAYMENT_FREQUENCY3)
credit$LATE_PAYMENT_FREQUENCY3 <- if_else(credit$PAY_5 >= 3,credit$LATE_PAYMENT_FREQUENCY3+1,credit$LATE_PAYMENT_FREQUENCY3)
credit$LATE_PAYMENT_FREQUENCY3 <- if_else(credit$PAY_6 >= 3,credit$LATE_PAYMENT_FREQUENCY3+1,credit$LATE_PAYMENT_FREQUENCY3)

#29b Frequency of Late Payments - capturing count of payments that are 5 or more months late
credit$LATE_PAYMENT_FREQUENCY5 <- 0

credit$LATE_PAYMENT_FREQUENCY5 <- if_else(credit$PAY_1 >= 5,credit$LATE_PAYMENT_FREQUENCY5+1,credit$LATE_PAYMENT_FREQUENCY5)
credit$LATE_PAYMENT_FREQUENCY5 <- if_else(credit$PAY_2 >= 5,credit$LATE_PAYMENT_FREQUENCY5+1,credit$LATE_PAYMENT_FREQUENCY5)
credit$LATE_PAYMENT_FREQUENCY5 <- if_else(credit$PAY_3 >= 5,credit$LATE_PAYMENT_FREQUENCY5+1,credit$LATE_PAYMENT_FREQUENCY5)
credit$LATE_PAYMENT_FREQUENCY5 <- if_else(credit$PAY_4 >= 5,credit$LATE_PAYMENT_FREQUENCY5+1,credit$LATE_PAYMENT_FREQUENCY5)
credit$LATE_PAYMENT_FREQUENCY5 <- if_else(credit$PAY_5 >= 5,credit$LATE_PAYMENT_FREQUENCY5+1,credit$LATE_PAYMENT_FREQUENCY5)
credit$LATE_PAYMENT_FREQUENCY5 <- if_else(credit$PAY_6 >= 5,credit$LATE_PAYMENT_FREQUENCY5+1,credit$LATE_PAYMENT_FREQUENCY5)

#29c Frequency of Late Payments - capturing count of payments that are 7 or more months late
credit$LATE_PAYMENT_FREQUENCY7 <- 0

credit$LATE_PAYMENT_FREQUENCY7 <- if_else(credit$PAY_1 >= 7,credit$LATE_PAYMENT_FREQUENCY7+1,credit$LATE_PAYMENT_FREQUENCY7)
credit$LATE_PAYMENT_FREQUENCY7 <- if_else(credit$PAY_2 >= 7,credit$LATE_PAYMENT_FREQUENCY7+1,credit$LATE_PAYMENT_FREQUENCY7)
credit$LATE_PAYMENT_FREQUENCY7 <- if_else(credit$PAY_3 >= 7,credit$LATE_PAYMENT_FREQUENCY7+1,credit$LATE_PAYMENT_FREQUENCY7)
credit$LATE_PAYMENT_FREQUENCY7 <- if_else(credit$PAY_4 >= 7,credit$LATE_PAYMENT_FREQUENCY7+1,credit$LATE_PAYMENT_FREQUENCY7)
credit$LATE_PAYMENT_FREQUENCY7 <- if_else(credit$PAY_5 >= 7,credit$LATE_PAYMENT_FREQUENCY7+1,credit$LATE_PAYMENT_FREQUENCY7)
credit$LATE_PAYMENT_FREQUENCY7 <- if_else(credit$PAY_6 >= 7,credit$LATE_PAYMENT_FREQUENCY7+1,credit$LATE_PAYMENT_FREQUENCY7)

#29d Frequency of Late Payments - capturing count of payments that are 1 or more months late
credit$LATE_PAYMENT_FREQUENCY1 <- 0

credit$LATE_PAYMENT_FREQUENCY1 <- if_else(credit$PAY_1 >= 1,credit$LATE_PAYMENT_FREQUENCY1+1,credit$LATE_PAYMENT_FREQUENCY1)
credit$LATE_PAYMENT_FREQUENCY1 <- if_else(credit$PAY_2 >= 1,credit$LATE_PAYMENT_FREQUENCY1+1,credit$LATE_PAYMENT_FREQUENCY1)
credit$LATE_PAYMENT_FREQUENCY1 <- if_else(credit$PAY_3 >= 1,credit$LATE_PAYMENT_FREQUENCY1+1,credit$LATE_PAYMENT_FREQUENCY1)
credit$LATE_PAYMENT_FREQUENCY1 <- if_else(credit$PAY_4 >= 1,credit$LATE_PAYMENT_FREQUENCY1+1,credit$LATE_PAYMENT_FREQUENCY1)
credit$LATE_PAYMENT_FREQUENCY1 <- if_else(credit$PAY_5 >= 1,credit$LATE_PAYMENT_FREQUENCY1+1,credit$LATE_PAYMENT_FREQUENCY1)
credit$LATE_PAYMENT_FREQUENCY1 <- if_else(credit$PAY_6 >= 1,credit$LATE_PAYMENT_FREQUENCY1+1,credit$LATE_PAYMENT_FREQUENCY1)

#30 Average Months Delayed - run #29d (late payment frequency of 1 or more months) before running this code
#convert PAY_x variables to numeric, create FE variable, convert PAY_x back to numeric
credit$PAY_1 <- as.numeric(credit$PAY_1)
credit$PAY_2 <- as.numeric(credit$PAY_2)
credit$PAY_3 <- as.numeric(credit$PAY_3)
credit$PAY_4 <- as.numeric(credit$PAY_4)
credit$PAY_5 <- as.numeric(credit$PAY_5)
credit$PAY_6 <- as.numeric(credit$PAY_6)

i=1
credit$AVERAGE_MONTHS_DELAYED <- 0

for (i in 1:nrow(credit)) {
  credit$AVERAGE_MONTHS_DELAYED[i] <- if_else(credit$PAY_1[i] >= 1,credit$PAY_1[i],credit$AVERAGE_MONTHS_DELAYED[i])
  credit$AVERAGE_MONTHS_DELAYED[i] <- if_else(credit$PAY_2[i] >= 1,credit$PAY_2[i]+credit$AVERAGE_MONTHS_DELAYED[i],credit$AVERAGE_MONTHS_DELAYED[i])
  credit$AVERAGE_MONTHS_DELAYED[i] <- if_else(credit$PAY_3[i] >= 1,credit$PAY_3[i]+credit$AVERAGE_MONTHS_DELAYED[i],credit$AVERAGE_MONTHS_DELAYED[i])
  credit$AVERAGE_MONTHS_DELAYED[i] <- if_else(credit$PAY_4[i] >= 1,credit$PAY_4[i]+credit$AVERAGE_MONTHS_DELAYED[i],credit$AVERAGE_MONTHS_DELAYED[i])
  credit$AVERAGE_MONTHS_DELAYED[i] <- if_else(credit$PAY_5[i] >= 1,credit$PAY_5[i]+credit$AVERAGE_MONTHS_DELAYED[i],credit$AVERAGE_MONTHS_DELAYED[i])
  credit$AVERAGE_MONTHS_DELAYED[i] <- if_else(credit$PAY_6[i] >= 1,credit$PAY_6[i]+credit$AVERAGE_MONTHS_DELAYED[i],credit$AVERAGE_MONTHS_DELAYED[i])
  
  credit$AVERAGE_MONTHS_DELAYED[i] <- if_else(credit$LATE_PAYMENT_FREQUENCY1[i] > 0, credit$AVERAGE_MONTHS_DELAYED[i]/credit$LATE_PAYMENT_FREQUENCY1[i], 0)
}

#31 Dummy: Average months delayed 1 SD away - you need FE variable #30 to use code for this variable
#creating 5 variables, 1 for each Bill-Pay pair, convert to factor
credit$AVERAGE_MONTHS_DELAYED_1_SD_AWAY <- 0

credit$AVERAGE_MONTHS_DELAYED_1_SD_AWAY <- if_else(credit$AVERAGE_MONTHS_DELAYED >= mean(credit$AVERAGE_MONTHS_DELAYED)+sqrt(var(credit$AVERAGE_MONTHS_DELAYED)), 1, credit$AVERAGE_MONTHS_DELAYED_1_SD_AWAY)
credit$AVERAGE_MONTHS_DELAYED_1_SD_AWAY <- if_else(credit$AVERAGE_MONTHS_DELAYED <= mean(credit$AVERAGE_MONTHS_DELAYED)-sqrt(var(credit$AVERAGE_MONTHS_DELAYED)), 1, credit$AVERAGE_MONTHS_DELAYED_1_SD_AWAY)

credit$AVERAGE_MONTHS_DELAYED_1_SD_AWAY <- as.factor(credit$AVERAGE_MONTHS_DELAYED_1_SD_AWAY)

#32 Month on month percentage change in Bill Amount
#creating 5 new variables
#BILL_PERCENTAGE_CHANGE1 = (BILL_AMT1-BILL_AMT2)/BILL_AMT2
#same logic applies for months 2-3, 3-4, 4-5, 5-6 pairs
#if BILL_AMT2 = 0 but BILL_AMT1 > 0, then change will be captured as 100%
credit$BILL_PERCENTAGE_CHANGE1 <- if_else(credit$BILL_AMT2 != 0, (credit$BILL_AMT1-credit$BILL_AMT2)/credit$BILL_AMT2, 1)
credit$BILL_PERCENTAGE_CHANGE2 <- if_else(credit$BILL_AMT3 != 0, (credit$BILL_AMT2-credit$BILL_AMT3)/credit$BILL_AMT3, 1)
credit$BILL_PERCENTAGE_CHANGE3 <- if_else(credit$BILL_AMT4 != 0, (credit$BILL_AMT3-credit$BILL_AMT4)/credit$BILL_AMT4, 1)
credit$BILL_PERCENTAGE_CHANGE4 <- if_else(credit$BILL_AMT5 != 0, (credit$BILL_AMT4-credit$BILL_AMT5)/credit$BILL_AMT5, 1)
credit$BILL_PERCENTAGE_CHANGE5 <- if_else(credit$BILL_AMT6 != 0, (credit$BILL_AMT5-credit$BILL_AMT6)/credit$BILL_AMT6, 1)

#33 Average Bill Amount as a % of Credit Limit (LIMIT_BAL field in table)
credit$BILL_AMT1_PERCENTAGE <- credit$BILL_AMT1/credit$LIMIT_BAL
credit$BILL_AMT2_PERCENTAGE <- credit$BILL_AMT2/credit$LIMIT_BAL
credit$BILL_AMT3_PERCENTAGE <- credit$BILL_AMT3/credit$LIMIT_BAL
credit$BILL_AMT4_PERCENTAGE <- credit$BILL_AMT4/credit$LIMIT_BAL
credit$BILL_AMT5_PERCENTAGE <- credit$BILL_AMT5/credit$LIMIT_BAL
credit$BILL_AMT6_PERCENTAGE <- credit$BILL_AMT6/credit$LIMIT_BAL

#34 Average Unpaid Amount as a % of Credit Limit (Avg unpaid amount is FE #5 - run that code first to be able to use this code)
credit$PAY_DIFFERENCE_AMT1_PERCENTAGE <- credit$PAY_DIFFERENCE_AMT1/credit$LIMIT_BAL
credit$PAY_DIFFERENCE_AMT2_PERCENTAGE <- credit$PAY_DIFFERENCE_AMT2/credit$LIMIT_BAL
credit$PAY_DIFFERENCE_AMT3_PERCENTAGE <- credit$PAY_DIFFERENCE_AMT3/credit$LIMIT_BAL
credit$PAY_DIFFERENCE_AMT4_PERCENTAGE <- credit$PAY_DIFFERENCE_AMT4/credit$LIMIT_BAL
credit$PAY_DIFFERENCE_AMT5_PERCENTAGE <- credit$PAY_DIFFERENCE_AMT5/credit$LIMIT_BAL

# #shiv start
#42

credit$MONTHLY_SPEND1 <- credit$BILL_AMT1 - (credit$BILL_AMT2 - credit$PAY_AMT1)
credit$MONTHLY_SPEND2 <- credit$BILL_AMT2 - (credit$BILL_AMT3 - credit$PAY_AMT2)
credit$MONTHLY_SPEND3 <- credit$BILL_AMT3 - (credit$BILL_AMT4 - credit$PAY_AMT3)
credit$MONTHLY_SPEND4 <- credit$BILL_AMT4 - (credit$BILL_AMT5 - credit$PAY_AMT4)
credit$MONTHLY_SPEND5 <- credit$BILL_AMT5 - (credit$BILL_AMT6 - credit$PAY_AMT5)

#43-#44
credit$MAX_MONTHLY_SPEND <- max(credit$MONTHLY_SPEND1,credit$MONTHLY_SPEND2,credit$MONTHLY_SPEND3,credit$MONTHLY_SPEND4,credit$MONTHLY_SPEND5)
credit$MIN_MONTHLY_SPEND <- min(credit$MONTHLY_SPEND1,credit$MONTHLY_SPEND2,credit$MONTHLY_SPEND3,credit$MONTHLY_SPEND4,credit$MONTHLY_SPEND5)


#47 - #48
credit$MAX_PAY_DIFFERENCE_AMT_PERCENTAGE <- max(credit$PAY_DIFFERENCE_AMT1_PERCENTAGE,credit$PAY_DIFFERENCE_AMT2_PERCENTAGE, credit$PAY_DIFFERENCE_AMT3_PERCENTAG, credit$PAY_DIFFERENCE_AMT4_PERCENTAG, credit$PAY_DIFFERENCE_AMT5_PERCENTAGE  )
credit$MIN_PAY_DIFFERENCE_AMT_PERCENTAGE <- min(credit$PAY_DIFFERENCE_AMT1_PERCENTAGE,credit$PAY_DIFFERENCE_AMT2_PERCENTAGE, credit$PAY_DIFFERENCE_AMT3_PERCENTAG, credit$PAY_DIFFERENCE_AMT4_PERCENTAG, credit$PAY_DIFFERENCE_AMT5_PERCENTAGE  )

#52
credit$CUST_MATURITY1 <-  credit$LIMIT_BAL - credit$MONTHLY_SPEND1
credit$CUST_MATURITY2 <-  credit$LIMIT_BAL - credit$MONTHLY_SPEND2
credit$CUST_MATURITY3 <-  credit$LIMIT_BAL - credit$MONTHLY_SPEND3
credit$CUST_MATURITY4 <-  credit$LIMIT_BAL - credit$MONTHLY_SPEND4
credit$CUST_MATURITY5 <-  credit$LIMIT_BAL - credit$MONTHLY_SPEND5

#53 - #54
credit$MAX_CUST_MATURITY <-  max(credit$CUST_MATURITY1, credit$CUST_MATURITY2, credit$CUST_MATURITY3, credit$CUST_MATURITY4, credit$CUST_MATURITY5)
credit$MIN_CUST_MATURITY <-  min(credit$CUST_MATURITY1, credit$CUST_MATURITY2, credit$CUST_MATURITY3, credit$CUST_MATURITY4, credit$CUST_MATURITY5)

#57
credit$CUST_2MATURITY1 <-  credit$MONTHLY_SPEND1 / credit$LIMIT_BAL
credit$CUST_2MATURITY2 <-  credit$MONTHLY_SPEND2 / credit$LIMIT_BAL
credit$CUST_2MATURITY3 <-  credit$MONTHLY_SPEND3 / credit$LIMIT_BAL
credit$CUST_2MATURITY4 <-  credit$MONTHLY_SPEND4 / credit$LIMIT_BAL
credit$CUST_2MATURITY5 <-  credit$MONTHLY_SPEND5 / credit$LIMIT_BAL

#58 - #59
credit$MAX_CUST_2MATURITY <- max(credit$CUST_2MATURITY1,credit$CUST_2MATURITY2, credit$CUST_2MATURITY3, credit$CUST_2MATURITY4, credit$CUST_2MATURITY5 )
credit$MIN_CUST_2MATURITY <- min(credit$CUST_2MATURITY1,credit$CUST_2MATURITY2, credit$CUST_2MATURITY3, credit$CUST_2MATURITY4, credit$CUST_2MATURITY5 )

#62 - #63
credit$MAX_PAY_AMT <-  max(credit$PAY_AMT1, credit$PAY_AMT2, credit$PAY_AMT3, credit$PAY_AMT4, credit$PAY_AMT5, credit$PAY_AMT6 )
credit$MAX_PAY_AMT <-  min(credit$PAY_AMT1, credit$PAY_AMT2, credit$PAY_AMT3, credit$PAY_AMT4, credit$PAY_AMT5, credit$PAY_AMT6 )

#66 - #67
credit$MAX_BILL_AMT <- max(credit$BILL_AMT1, credit$BILL_AMT2, credit$BILL_AMT3, credit$BILL_AMT4, credit$BILL_AMT5, credit$BILL_AMT6 )
credit$MIN_BILL_AMT <- min(credit$BILL_AMT1, credit$BILL_AMT2, credit$BILL_AMT3, credit$BILL_AMT4, credit$BILL_AMT5, credit$BILL_AMT6 )

#71 - #72
credit$MAX_BILL_AMT1_PERCENTAGE <- max(credit$BILL_AMT1_PERCENTAGE, credit$BILL_AMT2_PERCENTAGE, credit$BILL_AMT3_PERCENTAGE, credit$BILL_AMT4_PERCENTAGE, credit$BILL_AMT5_PERCENTAGE, credit$BILL_AMT6_PERCENTAGE)
credit$MIN_BILL_AMT1_PERCENTAGE <- min(credit$BILL_AMT1_PERCENTAGE, credit$BILL_AMT2_PERCENTAGE, credit$BILL_AMT3_PERCENTAGE, credit$BILL_AMT4_PERCENTAGE, credit$BILL_AMT5_PERCENTAGE, credit$BILL_AMT6_PERCENTAGE)

#75
credit$AVAILABLE_CREDIT1 <- 1 - credit$BILL_AMT1_PERCENTAGE
credit$AVAILABLE_CREDIT2 <- 1 - credit$BILL_AMT2_PERCENTAGE
credit$AVAILABLE_CREDIT3 <- 1 - credit$BILL_AMT3_PERCENTAGE
credit$AVAILABLE_CREDIT4 <- 1 - credit$BILL_AMT4_PERCENTAGE
credit$AVAILABLE_CREDIT5 <- 1 - credit$BILL_AMT5_PERCENTAGE
credit$AVAILABLE_CREDIT6 <- 1 - credit$BILL_AMT6_PERCENTAGE

#76 -#77
credit$MAX_AVAILABLE_CREDIT <- max(credit$AVAILABLE_CREDIT1, credit$AVAILABLE_CREDIT2, credit$AVAILABLE_CREDIT3, credit$AVAILABLE_CREDIT4, credit$AVAILABLE_CREDIT5, credit$AVAILABLE_CREDIT6)
credit$MIN_AVAILABLE_CREDIT <- min(credit$AVAILABLE_CREDIT1, credit$AVAILABLE_CREDIT2, credit$AVAILABLE_CREDIT3, credit$AVAILABLE_CREDIT4, credit$AVAILABLE_CREDIT5, credit$AVAILABLE_CREDIT6)

#80
credit$PAYMNT_HIST1 <- if_else(credit$BILL_AMT2 == 0, 1, credit$PAY_AMT1 / credit$BILL_AMT2 )
credit$PAYMNT_HIST2 <- if_else(credit$BILL_AMT3 == 0, 1, credit$PAY_AMT2 / credit$BILL_AMT3 )
credit$PAYMNT_HIST3 <- if_else(credit$BILL_AMT4 == 0, 1, credit$PAY_AMT3 / credit$BILL_AMT4 )
credit$PAYMNT_HIST4 <- if_else(credit$BILL_AMT5 == 0, 1, credit$PAY_AMT4 / credit$BILL_AMT5 )
credit$PAYMNT_HIST5 <- if_else(credit$BILL_AMT6 == 0, 1, credit$PAY_AMT5 / credit$BILL_AMT6 )

#81 - #82
credit$MAX_PAYMNT_HIST <- max(credit$PAYMNT_HIST1, credit$PAYMNT_HIST2, credit$PAYMNT_HIST3, credit$PAYMNT_HIST4, credit$PAYMNT_HIST5)
credit$MIN_PAYMNT_HIST <- min(credit$PAYMNT_HIST1, credit$PAYMNT_HIST2, credit$PAYMNT_HIST3, credit$PAYMNT_HIST4, credit$PAYMNT_HIST5)






# #remove ID column
# credit <- credit %>%
#   dplyr::select(-ID)
# 
# 
# 
# 
# ## SOLUTIONS DATA
# 
# #replicate all feature engineering
# solutions <- solutions %>%
#   dplyr::select(-CONCAT,-ID)

#change necessary data types
#we want to change these variables from integers to factor variables
solutions$SEX <- as.factor(solutions$SEX)
solutions$EDUCATION <- as.factor(solutions$EDUCATION)
solutions$MARRIAGE <- as.factor(solutions$MARRIAGE)
solutions$default_0 <- as.factor(solutions$default_0)
solutions$BILL_AMT1 <- as.numeric(solutions$BILL_AMT1)
solutions$BILL_AMT2 <- as.numeric(solutions$BILL_AMT2)
solutions$BILL_AMT3 <- as.numeric(solutions$BILL_AMT3)
solutions$BILL_AMT4 <- as.numeric(solutions$BILL_AMT4)
solutions$BILL_AMT5 <- as.numeric(solutions$BILL_AMT5)
solutions$BILL_AMT6 <- as.numeric(solutions$BILL_AMT6)
solutions$PAY_AMT4 <- as.numeric(solutions$PAY_AMT4)
solutions$PAY_AMT6 <- as.numeric(solutions$PAY_AMT6)


solutions$PAY_1T <- as.factor(solutions$PAY_1)
solutions$PAY_2T <- as.factor(solutions$PAY_2)
solutions$PAY_3T <- as.factor(solutions$PAY_3)
solutions$PAY_4T <- as.factor(solutions$PAY_4)
solutions$PAY_5T <- as.factor(solutions$PAY_5)
solutions$PAY_6T <- as.factor(solutions$PAY_6)

str(solutions)

#---NOTE: There are a handful of '0' values for Marriage (42 records) and Education (11 records).
#         '0' is unaccounted for in the data dictionary for these variables.
#         After conferring with TA, We will leave them as is (to not potentially contaminate the other buckets).

#1 Pay_Amt/Age
solutions$PAY_AMT1_DIV_AGE <- solutions$PAY_AMT1/solutions$AGE
solutions$PAY_AMT2_DIV_AGE <- solutions$PAY_AMT2/solutions$AGE
solutions$PAY_AMT3_DIV_AGE <- solutions$PAY_AMT3/solutions$AGE
solutions$PAY_AMT4_DIV_AGE <- solutions$PAY_AMT4/solutions$AGE
solutions$PAY_AMT5_DIV_AGE <- solutions$PAY_AMT5/solutions$AGE
solutions$PAY_AMT6_DIV_AGE <- solutions$PAY_AMT6/solutions$AGE

#2 Pay_Amt/Education
#convert Education to numeric type, engineer new variable, convert Education back to factor
solutions$EDUCATION <- as.numeric(solutions$EDUCATION)

solutions$PAY_AMT1_DIV_EDU <- solutions$PAY_AMT1/solutions$EDUCATION
solutions$PAY_AMT2_DIV_EDU <- solutions$PAY_AMT2/solutions$EDUCATION
solutions$PAY_AMT3_DIV_EDU <- solutions$PAY_AMT3/solutions$EDUCATION
solutions$PAY_AMT4_DIV_EDU <- solutions$PAY_AMT4/solutions$EDUCATION
solutions$PAY_AMT5_DIV_EDU <- solutions$PAY_AMT5/solutions$EDUCATION
solutions$PAY_AMT6_DIV_EDU <- solutions$PAY_AMT6/solutions$EDUCATION

solutions$EDUCATION <- solutions$EDUCATION-1 #for whatever reason, converting to numeric above added +1
solutions$EDUCATION <- as.factor(solutions$EDUCATION)

#3 Bill_Amt/Age
#Creating 6 variables - 1 for each Bill_Amt
solutions$BILL_AMT1_DIV_AGE <- solutions$BILL_AMT1/solutions$AGE
solutions$BILL_AMT2_DIV_AGE <- solutions$BILL_AMT2/solutions$AGE
solutions$BILL_AMT3_DIV_AGE <- solutions$BILL_AMT3/solutions$AGE
solutions$BILL_AMT4_DIV_AGE <- solutions$BILL_AMT4/solutions$AGE
solutions$BILL_AMT5_DIV_AGE <- solutions$BILL_AMT5/solutions$AGE
solutions$BILL_AMT6_DIV_AGE <- solutions$BILL_AMT6/solutions$AGE

#4 Bill_Amt/Education
#Creating 6 variables - 1 for each Bill_Amt
#convert Education to numeric type, engineer new variable, convert Education back to factor
solutions$EDUCATION <- as.numeric(solutions$EDUCATION)

solutions$BILL_AMT1_DIV_EDU <- solutions$BILL_AMT1/solutions$EDUCATION
solutions$BILL_AMT2_DIV_EDU <- solutions$BILL_AMT2/solutions$EDUCATION
solutions$BILL_AMT3_DIV_EDU <- solutions$BILL_AMT3/solutions$EDUCATION
solutions$BILL_AMT4_DIV_EDU <- solutions$BILL_AMT4/solutions$EDUCATION
solutions$BILL_AMT5_DIV_EDU <- solutions$BILL_AMT5/solutions$EDUCATION
solutions$BILL_AMT6_DIV_EDU <- solutions$BILL_AMT6/solutions$EDUCATION

solutions$EDUCATION <- solutions$EDUCATION-1 #for whatever reason, converting to numeric above added +1
solutions$EDUCATION <- as.factor(solutions$EDUCATION)

#5 Bill_Amt - Pay_Amt
#Creating 5 variables - 1 for each pair of Bill-Pay period (Pay_Amt1 is payment for Bill_Amt2)
solutions$PAY_DIFFERENCE_AMT1 <- solutions$BILL_AMT2-solutions$PAY_AMT1
solutions$PAY_DIFFERENCE_AMT2 <- solutions$BILL_AMT3-solutions$PAY_AMT2
solutions$PAY_DIFFERENCE_AMT3 <- solutions$BILL_AMT4-solutions$PAY_AMT3
solutions$PAY_DIFFERENCE_AMT4 <- solutions$BILL_AMT5-solutions$PAY_AMT4
solutions$PAY_DIFFERENCE_AMT5 <- solutions$BILL_AMT6-solutions$PAY_AMT5

#6 (Bill_Amt-Pay_Amt)/Age
#Creating 5 variables - 1 for each Bill-Pay pair
solutions$PAY_DIFFERENCE_AMT1_DIV_AGE <- solutions$PAY_DIFFERENCE_AMT1/solutions$AGE
solutions$PAY_DIFFERENCE_AMT2_DIV_AGE <- solutions$PAY_DIFFERENCE_AMT2/solutions$AGE
solutions$PAY_DIFFERENCE_AMT3_DIV_AGE <- solutions$PAY_DIFFERENCE_AMT3/solutions$AGE
solutions$PAY_DIFFERENCE_AMT4_DIV_AGE <- solutions$PAY_DIFFERENCE_AMT4/solutions$AGE
solutions$PAY_DIFFERENCE_AMT5_DIV_AGE <- solutions$PAY_DIFFERENCE_AMT5/solutions$AGE

#7 Bill_Amt-Pay amt/Education
#Creating 5 variables - 1 for each Bill-pay pair
#convert Education to numeric type, engineer new variable, convert Education back to factor
solutions$EDUCATION <- as.numeric(solutions$EDUCATION)

solutions$PAY_DIFFERENCE_AMT1_DIV_EDU <- solutions$PAY_DIFFERENCE_AMT1/solutions$EDUCATION
solutions$PAY_DIFFERENCE_AMT2_DIV_EDU <- solutions$PAY_DIFFERENCE_AMT2/solutions$EDUCATION
solutions$PAY_DIFFERENCE_AMT3_DIV_EDU <- solutions$PAY_DIFFERENCE_AMT3/solutions$EDUCATION
solutions$PAY_DIFFERENCE_AMT4_DIV_EDU <- solutions$PAY_DIFFERENCE_AMT4/solutions$EDUCATION
solutions$PAY_DIFFERENCE_AMT5_DIV_EDU <- solutions$PAY_DIFFERENCE_AMT5/solutions$EDUCATION

solutions$EDUCATION <- solutions$EDUCATION-1 #for whatever reason, converting to numeric above added +1
solutions$EDUCATION <- as.factor(solutions$EDUCATION)

#8 Credit limit/Age
#Creating 1 variable
solutions$CREDIT_LIMIT_DIV_AGE <- solutions$LIMIT_BAL/solutions$AGE

#9 Credit Limit/Education
#Creating 1 variable
#convert Education to numeric type, engineer new variable, convert Education back to factor
solutions$EDUCATION <- as.numeric(solutions$EDUCATION)

solutions$CREDIT_LIMIT_DIV_EDU <- solutions$LIMIT_BAL/solutions$EDUCATION

solutions$EDUCATION <- solutions$EDUCATION-1 #for whatever reason, converting to numeric above added +1
solutions$EDUCATION <- as.factor(solutions$EDUCATION)

#12 Total Payments Satisfied
#can check for only 5 bill-pay pairs so this number will range from 0 to 5
solutions$TOTAL_PAYMENTS_SATISFIED <- 0

solutions$TOTAL_PAYMENTS_SATISFIED <- if_else(solutions$PAY_AMT1>=solutions$BILL_AMT2,1+solutions$TOTAL_PAYMENTS_SATISFIED, solutions$TOTAL_PAYMENTS_SATISFIED)
solutions$TOTAL_PAYMENTS_SATISFIED <- if_else(solutions$PAY_AMT2>=solutions$BILL_AMT3,1+solutions$TOTAL_PAYMENTS_SATISFIED, solutions$TOTAL_PAYMENTS_SATISFIED)
solutions$TOTAL_PAYMENTS_SATISFIED <- if_else(solutions$PAY_AMT3>=solutions$BILL_AMT4,1+solutions$TOTAL_PAYMENTS_SATISFIED, solutions$TOTAL_PAYMENTS_SATISFIED)
solutions$TOTAL_PAYMENTS_SATISFIED <- if_else(solutions$PAY_AMT4>=solutions$BILL_AMT5,1+solutions$TOTAL_PAYMENTS_SATISFIED, solutions$TOTAL_PAYMENTS_SATISFIED)
solutions$TOTAL_PAYMENTS_SATISFIED <- if_else(solutions$PAY_AMT5>=solutions$BILL_AMT6,1+solutions$TOTAL_PAYMENTS_SATISFIED, solutions$TOTAL_PAYMENTS_SATISFIED)

#13 Total Payments Missed - need to run code for FE #12 to run this
#exact inverse of Total Payments Satisfied
solutions$TOTAL_PAYMENTS_MISSED <- 5 - solutions$TOTAL_PAYMENTS_SATISFIED
#collinearity?

#16 Zero Bill
#Creating 6 variables, change to factors
solutions$ZERO_BILL1 <- if_else(solutions$BILL_AMT1==0,1,0)
solutions$ZERO_BILL2 <- if_else(solutions$BILL_AMT2==0,1,0)
solutions$ZERO_BILL3 <- if_else(solutions$BILL_AMT3==0,1,0)
solutions$ZERO_BILL4 <- if_else(solutions$BILL_AMT4==0,1,0)
solutions$ZERO_BILL5 <- if_else(solutions$BILL_AMT5==0,1,0)
solutions$ZERO_BILL6 <- if_else(solutions$BILL_AMT6==0,1,0)

#17 Zero Pay
#Creating 6 variables, change to factors
solutions$ZERO_PAY1 <- if_else(solutions$PAY_AMT1==0,1,0)
solutions$ZERO_PAY2 <- if_else(solutions$PAY_AMT2==0,1,0)
solutions$ZERO_PAY3 <- if_else(solutions$PAY_AMT3==0,1,0)
solutions$ZERO_PAY4 <- if_else(solutions$PAY_AMT4==0,1,0)
solutions$ZERO_PAY5 <- if_else(solutions$PAY_AMT5==0,1,0)
solutions$ZERO_PAY6 <- if_else(solutions$PAY_AMT6==0,1,0)

#14 Total Zero Bill Months - need FE #16 to run this
solutions$TOTAL_ZERO_BILL_MONTHS <- solutions$ZERO_BILL1+solutions$ZERO_BILL2+solutions$ZERO_BILL3+solutions$ZERO_BILL4+solutions$ZERO_BILL5+solutions$ZERO_BILL6

solutions$ZERO_BILL1 <- as.factor(solutions$ZERO_BILL1)
solutions$ZERO_BILL2 <- as.factor(solutions$ZERO_BILL2)
solutions$ZERO_BILL3 <- as.factor(solutions$ZERO_BILL3)
solutions$ZERO_BILL4 <- as.factor(solutions$ZERO_BILL4)
solutions$ZERO_BILL5 <- as.factor(solutions$ZERO_BILL5)
solutions$ZERO_BILL6 <- as.factor(solutions$ZERO_BILL6)

#15 Total Zero Pay Months - need FE #17 to run this
#change FE #17 back to numeric, then return to factor
solutions$TOTAL_ZERO_PAY_MONTHS <- solutions$ZERO_PAY1+solutions$ZERO_PAY2+solutions$ZERO_PAY3+solutions$ZERO_PAY4+solutions$ZERO_PAY5+solutions$ZERO_PAY6

solutions$ZERO_PAY1 <- as.factor(solutions$ZERO_PAY1)
solutions$ZERO_PAY2 <- as.factor(solutions$ZERO_PAY2)
solutions$ZERO_PAY3 <- as.factor(solutions$ZERO_PAY3)
solutions$ZERO_PAY4 <- as.factor(solutions$ZERO_PAY4)
solutions$ZERO_PAY5 <- as.factor(solutions$ZERO_PAY5)
solutions$ZERO_PAY6 <- as.factor(solutions$ZERO_PAY6)

#18 Bill Range
i <- 1
solutions$BILL_RANGE <- 0

for (i in 1:nrow(solutions)){
  solutions$BILL_RANGE[i] <- max(solutions$BILL_AMT1[i], solutions$BILL_AMT2[i], solutions$BILL_AMT3[i], solutions$BILL_AMT4[i], solutions$BILL_AMT5[i], solutions$BILL_AMT6[i]) - min(solutions$BILL_AMT1[i], solutions$BILL_AMT2[i], solutions$BILL_AMT3[i], solutions$BILL_AMT4[i], solutions$BILL_AMT5[i], solutions$BILL_AMT6[i])
}

#19 Pay Range
i <- 1
solutions$PAY_RANGE <- 0

for (i in 1:nrow(solutions)){
  solutions$PAY_RANGE[i] <- max(solutions$PAY_AMT1[i], solutions$PAY_AMT2[i], solutions$PAY_AMT3[i], solutions$PAY_AMT4[i], solutions$PAY_AMT5[i], solutions$PAY_AMT6[i]) - min(solutions$PAY_AMT1[i], solutions$PAY_AMT2[i], solutions$PAY_AMT3[i], solutions$PAY_AMT4[i], solutions$PAY_AMT5[i], solutions$PAY_AMT6[i])
}

#23 Cumulative % of Bill Paid
solutions$CUMU_PERCENT_BILL_PAID1 <- if_else(solutions$BILL_AMT1 == 0,1,solutions$PAY_AMT1/solutions$BILL_AMT1)
solutions$CUMU_PERCENT_BILL_PAID2 <- if_else(solutions$BILL_AMT2 == 0,1,solutions$PAY_AMT2/solutions$BILL_AMT2)
solutions$CUMU_PERCENT_BILL_PAID3 <- if_else(solutions$BILL_AMT3 == 0,1,solutions$PAY_AMT3/solutions$BILL_AMT3)
solutions$CUMU_PERCENT_BILL_PAID4 <- if_else(solutions$BILL_AMT4 == 0,1,solutions$PAY_AMT4/solutions$BILL_AMT4)
solutions$CUMU_PERCENT_BILL_PAID5 <- if_else(solutions$BILL_AMT5 == 0,1,solutions$PAY_AMT5/solutions$BILL_AMT5)
solutions$CUMU_PERCENT_BILL_PAID6 <- if_else(solutions$BILL_AMT6 == 0,1,solutions$PAY_AMT6/solutions$BILL_AMT6)

#24 Dummy: Bill Amount is 1 SD away
#creating 6 variables, 1 for each Bill Amt month, convert to factors
solutions$BILL_AMT1_1_SD_AWAY <- 0
solutions$BILL_AMT2_1_SD_AWAY <- 0
solutions$BILL_AMT3_1_SD_AWAY <- 0
solutions$BILL_AMT4_1_SD_AWAY <- 0
solutions$BILL_AMT5_1_SD_AWAY <- 0
solutions$BILL_AMT6_1_SD_AWAY <- 0

solutions$BILL_AMT1_1_SD_AWAY <- if_else(solutions$BILL_AMT1 >= mean(solutions$BILL_AMT1)+sqrt(var(solutions$BILL_AMT1)), 1, solutions$BILL_AMT1_1_SD_AWAY)
solutions$BILL_AMT1_1_SD_AWAY <- if_else(solutions$BILL_AMT1 <= mean(solutions$BILL_AMT1)-sqrt(var(solutions$BILL_AMT1)), 1, solutions$BILL_AMT1_1_SD_AWAY)

solutions$BILL_AMT2_1_SD_AWAY <- if_else(solutions$BILL_AMT2 >= mean(solutions$BILL_AMT2)+sqrt(var(solutions$BILL_AMT2)), 1, solutions$BILL_AMT2_1_SD_AWAY)
solutions$BILL_AMT2_1_SD_AWAY <- if_else(solutions$BILL_AMT2 <= mean(solutions$BILL_AMT2)-sqrt(var(solutions$BILL_AMT2)), 1, solutions$BILL_AMT2_1_SD_AWAY)

solutions$BILL_AMT3_1_SD_AWAY <- if_else(solutions$BILL_AMT3 >= mean(solutions$BILL_AMT3)+sqrt(var(solutions$BILL_AMT3)), 1, solutions$BILL_AMT3_1_SD_AWAY)
solutions$BILL_AMT3_1_SD_AWAY <- if_else(solutions$BILL_AMT3 <= mean(solutions$BILL_AMT3)-sqrt(var(solutions$BILL_AMT3)), 1, solutions$BILL_AMT3_1_SD_AWAY)

solutions$BILL_AMT4_1_SD_AWAY <- if_else(solutions$BILL_AMT4 >= mean(solutions$BILL_AMT4)+sqrt(var(solutions$BILL_AMT4)), 1, solutions$BILL_AMT4_1_SD_AWAY)
solutions$BILL_AMT4_1_SD_AWAY <- if_else(solutions$BILL_AMT4 <= mean(solutions$BILL_AMT4)-sqrt(var(solutions$BILL_AMT4)), 1, solutions$BILL_AMT4_1_SD_AWAY)

solutions$BILL_AMT5_1_SD_AWAY <- if_else(solutions$BILL_AMT5 >= mean(solutions$BILL_AMT5)+sqrt(var(solutions$BILL_AMT5)), 1, solutions$BILL_AMT5_1_SD_AWAY)
solutions$BILL_AMT5_1_SD_AWAY <- if_else(solutions$BILL_AMT5 <= mean(solutions$BILL_AMT5)-sqrt(var(solutions$BILL_AMT5)), 1, solutions$BILL_AMT5_1_SD_AWAY)

solutions$BILL_AMT6_1_SD_AWAY <- if_else(solutions$BILL_AMT6 >= mean(solutions$BILL_AMT6)+sqrt(var(solutions$BILL_AMT6)), 1, solutions$BILL_AMT6_1_SD_AWAY)
solutions$BILL_AMT6_1_SD_AWAY <- if_else(solutions$BILL_AMT6 <= mean(solutions$BILL_AMT6)-sqrt(var(solutions$BILL_AMT6)), 1, solutions$BILL_AMT6_1_SD_AWAY)

solutions$BILL_AMT1_1_SD_AWAY <- as.factor(solutions$BILL_AMT1_1_SD_AWAY)
solutions$BILL_AMT2_1_SD_AWAY <- as.factor(solutions$BILL_AMT2_1_SD_AWAY)
solutions$BILL_AMT3_1_SD_AWAY <- as.factor(solutions$BILL_AMT3_1_SD_AWAY)
solutions$BILL_AMT4_1_SD_AWAY <- as.factor(solutions$BILL_AMT4_1_SD_AWAY)
solutions$BILL_AMT5_1_SD_AWAY <- as.factor(solutions$BILL_AMT5_1_SD_AWAY)
solutions$BILL_AMT6_1_SD_AWAY <- as.factor(solutions$BILL_AMT6_1_SD_AWAY)

#25 Dummy: Paid Amount is 1 SD away
#creating 6 variables, 1 for each Pay Amt month, convert to factors
solutions$PAY_AMT1_1_SD_AWAY <- 0
solutions$PAY_AMT2_1_SD_AWAY <- 0
solutions$PAY_AMT3_1_SD_AWAY <- 0
solutions$PAY_AMT4_1_SD_AWAY <- 0
solutions$PAY_AMT5_1_SD_AWAY <- 0
solutions$PAY_AMT6_1_SD_AWAY <- 0

solutions$PAY_AMT1_1_SD_AWAY <- if_else(solutions$PAY_AMT1 >= mean(solutions$PAY_AMT1)+sqrt(var(solutions$PAY_AMT1)), 1, solutions$PAY_AMT1_1_SD_AWAY)
solutions$PAY_AMT1_1_SD_AWAY <- if_else(solutions$PAY_AMT1 <= mean(solutions$PAY_AMT1)-sqrt(var(solutions$PAY_AMT1)), 1, solutions$PAY_AMT1_1_SD_AWAY)

solutions$PAY_AMT2_1_SD_AWAY <- if_else(solutions$PAY_AMT2 >= mean(solutions$PAY_AMT2)+sqrt(var(solutions$PAY_AMT2)), 1, solutions$PAY_AMT2_1_SD_AWAY)
solutions$PAY_AMT2_1_SD_AWAY <- if_else(solutions$PAY_AMT2 <= mean(solutions$PAY_AMT2)-sqrt(var(solutions$PAY_AMT2)), 1, solutions$PAY_AMT2_1_SD_AWAY)

solutions$PAY_AMT3_1_SD_AWAY <- if_else(solutions$PAY_AMT3 >= mean(solutions$PAY_AMT3)+sqrt(var(solutions$PAY_AMT3)), 1, solutions$PAY_AMT3_1_SD_AWAY)
solutions$PAY_AMT3_1_SD_AWAY <- if_else(solutions$PAY_AMT3 <= mean(solutions$PAY_AMT3)-sqrt(var(solutions$PAY_AMT3)), 1, solutions$PAY_AMT3_1_SD_AWAY)

solutions$PAY_AMT4_1_SD_AWAY <- if_else(solutions$PAY_AMT4 >= mean(solutions$PAY_AMT4)+sqrt(var(solutions$PAY_AMT4)), 1, solutions$PAY_AMT4_1_SD_AWAY)
solutions$PAY_AMT4_1_SD_AWAY <- if_else(solutions$PAY_AMT4 <= mean(solutions$PAY_AMT4)-sqrt(var(solutions$PAY_AMT4)), 1, solutions$PAY_AMT4_1_SD_AWAY)

solutions$PAY_AMT5_1_SD_AWAY <- if_else(solutions$PAY_AMT5 >= mean(solutions$PAY_AMT5)+sqrt(var(solutions$PAY_AMT5)), 1, solutions$PAY_AMT5_1_SD_AWAY)
solutions$PAY_AMT5_1_SD_AWAY <- if_else(solutions$PAY_AMT5 <= mean(solutions$PAY_AMT5)-sqrt(var(solutions$PAY_AMT5)), 1, solutions$PAY_AMT5_1_SD_AWAY)

solutions$PAY_AMT6_1_SD_AWAY <- if_else(solutions$PAY_AMT6 >= mean(solutions$PAY_AMT6)+sqrt(var(solutions$PAY_AMT6)), 1, solutions$PAY_AMT6_1_SD_AWAY)
solutions$PAY_AMT6_1_SD_AWAY <- if_else(solutions$PAY_AMT6 <= mean(solutions$PAY_AMT6)-sqrt(var(solutions$PAY_AMT6)), 1, solutions$PAY_AMT6_1_SD_AWAY)

solutions$PAY_AMT1_1_SD_AWAY <- as.factor(solutions$PAY_AMT1_1_SD_AWAY)
solutions$PAY_AMT2_1_SD_AWAY <- as.factor(solutions$PAY_AMT2_1_SD_AWAY)
solutions$PAY_AMT3_1_SD_AWAY <- as.factor(solutions$PAY_AMT3_1_SD_AWAY)
solutions$PAY_AMT4_1_SD_AWAY <- as.factor(solutions$PAY_AMT4_1_SD_AWAY)
solutions$PAY_AMT5_1_SD_AWAY <- as.factor(solutions$PAY_AMT5_1_SD_AWAY)
solutions$PAY_AMT6_1_SD_AWAY <- as.factor(solutions$PAY_AMT6_1_SD_AWAY)

#26 Dummy: Bill amt - Paid amt 1 SD away - you need FE variable #5 to use code for this variable
#creating 5 variables, 1 for each Bill-Pay pair, convert to factors
solutions$PAY_DIFFERENCE_AMT1_1_SD_AWAY <- 0
solutions$PAY_DIFFERENCE_AMT2_1_SD_AWAY <- 0
solutions$PAY_DIFFERENCE_AMT3_1_SD_AWAY <- 0
solutions$PAY_DIFFERENCE_AMT4_1_SD_AWAY <- 0
solutions$PAY_DIFFERENCE_AMT5_1_SD_AWAY <- 0

solutions$PAY_DIFFERENCE_AMT1_1_SD_AWAY <- if_else(solutions$PAY_DIFFERENCE_AMT1 >= mean(solutions$PAY_DIFFERENCE_AMT1)+sqrt(var(solutions$PAY_DIFFERENCE_AMT1)), 1, solutions$PAY_DIFFERENCE_AMT1_1_SD_AWAY)
solutions$PAY_DIFFERENCE_AMT1_1_SD_AWAY <- if_else(solutions$PAY_DIFFERENCE_AMT1 <= mean(solutions$PAY_DIFFERENCE_AMT1)-sqrt(var(solutions$PAY_DIFFERENCE_AMT1)), 1, solutions$PAY_DIFFERENCE_AMT1_1_SD_AWAY)

solutions$PAY_DIFFERENCE_AMT2_1_SD_AWAY <- if_else(solutions$PAY_DIFFERENCE_AMT2 >= mean(solutions$PAY_DIFFERENCE_AMT2)+sqrt(var(solutions$PAY_DIFFERENCE_AMT2)), 1, solutions$PAY_DIFFERENCE_AMT2_1_SD_AWAY)
solutions$PAY_DIFFERENCE_AMT2_1_SD_AWAY <- if_else(solutions$PAY_DIFFERENCE_AMT2 <= mean(solutions$PAY_DIFFERENCE_AMT2)-sqrt(var(solutions$PAY_DIFFERENCE_AMT2)), 1, solutions$PAY_DIFFERENCE_AMT2_1_SD_AWAY)

solutions$PAY_DIFFERENCE_AMT3_1_SD_AWAY <- if_else(solutions$PAY_DIFFERENCE_AMT3 >= mean(solutions$PAY_DIFFERENCE_AMT3)+sqrt(var(solutions$PAY_DIFFERENCE_AMT3)), 1, solutions$PAY_DIFFERENCE_AMT3_1_SD_AWAY)
solutions$PAY_DIFFERENCE_AMT3_1_SD_AWAY <- if_else(solutions$PAY_DIFFERENCE_AMT3 <= mean(solutions$PAY_DIFFERENCE_AMT3)-sqrt(var(solutions$PAY_DIFFERENCE_AMT3)), 1, solutions$PAY_DIFFERENCE_AMT3_1_SD_AWAY)

solutions$PAY_DIFFERENCE_AMT4_1_SD_AWAY <- if_else(solutions$PAY_DIFFERENCE_AMT4 >= mean(solutions$PAY_DIFFERENCE_AMT4)+sqrt(var(solutions$PAY_DIFFERENCE_AMT4)), 1, solutions$PAY_DIFFERENCE_AMT4_1_SD_AWAY)
solutions$PAY_DIFFERENCE_AMT4_1_SD_AWAY <- if_else(solutions$PAY_DIFFERENCE_AMT4 <= mean(solutions$PAY_DIFFERENCE_AMT4)-sqrt(var(solutions$PAY_DIFFERENCE_AMT4)), 1, solutions$PAY_DIFFERENCE_AMT4_1_SD_AWAY)

solutions$PAY_DIFFERENCE_AMT5_1_SD_AWAY <- if_else(solutions$PAY_DIFFERENCE_AMT5 >= mean(solutions$PAY_DIFFERENCE_AMT5)+sqrt(var(solutions$PAY_DIFFERENCE_AMT5)), 1, solutions$PAY_DIFFERENCE_AMT5_1_SD_AWAY)
solutions$PAY_DIFFERENCE_AMT5_1_SD_AWAY <- if_else(solutions$PAY_DIFFERENCE_AMT5 <= mean(solutions$PAY_DIFFERENCE_AMT5)-sqrt(var(solutions$PAY_DIFFERENCE_AMT5)), 1, solutions$PAY_DIFFERENCE_AMT5_1_SD_AWAY)

solutions$PAY_DIFFERENCE_AMT1_1_SD_AWAY <- as.factor(solutions$PAY_DIFFERENCE_AMT1_1_SD_AWAY)
solutions$PAY_DIFFERENCE_AMT2_1_SD_AWAY <- as.factor(solutions$PAY_DIFFERENCE_AMT2_1_SD_AWAY)
solutions$PAY_DIFFERENCE_AMT3_1_SD_AWAY <- as.factor(solutions$PAY_DIFFERENCE_AMT3_1_SD_AWAY)
solutions$PAY_DIFFERENCE_AMT4_1_SD_AWAY <- as.factor(solutions$PAY_DIFFERENCE_AMT4_1_SD_AWAY)
solutions$PAY_DIFFERENCE_AMT5_1_SD_AWAY <- as.factor(solutions$PAY_DIFFERENCE_AMT5_1_SD_AWAY)

#27 Age Buckets
#convert to factor
solutions$AGE_BUCKET <- "a"

solutions$AGE_BUCKET <- if_else(solutions$AGE < 18,"< 18 yrs",solutions$AGE_BUCKET)
solutions$AGE_BUCKET <- if_else(solutions$AGE >= 18 & solutions$AGE < 25,"18-24 yrs",solutions$AGE_BUCKET)
solutions$AGE_BUCKET <- if_else(solutions$AGE >= 25 & solutions$AGE < 35,"25-34 yrs",solutions$AGE_BUCKET)
solutions$AGE_BUCKET <- if_else(solutions$AGE >= 35 & solutions$AGE < 45,"35-44 yrs",solutions$AGE_BUCKET)
solutions$AGE_BUCKET <- if_else(solutions$AGE >= 45 & solutions$AGE < 55,"45-54 yrs",solutions$AGE_BUCKET)
solutions$AGE_BUCKET <- if_else(solutions$AGE >= 55,"> 55 yrs",solutions$AGE_BUCKET)

solutions$AGE_BUCKET <- as.factor((solutions$AGE_BUCKET))

#28 Limit_Bal Buckets i.e. Credit Limit Buckets
#convert to factor
solutions$CREDIT_LIMIT_BUCKET <- "a"

solutions$CREDIT_LIMIT_BUCKET <- if_else(solutions$LIMIT_BAL < 25000,"< 25K",solutions$CREDIT_LIMIT_BUCKET)
solutions$CREDIT_LIMIT_BUCKET <- if_else(solutions$LIMIT_BAL >= 25000 & solutions$LIMIT_BAL < 50000,"25-50K",solutions$CREDIT_LIMIT_BUCKET)
solutions$CREDIT_LIMIT_BUCKET <- if_else(solutions$LIMIT_BAL >= 50000 & solutions$LIMIT_BAL < 75000,"50-75K",solutions$CREDIT_LIMIT_BUCKET)
solutions$CREDIT_LIMIT_BUCKET <- if_else(solutions$LIMIT_BAL >= 75000 & solutions$LIMIT_BAL < 100000,"75-100K",solutions$CREDIT_LIMIT_BUCKET)
solutions$CREDIT_LIMIT_BUCKET <- if_else(solutions$LIMIT_BAL >= 100000 & solutions$LIMIT_BAL < 125000,"100-125K",solutions$CREDIT_LIMIT_BUCKET)
solutions$CREDIT_LIMIT_BUCKET <- if_else(solutions$LIMIT_BAL >= 125000 & solutions$LIMIT_BAL < 150000,"125-150K",solutions$CREDIT_LIMIT_BUCKET)
solutions$CREDIT_LIMIT_BUCKET <- if_else(solutions$LIMIT_BAL >= 150000 & solutions$LIMIT_BAL < 175000,"150-175K",solutions$CREDIT_LIMIT_BUCKET)
solutions$CREDIT_LIMIT_BUCKET <- if_else(solutions$LIMIT_BAL >= 175000 & solutions$LIMIT_BAL < 200000,"175-200K",solutions$CREDIT_LIMIT_BUCKET)
solutions$CREDIT_LIMIT_BUCKET <- if_else(solutions$LIMIT_BAL >= 200000 & solutions$LIMIT_BAL < 225000,"200-225K",solutions$CREDIT_LIMIT_BUCKET)
solutions$CREDIT_LIMIT_BUCKET <- if_else(solutions$LIMIT_BAL >= 225000 & solutions$LIMIT_BAL < 250000,"225-250K",solutions$CREDIT_LIMIT_BUCKET)
solutions$CREDIT_LIMIT_BUCKET <- if_else(solutions$LIMIT_BAL >= 250000 & solutions$LIMIT_BAL < 300000,"250-300K",solutions$CREDIT_LIMIT_BUCKET)
solutions$CREDIT_LIMIT_BUCKET <- if_else(solutions$LIMIT_BAL >= 300000 & solutions$LIMIT_BAL < 400000,"300-400K",solutions$CREDIT_LIMIT_BUCKET)
solutions$CREDIT_LIMIT_BUCKET <- if_else(solutions$LIMIT_BAL >= 400000 & solutions$LIMIT_BAL < 500000,"400-500K",solutions$CREDIT_LIMIT_BUCKET)
solutions$CREDIT_LIMIT_BUCKET <- if_else(solutions$LIMIT_BAL >= 500000 & solutions$LIMIT_BAL < 700000,"500-700K",solutions$CREDIT_LIMIT_BUCKET)
solutions$CREDIT_LIMIT_BUCKET <- if_else(solutions$LIMIT_BAL >= 700000 & solutions$LIMIT_BAL < 900000,"700-900K",solutions$CREDIT_LIMIT_BUCKET)
solutions$CREDIT_LIMIT_BUCKET <- if_else(solutions$LIMIT_BAL >= 900000 & solutions$LIMIT_BAL < 1000000,"900K-1Mn",solutions$CREDIT_LIMIT_BUCKET)
solutions$CREDIT_LIMIT_BUCKET <- if_else(solutions$LIMIT_BAL >= 1000000,"> 1Mn",solutions$CREDIT_LIMIT_BUCKET)

solutions$CREDIT_LIMIT_BUCKET <- as.factor(solutions$CREDIT_LIMIT_BUCKET)

#29a Frequency of Late Payments - capturing count of payments that are 3 or more months late
solutions$LATE_PAYMENT_FREQUENCY3 <- 0

solutions$LATE_PAYMENT_FREQUENCY3 <- if_else(solutions$PAY_1 >= 3,solutions$LATE_PAYMENT_FREQUENCY3+1,solutions$LATE_PAYMENT_FREQUENCY3)
solutions$LATE_PAYMENT_FREQUENCY3 <- if_else(solutions$PAY_2 >= 3,solutions$LATE_PAYMENT_FREQUENCY3+1,solutions$LATE_PAYMENT_FREQUENCY3)
solutions$LATE_PAYMENT_FREQUENCY3 <- if_else(solutions$PAY_3 >= 3,solutions$LATE_PAYMENT_FREQUENCY3+1,solutions$LATE_PAYMENT_FREQUENCY3)
solutions$LATE_PAYMENT_FREQUENCY3 <- if_else(solutions$PAY_4 >= 3,solutions$LATE_PAYMENT_FREQUENCY3+1,solutions$LATE_PAYMENT_FREQUENCY3)
solutions$LATE_PAYMENT_FREQUENCY3 <- if_else(solutions$PAY_5 >= 3,solutions$LATE_PAYMENT_FREQUENCY3+1,solutions$LATE_PAYMENT_FREQUENCY3)
solutions$LATE_PAYMENT_FREQUENCY3 <- if_else(solutions$PAY_6 >= 3,solutions$LATE_PAYMENT_FREQUENCY3+1,solutions$LATE_PAYMENT_FREQUENCY3)

#29b Frequency of Late Payments - capturing count of payments that are 5 or more months late
solutions$LATE_PAYMENT_FREQUENCY5 <- 0

solutions$LATE_PAYMENT_FREQUENCY5 <- if_else(solutions$PAY_1 >= 5,solutions$LATE_PAYMENT_FREQUENCY5+1,solutions$LATE_PAYMENT_FREQUENCY5)
solutions$LATE_PAYMENT_FREQUENCY5 <- if_else(solutions$PAY_2 >= 5,solutions$LATE_PAYMENT_FREQUENCY5+1,solutions$LATE_PAYMENT_FREQUENCY5)
solutions$LATE_PAYMENT_FREQUENCY5 <- if_else(solutions$PAY_3 >= 5,solutions$LATE_PAYMENT_FREQUENCY5+1,solutions$LATE_PAYMENT_FREQUENCY5)
solutions$LATE_PAYMENT_FREQUENCY5 <- if_else(solutions$PAY_4 >= 5,solutions$LATE_PAYMENT_FREQUENCY5+1,solutions$LATE_PAYMENT_FREQUENCY5)
solutions$LATE_PAYMENT_FREQUENCY5 <- if_else(solutions$PAY_5 >= 5,solutions$LATE_PAYMENT_FREQUENCY5+1,solutions$LATE_PAYMENT_FREQUENCY5)
solutions$LATE_PAYMENT_FREQUENCY5 <- if_else(solutions$PAY_6 >= 5,solutions$LATE_PAYMENT_FREQUENCY5+1,solutions$LATE_PAYMENT_FREQUENCY5)

#29c Frequency of Late Payments - capturing count of payments that are 7 or more months late
solutions$LATE_PAYMENT_FREQUENCY7 <- 0

solutions$LATE_PAYMENT_FREQUENCY7 <- if_else(solutions$PAY_1 >= 7,solutions$LATE_PAYMENT_FREQUENCY7+1,solutions$LATE_PAYMENT_FREQUENCY7)
solutions$LATE_PAYMENT_FREQUENCY7 <- if_else(solutions$PAY_2 >= 7,solutions$LATE_PAYMENT_FREQUENCY7+1,solutions$LATE_PAYMENT_FREQUENCY7)
solutions$LATE_PAYMENT_FREQUENCY7 <- if_else(solutions$PAY_3 >= 7,solutions$LATE_PAYMENT_FREQUENCY7+1,solutions$LATE_PAYMENT_FREQUENCY7)
solutions$LATE_PAYMENT_FREQUENCY7 <- if_else(solutions$PAY_4 >= 7,solutions$LATE_PAYMENT_FREQUENCY7+1,solutions$LATE_PAYMENT_FREQUENCY7)
solutions$LATE_PAYMENT_FREQUENCY7 <- if_else(solutions$PAY_5 >= 7,solutions$LATE_PAYMENT_FREQUENCY7+1,solutions$LATE_PAYMENT_FREQUENCY7)
solutions$LATE_PAYMENT_FREQUENCY7 <- if_else(solutions$PAY_6 >= 7,solutions$LATE_PAYMENT_FREQUENCY7+1,solutions$LATE_PAYMENT_FREQUENCY7)

#29d Frequency of Late Payments - capturing count of payments that are 1 or more months late
solutions$LATE_PAYMENT_FREQUENCY1 <- 0

solutions$LATE_PAYMENT_FREQUENCY1 <- if_else(solutions$PAY_1 >= 1,solutions$LATE_PAYMENT_FREQUENCY1+1,solutions$LATE_PAYMENT_FREQUENCY1)
solutions$LATE_PAYMENT_FREQUENCY1 <- if_else(solutions$PAY_2 >= 1,solutions$LATE_PAYMENT_FREQUENCY1+1,solutions$LATE_PAYMENT_FREQUENCY1)
solutions$LATE_PAYMENT_FREQUENCY1 <- if_else(solutions$PAY_3 >= 1,solutions$LATE_PAYMENT_FREQUENCY1+1,solutions$LATE_PAYMENT_FREQUENCY1)
solutions$LATE_PAYMENT_FREQUENCY1 <- if_else(solutions$PAY_4 >= 1,solutions$LATE_PAYMENT_FREQUENCY1+1,solutions$LATE_PAYMENT_FREQUENCY1)
solutions$LATE_PAYMENT_FREQUENCY1 <- if_else(solutions$PAY_5 >= 1,solutions$LATE_PAYMENT_FREQUENCY1+1,solutions$LATE_PAYMENT_FREQUENCY1)
solutions$LATE_PAYMENT_FREQUENCY1 <- if_else(solutions$PAY_6 >= 1,solutions$LATE_PAYMENT_FREQUENCY1+1,solutions$LATE_PAYMENT_FREQUENCY1)

#30 Average Months Delayed - run #29d (late payment frequency of 1 or more months) before running this code
#convert PAY_x variables to numeric, create FE variable, convert PAY_x back to factor
solutions$PAY_1 <- as.numeric(solutions$PAY_1)
solutions$PAY_2 <- as.numeric(solutions$PAY_2)
solutions$PAY_3 <- as.numeric(solutions$PAY_3)
solutions$PAY_4 <- as.numeric(solutions$PAY_4)
solutions$PAY_5 <- as.numeric(solutions$PAY_5)
solutions$PAY_6 <- as.numeric(solutions$PAY_6)

i=1
solutions$AVERAGE_MONTHS_DELAYED <- 0

for (i in 1:nrow(solutions)) {
  solutions$AVERAGE_MONTHS_DELAYED[i] <- if_else(solutions$PAY_1[i] >= 1,solutions$PAY_1[i],solutions$AVERAGE_MONTHS_DELAYED[i])
  solutions$AVERAGE_MONTHS_DELAYED[i] <- if_else(solutions$PAY_2[i] >= 1,solutions$PAY_2[i]+solutions$AVERAGE_MONTHS_DELAYED[i],solutions$AVERAGE_MONTHS_DELAYED[i])
  solutions$AVERAGE_MONTHS_DELAYED[i] <- if_else(solutions$PAY_3[i] >= 1,solutions$PAY_3[i]+solutions$AVERAGE_MONTHS_DELAYED[i],solutions$AVERAGE_MONTHS_DELAYED[i])
  solutions$AVERAGE_MONTHS_DELAYED[i] <- if_else(solutions$PAY_4[i] >= 1,solutions$PAY_4[i]+solutions$AVERAGE_MONTHS_DELAYED[i],solutions$AVERAGE_MONTHS_DELAYED[i])
  solutions$AVERAGE_MONTHS_DELAYED[i] <- if_else(solutions$PAY_5[i] >= 1,solutions$PAY_5[i]+solutions$AVERAGE_MONTHS_DELAYED[i],solutions$AVERAGE_MONTHS_DELAYED[i])
  solutions$AVERAGE_MONTHS_DELAYED[i] <- if_else(solutions$PAY_6[i] >= 1,solutions$PAY_6[i]+solutions$AVERAGE_MONTHS_DELAYED[i],solutions$AVERAGE_MONTHS_DELAYED[i])
  
  solutions$AVERAGE_MONTHS_DELAYED[i] <- if_else(solutions$LATE_PAYMENT_FREQUENCY1[i] > 0, solutions$AVERAGE_MONTHS_DELAYED[i]/solutions$LATE_PAYMENT_FREQUENCY1[i], 0)
}

#31 Dummy: Average months delayed 1 SD away - you need FE variable #30 to use code for this variable
#creating 5 variables, 1 for each Bill-Pay pair, convert to factor
solutions$AVERAGE_MONTHS_DELAYED_1_SD_AWAY <- 0

solutions$AVERAGE_MONTHS_DELAYED_1_SD_AWAY <- if_else(solutions$AVERAGE_MONTHS_DELAYED >= mean(solutions$AVERAGE_MONTHS_DELAYED)+sqrt(var(solutions$AVERAGE_MONTHS_DELAYED)), 1, solutions$AVERAGE_MONTHS_DELAYED_1_SD_AWAY)
solutions$AVERAGE_MONTHS_DELAYED_1_SD_AWAY <- if_else(solutions$AVERAGE_MONTHS_DELAYED <= mean(solutions$AVERAGE_MONTHS_DELAYED)-sqrt(var(solutions$AVERAGE_MONTHS_DELAYED)), 1, solutions$AVERAGE_MONTHS_DELAYED_1_SD_AWAY)

solutions$AVERAGE_MONTHS_DELAYED_1_SD_AWAY <- as.factor(solutions$AVERAGE_MONTHS_DELAYED_1_SD_AWAY)

#32 Month on month percentage change in Bill Amount
#creating 5 new variables
#BILL_PERCENTAGE_CHANGE1 = (BILL_AMT1-BILL_AMT2)/BILL_AMT2
#same logic applies for months 2-3, 3-4, 4-5, 5-6 pairs
#if BILL_AMT2 = 0 but BILL_AMT1 > 0, then change will be captured as 100%
solutions$BILL_PERCENTAGE_CHANGE1 <- if_else(solutions$BILL_AMT2 != 0, (solutions$BILL_AMT1-solutions$BILL_AMT2)/solutions$BILL_AMT2, 1)
solutions$BILL_PERCENTAGE_CHANGE2 <- if_else(solutions$BILL_AMT3 != 0, (solutions$BILL_AMT2-solutions$BILL_AMT3)/solutions$BILL_AMT3, 1)
solutions$BILL_PERCENTAGE_CHANGE3 <- if_else(solutions$BILL_AMT4 != 0, (solutions$BILL_AMT3-solutions$BILL_AMT4)/solutions$BILL_AMT4, 1)
solutions$BILL_PERCENTAGE_CHANGE4 <- if_else(solutions$BILL_AMT5 != 0, (solutions$BILL_AMT4-solutions$BILL_AMT5)/solutions$BILL_AMT5, 1)
solutions$BILL_PERCENTAGE_CHANGE5 <- if_else(solutions$BILL_AMT6 != 0, (solutions$BILL_AMT5-solutions$BILL_AMT6)/solutions$BILL_AMT6, 1)

#33 Average Bill Amount as a % of Credit Limit (LIMIT_BAL field in table)
solutions$BILL_AMT1_PERCENTAGE <- solutions$BILL_AMT1/solutions$LIMIT_BAL
solutions$BILL_AMT2_PERCENTAGE <- solutions$BILL_AMT2/solutions$LIMIT_BAL
solutions$BILL_AMT3_PERCENTAGE <- solutions$BILL_AMT3/solutions$LIMIT_BAL
solutions$BILL_AMT4_PERCENTAGE <- solutions$BILL_AMT4/solutions$LIMIT_BAL
solutions$BILL_AMT5_PERCENTAGE <- solutions$BILL_AMT5/solutions$LIMIT_BAL
solutions$BILL_AMT6_PERCENTAGE <- solutions$BILL_AMT6/solutions$LIMIT_BAL

#34 Average Unpaid Amount as a % of Credit Limit (Avg unpaid amount is FE #5 - run that code first to be able to use this code)
solutions$PAY_DIFFERENCE_AMT1_PERCENTAGE <- solutions$PAY_DIFFERENCE_AMT1/solutions$LIMIT_BAL
solutions$PAY_DIFFERENCE_AMT2_PERCENTAGE <- solutions$PAY_DIFFERENCE_AMT2/solutions$LIMIT_BAL
solutions$PAY_DIFFERENCE_AMT3_PERCENTAGE <- solutions$PAY_DIFFERENCE_AMT3/solutions$LIMIT_BAL
solutions$PAY_DIFFERENCE_AMT4_PERCENTAGE <- solutions$PAY_DIFFERENCE_AMT4/solutions$LIMIT_BAL
solutions$PAY_DIFFERENCE_AMT5_PERCENTAGE <- solutions$PAY_DIFFERENCE_AMT5/solutions$LIMIT_BAL

# solutions <- rename(solutions, default_0 = default.payment.next.month)
# #Shiv START
#42

solutions$MONTHLY_SPEND1 <- solutions$BILL_AMT1 - (solutions$BILL_AMT2 - solutions$PAY_AMT1)
solutions$MONTHLY_SPEND2 <- solutions$BILL_AMT2 - (solutions$BILL_AMT3 - solutions$PAY_AMT2)
solutions$MONTHLY_SPEND3 <- solutions$BILL_AMT3 - (solutions$BILL_AMT4 - solutions$PAY_AMT3)
solutions$MONTHLY_SPEND4 <- solutions$BILL_AMT4 - (solutions$BILL_AMT5 - solutions$PAY_AMT4)
solutions$MONTHLY_SPEND5 <- solutions$BILL_AMT5 - (solutions$BILL_AMT6 - solutions$PAY_AMT5)

#43-#44
solutions$MAX_MONTHLY_SPEND <- max(solutions$MONTHLY_SPEND1,solutions$MONTHLY_SPEND2,solutions$MONTHLY_SPEND3,solutions$MONTHLY_SPEND4,solutions$MONTHLY_SPEND5)
solutions$MIN_MONTHLY_SPEND <- min(solutions$MONTHLY_SPEND1,solutions$MONTHLY_SPEND2,solutions$MONTHLY_SPEND3,solutions$MONTHLY_SPEND4,solutions$MONTHLY_SPEND5)


#47 - #48
solutions$MAX_PAY_DIFFERENCE_AMT_PERCENTAGE <- max(solutions$PAY_DIFFERENCE_AMT1_PERCENTAGE,solutions$PAY_DIFFERENCE_AMT2_PERCENTAGE, solutions$PAY_DIFFERENCE_AMT3_PERCENTAG, solutions$PAY_DIFFERENCE_AMT4_PERCENTAG, solutions$PAY_DIFFERENCE_AMT5_PERCENTAGE  )
solutions$MIN_PAY_DIFFERENCE_AMT_PERCENTAGE <- min(solutions$PAY_DIFFERENCE_AMT1_PERCENTAGE,solutions$PAY_DIFFERENCE_AMT2_PERCENTAGE, solutions$PAY_DIFFERENCE_AMT3_PERCENTAG, solutions$PAY_DIFFERENCE_AMT4_PERCENTAG, solutions$PAY_DIFFERENCE_AMT5_PERCENTAGE  )

#52
solutions$CUST_MATURITY1 <-  solutions$LIMIT_BAL - solutions$MONTHLY_SPEND1
solutions$CUST_MATURITY2 <-  solutions$LIMIT_BAL - solutions$MONTHLY_SPEND2
solutions$CUST_MATURITY3 <-  solutions$LIMIT_BAL - solutions$MONTHLY_SPEND3
solutions$CUST_MATURITY4 <-  solutions$LIMIT_BAL - solutions$MONTHLY_SPEND4
solutions$CUST_MATURITY5 <-  solutions$LIMIT_BAL - solutions$MONTHLY_SPEND5

#53 - #54
solutions$MAX_CUST_MATURITY <-  max(solutions$CUST_MATURITY1, solutions$CUST_MATURITY2, solutions$CUST_MATURITY3, solutions$CUST_MATURITY4, solutions$CUST_MATURITY5)
solutions$MIN_CUST_MATURITY <-  min(solutions$CUST_MATURITY1, solutions$CUST_MATURITY2, solutions$CUST_MATURITY3, solutions$CUST_MATURITY4, solutions$CUST_MATURITY5)

#57
solutions$CUST_2MATURITY1 <-  solutions$MONTHLY_SPEND1 / solutions$LIMIT_BAL
solutions$CUST_2MATURITY2 <-  solutions$MONTHLY_SPEND2 / solutions$LIMIT_BAL
solutions$CUST_2MATURITY3 <-  solutions$MONTHLY_SPEND3 / solutions$LIMIT_BAL
solutions$CUST_2MATURITY4 <-  solutions$MONTHLY_SPEND4 / solutions$LIMIT_BAL
solutions$CUST_2MATURITY5 <-  solutions$MONTHLY_SPEND5 / solutions$LIMIT_BAL

#58 - #59
solutions$MAX_CUST_2MATURITY <- max(solutions$CUST_2MATURITY1,solutions$CUST_2MATURITY2, solutions$CUST_2MATURITY3, solutions$CUST_2MATURITY4, solutions$CUST_2MATURITY5 )
solutions$MIN_CUST_2MATURITY <- min(solutions$CUST_2MATURITY1,solutions$CUST_2MATURITY2, solutions$CUST_2MATURITY3, solutions$CUST_2MATURITY4, solutions$CUST_2MATURITY5 )

#62 - #63
solutions$MAX_PAY_AMT <-  max(solutions$PAY_AMT1, solutions$PAY_AMT2, solutions$PAY_AMT3, solutions$PAY_AMT4, solutions$PAY_AMT5, solutions$PAY_AMT6 )
solutions$MAX_PAY_AMT <-  min(solutions$PAY_AMT1, solutions$PAY_AMT2, solutions$PAY_AMT3, solutions$PAY_AMT4, solutions$PAY_AMT5, solutions$PAY_AMT6 )

#66 - #67
solutions$MAX_BILL_AMT <- max(solutions$BILL_AMT1, solutions$BILL_AMT2, solutions$BILL_AMT3, solutions$BILL_AMT4, solutions$BILL_AMT5, solutions$BILL_AMT6 )
solutions$MIN_BILL_AMT <- min(solutions$BILL_AMT1, solutions$BILL_AMT2, solutions$BILL_AMT3, solutions$BILL_AMT4, solutions$BILL_AMT5, solutions$BILL_AMT6 )

#71 - #72
solutions$MAX_BILL_AMT1_PERCENTAGE <- max(solutions$BILL_AMT1_PERCENTAGE, solutions$BILL_AMT2_PERCENTAGE, solutions$BILL_AMT3_PERCENTAGE, solutions$BILL_AMT4_PERCENTAGE, solutions$BILL_AMT5_PERCENTAGE, solutions$BILL_AMT6_PERCENTAGE)
solutions$MIN_BILL_AMT1_PERCENTAGE <- min(solutions$BILL_AMT1_PERCENTAGE, solutions$BILL_AMT2_PERCENTAGE, solutions$BILL_AMT3_PERCENTAGE, solutions$BILL_AMT4_PERCENTAGE, solutions$BILL_AMT5_PERCENTAGE, solutions$BILL_AMT6_PERCENTAGE)

#75
solutions$AVAILABLE_CREDIT1 <- 1 - solutions$BILL_AMT1_PERCENTAGE
solutions$AVAILABLE_CREDIT2 <- 1 - solutions$BILL_AMT2_PERCENTAGE
solutions$AVAILABLE_CREDIT3 <- 1 - solutions$BILL_AMT3_PERCENTAGE
solutions$AVAILABLE_CREDIT4 <- 1 - solutions$BILL_AMT4_PERCENTAGE
solutions$AVAILABLE_CREDIT5 <- 1 - solutions$BILL_AMT5_PERCENTAGE
solutions$AVAILABLE_CREDIT6 <- 1 - solutions$BILL_AMT6_PERCENTAGE

#76 -#77
solutions$MAX_AVAILABLE_CREDIT <- max(solutions$AVAILABLE_CREDIT1, solutions$AVAILABLE_CREDIT2, solutions$AVAILABLE_CREDIT3, solutions$AVAILABLE_CREDIT4, solutions$AVAILABLE_CREDIT5, solutions$AVAILABLE_CREDIT6)
solutions$MIN_AVAILABLE_CREDIT <- min(solutions$AVAILABLE_CREDIT1, solutions$AVAILABLE_CREDIT2, solutions$AVAILABLE_CREDIT3, solutions$AVAILABLE_CREDIT4, solutions$AVAILABLE_CREDIT5, solutions$AVAILABLE_CREDIT6)

#80
solutions$PAYMNT_HIST1 <- if_else(solutions$BILL_AMT2 == 0, 1, solutions$PAY_AMT1 / solutions$BILL_AMT2 )
solutions$PAYMNT_HIST2 <- if_else(solutions$BILL_AMT3 == 0, 1, solutions$PAY_AMT2 / solutions$BILL_AMT3 )
solutions$PAYMNT_HIST3 <- if_else(solutions$BILL_AMT4 == 0, 1, solutions$PAY_AMT3 / solutions$BILL_AMT4 )
solutions$PAYMNT_HIST4 <- if_else(solutions$BILL_AMT5 == 0, 1, solutions$PAY_AMT4 / solutions$BILL_AMT5 )
solutions$PAYMNT_HIST5 <- if_else(solutions$BILL_AMT6 == 0, 1, solutions$PAY_AMT5 / solutions$BILL_AMT6 )

#81 - #82
solutions$MAX_PAYMNT_HIST <- max(solutions$PAYMNT_HIST1, solutions$PAYMNT_HIST2, solutions$PAYMNT_HIST3, solutions$PAYMNT_HIST4, solutions$PAYMNT_HIST5)
solutions$MIN_PAYMNT_HIST <- min(solutions$PAYMNT_HIST1, solutions$PAYMNT_HIST2, solutions$PAYMNT_HIST3, solutions$PAYMNT_HIST4, solutions$PAYMNT_HIST5)

##LEVEL FACTORS
levels(solutions$PAY_1T) <- levels(credit$PAY_1T)
levels(solutions$PAY_2T) <- levels(credit$PAY_2T)
levels(solutions$PAY_3T) <- levels(credit$PAY_3T)
levels(solutions$PAY_4T) <- levels(credit$PAY_4T)
levels(solutions$PAY_5T) <- levels(credit$PAY_5T)
levels(solutions$PAY_6T) <- levels(credit$PAY_6T)
levels(solutions$CREDIT_LIMIT_BUCKET) <- levels(credit$CREDIT_LIMIT_BUCKET)

