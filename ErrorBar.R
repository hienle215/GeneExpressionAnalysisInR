
error.bar = function(x, y, upper, lower=upper, length=0.1,...) { 
  if(length(x) != length(y) | length(y) !=length(lower) | length(lower) != length(upper)) stop("vectors must be same length")     
  arrows(x,y+upper, x, y-lower, angle=90, code=3, length=length, ...)}
example_expression = c(1, 2, 3)
example_variability = c(0.5, 0.5, 0.5)
conditions = c('a', 'b', 'c')
bar = barplot(height = example_expression, names.arg = conditions)
error.bar(x=bar, y=example_expression, upper=example_variability)