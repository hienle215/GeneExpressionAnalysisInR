getwd()
setwd("C:\\Users\\leh\\Documents\\GeneExpressionAnalysisInR")
d = read.csv("AnalysisEffectsOfDrugInTumorWithPBS.csv")
d
dCt_treated = d$treated_p27 - d$treated_GAPDH
dCt_untreated = d$untreated_p27 - d$untreated_GAPDH
mean_dCt_untreated = mean(dCt_untreated)
dCt_negative_control = d$negativeControl_p27 - d$negativeControl_GAPDH
dCt_positive_control = d$positiveControl_p27 - d$positiveControl_GAPDH

ddCt_treated = dCt_treated - mean_dCt_untreated
ddCt_untreated = dCt_untreated - mean_dCt_untreated
ddCt_negative_control = dCt_negative_control - mean_dCt_untreated
ddCt_positive_control = dCt_positive_control - mean_dCt_untreated

treated_p27_expression = 2**-ddCt_treated
untreated_p27_expression = 2**-ddCt_untreated
negative_control_expression = 2**-ddCt_negative_control
positive_control_expression = 2**-ddCt_positive_control


img_obj = barplot(c(mean(treated_p27_expression),
                    mean(untreated_p27_expression),
                    mean(negative_control_expression),
                    mean(positive_control_expression)), 
                  names.arg = c("Trt", "Unt", "NC", "PC"),
                  main = "p27 expression")

error.bar = function(x, y, upper, lower=upper, length=0.1,...) { 
  if(length(x) != length(y) | length(y) !=length(lower) | length(lower) != length(upper)) stop("vectors must be same length")     
  arrows(x,y+upper, x, y-lower, angle=90, code=3, length=length, ...)}

error.bar(img_obj,
          c(mean(treated_p27_expression), mean(untreated_p27_expression), mean(negative_control_expression), mean(positive_control_expression)),
          c(sd(treated_p27_expression), sd(untreated_p27_expression), sd(negative_control_expression), sd(positive_control_expression)))

expression = c(treated_p27_expression,
               untreated_p27_expression,
               negative_control_expression,
               positive_control_expression)
expression

condition = c(rep("treated_p27_expression", 10),
              rep("untreated_p27_expression", 10),
              rep("negative_control_expression", 10),
              rep("positive_control_expresson", 10))
data = as.data.frame(t(rbind(condition, expression)))
data$expression = as.numeric(data$expression)

summary(aov(formula = expression ~ condition, data = data))

see=pairwise.t.test(x=expression, g=condition, p.adjust.method = "fdr")
see$p.value
