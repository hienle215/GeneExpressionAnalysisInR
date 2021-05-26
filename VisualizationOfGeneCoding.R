####Learn to visualize gene expression data in R
Visualizing gene expression data in R

In this written lecture, you'll learn how to visualise your gene expression data in R as well as I'll point you to resources that can help you make the plots. Notice that your ability to plot gene expression depends on your capability to format the data in a form appropriate as required by the functions. Here you'll learn the general patterns with some examples.

Barplot

There are two ways you can plot a bar plot. You can either use the built-in barplot function or rely on ggplot's package ggplot function. The main arguments for barplot function are height and names.arg which both take in vectors of bar heights and corresponding labels respectively. On the other hand the use of ggplot is a little more complicated but the display of the plot is aesthetically more pleasing. In general the syntax of ggplot is cantered around (i) a dataset, (ii) a coordinate system, and (iii) geoms, i.e. the visual marks that represent the data. For example, with data ...

# Create data
data = data.frame(
  condition=c("A","B","C","D","E") ,  
  gene_expression_value=c(1,2,3,4,5))    
... we can plot a ggplot barplot with ...
# Barplot
ggplot(data, aes(x=condition, y=gene_expression_value)) + geom_bar(stat = "identity")
Notice how this piece of code works. The first argument of ggplot function is the dataset, while the second is a function aes specifying the coordinate system. Outside the ggplot function itself we then type '+' followed by the type of plot we want which in this case is geom_bar. Don't forget to load the package first!

Adding error bars to barplot

Sometimes we may want to plot error bars around the barplot to represent the variability in expression. Here I'm going to show you how you can do it if you've plotted your barplot with the built-in method. First, make sure you compute an additional vector of variability values having length equal to the vector that was used to plot the bar heights. Then define function error.bar :

error.bar = function(x, y, upper, lower=upper, length=0.1,...) { 
        if(length(x) != length(y) | length(y) !=length(lower) | length(lower) != length(upper)) stop("vectors must be same length")     
        arrows(x,y+upper, x, y-lower, angle=90, code=3, length=length, ...)}
You can then plot error bars as follows ...

example_expression = c(1,2,3)
example_variability = c(0.5,0.5,0.5)
conditions = c('a','b','c')
bar = barplot(height=example_expression,names.arg=conditions)
error.bar(x=bar,y=example_expression,upper=example_variability)
Notice how we create the bar variable and feed it into error.bar function x argument. We have to specify the height of the bars again under y argument and error under upper argument.

Box and whisker plot

Box and whisker plot can be created using the boxplot() function. I recommend that you work with this function by passing in a list or a data frame with numeric vectors as its components. This way you get a plot for each vector. If you input just a single vector, then you get a single box and whisker plot. Remember when we talked about the extend to which the whisker reaches? This can be controlled by range argument, which is a number that multiplies the inter-quartile range. Setting it to zero causes the whiskers to extend to the minimum and maximum of the data. 

Volcano plot

A great bioconductor package for making volcano plots is EnhancedVolcano. More information about it, including installation, can be found here:

https://www.bioconductor.org/packages/release/bioc/vignettes/EnhancedVolcano/inst/doc/EnhancedVolcano.html

Time-series plot

This can be achieved as simply as with plot(x, y, type="l"). In this case  x and y are vectors for labels and y-axis values respectively and should be of the same length. The l for type makes sure that dots are connected with line. You can set the colour of the line with col argument. You can add time-series plots on top of it with points and lines functions which work similarly to plot function - however make sure that the range of values you're plotting on top of your base plot is the same as the range of the base plot itself. Otherwise you won't see the added plot! Useful arguments to keep in mind are pch which can be used to specify the shape of the points (e.g. pch="*") and lty which specifies the kind of line drawn (e.g. lty=2 for a line with breaks).

Heatmap

A great bioconductor package for drawing heatmaps is heatplus. More information about it, including installation and use cases can be found in the main package page:

https://www.bioconductor.org/packages/release/bioc/html/Heatplus.html

Claveland's plot

The exact code to draw Claveland's plot depends on what exactly we want to do. How many pieces of information do we want to convey? For example, from the outcome of GSEA analysis we may want to convey 3 pieces of information: the value of enrichment score, the significance of enrichment from the colour of the plot, and the number of genes in the leading edge from the size of the dot. Or we might  just want to show enrichment score and number of genes. All in all, in R we would use ggplot for Claveland's and you should bear in mind methods such as geom_point and geom_line.
