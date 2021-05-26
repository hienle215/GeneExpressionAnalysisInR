### Differential expression: impact of filtering and normalization
### Assume differentially expressed gene is defined as having an adjusted P values of less than 0.05
### identify differentially expressed genes based on RPKM-normalized expression and filtering out genes that had less than 10 CPM in at least 2 samples
### identify differentially expressed genes based VOOM-normalized expression and filtering out genes that had less than 10 CPM in at least 2 samples
## identify differentially expressed genes based on RPKM-normalized expression and filtering out genes that had less than 10 CPM in 4 samples

library(limma)
library(edgeR)

data <- read.csv("raw_counts.csv", row.names = "X")
gene_anno <- read.csv("gene_lengths.csv")
View(data)
View(gene_anno)

labs <- factor (c("x", "X", "Y", "Y"))
design <- model.matrix(~labs)

e_rpkm <-rpkm(data, gene_anno$Length) 
e_voom <- voom(data, design)
design <- model.matrix(~labs)

isexp <- !(rowSums(cpm(data) < 10) >= 2)

e_rpkm_filtered <- e_rpkm[isexp,]
e_voom_filtered <- e_voom$E[isexp,]

diff_lst <- topTable(eBayes(lmFit(e_rpkm_filtered, design)),
                     number = nrow(e_rpkm_filtered))
sum(diff:lst$adj.P.Val < 0.05)

diff_lst <- topTable(eBayes(lmFit(e_voom_filtered, design)),
                     number = nrow(e_voom_filterd))
sum(diff_lst$adj.P.Val < 0.05)

isexp <- !(rowSums(cpm(e) < 10) == 4)
e_rpkm_filter <- e_rpkm[isexp,]

diff_lst <- topTable(eBays(lmFit(e_rpkm_filter, design)), number = nrow(e_rpkm_filterd))
sum(diff_lst$adj.P.Val < 0.05)

