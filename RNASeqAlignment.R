#Differential gene expression  analysis course - RNAseq - alignment

#packages
if (!requireNamespace("BiocManager", quietly = TRUE))
  install.packages("BiocManager")
BiocManager::install("Rsubread")
library(Rsubread)
buildindex(basename="chr1",reference="hg19_chr1.fa")
