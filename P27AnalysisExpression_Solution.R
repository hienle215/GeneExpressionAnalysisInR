getwd()
setwd ("C:\\Users\\leh\\Documents\\GeneExpressionAnalysisInR")
d = read.csv("P27Expression.csv")

d

dCt_treated = d$treated_p27 - d$treated_GAPDH
dCt_treated
dCt_untreated = d$untreated_p27 - d$untreated_GAPDH
dCt_untreated

mean_dCt_untreated = mean(dCt_untreated)
mean_dCt_untreated

ddCt_treated = dCt_treated - mean_dCt_untreated
ddCt_treated
ddCt_untreated = dCt_untreated - mean_dCt_untreated
ddCt_treated

treated_p27_expression = 2**-ddCt_treated
treated_p27_expression
untreated_p27_expression = 2**-ddCt_untreated
untreated_p27_expression

t.test(treated_p27_expression, untreated_p27_expression)

img_obj = barplot( c(mean(untreated_p27_expression),
                     mean(treated_p27_expression)),
                   name.arg = c("Cnt", "Trt"),
                   main = "Expression of p27")

error.bar = function(x, y, upper, lower=upper, length=0.1,...) { 
  if(length(x) != length(y) | length(y) !=length(lower) | length(lower) != length(upper)) stop("vectors must be same length")     
  arrows(x,y+upper, x, y-lower, angle=90, code=3, length=length, ...)}

error.bar(img_obj,
          c(mean(untreated_p27_expression), mean(treated_p27_expression)),
          c(sd(untreated_p27_expression), sd(treated_p27_expression)))
