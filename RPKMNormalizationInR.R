
row.names(e) <- e$X
e$X <- NULL
#Need to use R (Not RStudio)

source("http://bioconductor.org/biocLite.R")
biocLite("baySeq")

library(baySeq)
load("mobData.RData")
head(mobData)

row.names(e) <- e$X

library(edgeR)

e_new <- rpk(e,a$Length)

head(e)
head(a) # check to make sure that the order of length and order of genes should be suitable

identical(row.names(e),character(a$GeneID))
