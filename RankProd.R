if (!requireNamespace("BiocManager", quietly = TRUE))
  install.packages("BiocManager")

BiocManager::install("RankProd")
library(RankProd)

d <- read.csv("RankProd_analysis_class.csv")
View(d)

nam <- d$gene_name
d$gene_name = NULL

cl <- c(rep(0,3), rep(1,3))
cl
res <- RankProducts(data = d, logged = F, cl = cl, rand = 123)

top_table <- topGene(res, cutoff = 0.1, method = "pfp", gene.names = nam, logged = F)

View(top_table$Table1)
View(top_table$Table2)
