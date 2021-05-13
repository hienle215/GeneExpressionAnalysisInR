library(limma)
library(edgeR)
load("data.Rdata")
View(d)
View(targets)

#Creat design matrix
celltype <- factor(targets$CellType)
design <- model.matrix(~celltype)
View(design)
#filter out low-count genes
isexpr <- rowSums(cpm(d) > 10) >= 2
d <- d[isexpr,]

# perform voom normalization
y <- voom(d,design)

#fit linear model and assess differential expression
fit <- eBayes(lmFit(y,design)) # compare with global varients in a particular gene case
topTable(fit)
View(topTable(fit))