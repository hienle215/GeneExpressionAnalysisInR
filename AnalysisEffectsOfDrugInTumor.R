getwd()
setwd("C:\\Users\\leh\\Documents\\GeneExpressionAnalysisInR")
d = read.csv("AnalysisEffectsOfDrugInTumor.csv")
d

dCt_treated = d$treated_p27 -d$treated_GAPDH
dCt_untreated = d$untreated_p27 - d$untreated_GAPDH
mean_dCt_untreated = mean(dCt_untreated)
dCt_negativeControl = d$negativeControl_p27 - d$negativeControl_GAPDH

ddCt_treated = dCt_treated - mean_dCt_untreated
ddCt_untreated = dCt_untreated -mean_dCt_untreated
ddCt_negativeControl = dCt_negativeControl - mean_dCt_untreated

treated_p27_expression = 2**-ddCt_treated
untreated_p27_expression = 2**-ddCt_untreated
negativeControl_p27Expression = 2**-ddCt_negativeControl

expression = c(treated_p27_expression,
               untreated_p27_expression,
               negativeControl_p27Expression)
expression

condition = c(rep("treated_p27_expression", 10), 
              rep("untreated_p27_expression", 10),
              rep("negativeControl_p27Expression", 10))
condition

data = as.data.frame(t(rbind(condition, expression)))
class(data)
class(data$expression)
data$expression = as.numeric(data$expression)
data$expression

summary(aov(formula = expression ~ condition, data = data))
summary
class(data$condition)

img = barplot(c(mean(untreated_p27_expression),
                mean(negativeControl_p27Expression),
                mean(treated_p27_expression)),
              name.arg = c("UT", "NC", "Trt"),
              main = "p27 expression")
error.bar = function(x, y, upper, lower=upper, length=0.1,...) { 
  if(length(x) != length(y) | length(y) !=length(lower) | length(lower) != length(upper)) stop("vectors must be same length")     
  arrows(x,y+upper, x, y-lower, angle=90, code=3, length=length, ...)}

error.bar(img,
          c(mean(untreated_p27_expression), mean(negativeControl_p27Expression), mean(treated_p27_expression)),
          c(sd(untreated_p27_expression), sd(negativeControl_p27Expression), sd(treated_p27_expression)))

see = pairwise.t.test(x = expression, g = condition, p.adjust.method = "fdr")
see
see$p.value
see$fdr
