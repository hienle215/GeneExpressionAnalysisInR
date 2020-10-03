steam<- read.csv(file = "P53Expression.csv", header = T, sep = ",")

head(steam)
deltaP53_treated = c(steam$treated_p53-steam$treated_GAPDH)
deltaP53_treated
deltaP53_Untreated = c(steam$untreated_p53-steam$untreated_GAPDH)
deltaP53_Untreated 
mean(deltaP53_Untreated)
ddCt_test = deltaP53_treated - mean(deltaP53_Untreated)
ddCt_test
ddCt_control = deltaP53_Untreated - mean(deltaP53_Untreated)
ddCt_control
Expression_test = 2**ddCt_test
Expression_test
Expression_control = 2**ddCt_control
Expression_control
t.test(Expression_control, Expression_test)
mean(Expression_control)
mean(Expression_test)
Expresion <- c(mean(Expression_control), mean(Expression_test))
barplot(Expresion)
