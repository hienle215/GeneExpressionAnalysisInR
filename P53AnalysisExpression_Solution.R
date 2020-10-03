setwd()
d = read.csv("P53Expression.csv")
class(d)
View(d)
head(d)
d
dCt_control = d$untreated_p53 - d$untreated_GAPDH
dCt_treatment = d$treated_p53 - d$treated_GAPDH

dCt_control_avg = mean(dCt_control)

ddCt_control = dCt_control - dCt_control_avg
ddCt_treatment = dCt_treatment - dCt_control_avg

expression_control = 2^ddCt_control
expression_treatment = 2^ddCt_treatment

expression_control_avg = mean(expression_control)
expression_treatment_avg = mean(expression_treatment)

expression_control_sd = sd(expression_control)
expression_treatment_sd = sd(expression_treatment)

plot_data = c(expression_control_avg, expression_treatment_avg)
plot_data_var = c(expression_control_sd, expression_treatment_sd)

img_obj = barplot(plot_data,
                  names.arg = c("Cnt", "Trt"),
                  main = "Expression of p53")

error.bar <- function(x, y, upper, lower=upper, length=0.1,...){
  if(length(x) != length(y) | length(y) !=length(lower) | length(lower) != length(upper))
    stop("vectors must be same length")
  arrows(x,y+upper, x, y-lower, angle=90, code=3, length=length, ...)
}

error.bar(x = img_obj,
          y = plot_data, 
          upper = plot_data_var)

t.test(x = expression_control, expression_treatment)
