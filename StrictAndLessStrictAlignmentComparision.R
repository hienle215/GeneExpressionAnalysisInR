###Rsubread alignment: stringent and less stringent alignment criteria
library(Rsubread)
# Build a genome index for reference chromosome 1 sequence
#### ####
buildindex(basename="chr1",reference="C:\\Users\\leh\\Documents\\GeneExpressionAnalysis_DATA\\hg19_chr1.fa.txt")

#### ####
# Align reads to the indexed genome 
#### ####
align(index="chr1",
      readfile1="C:\\Users\\leh\\Documents\\GeneExpressionAnalysis_DATA\\1.fastq.txt",
      input_format="gzFASTQ",
      output_format="BAM",
      output_file="sequencing_sample.bam",
      unique=TRUE)

align(index="chr1",
      readfile1="C:\\Users\\leh\\Documents\\GeneExpressionAnalysis_DATA\\1.fastq.txt",
      input_format="gzFASTQ",
      output_format="BAM",
      output_file="1_less_strigent.bam",
      unique=F,
      nBestLocations=5,
      maxMismatches=5)

proMapTab1 = propmapped(c("sequencing_sample.bam","1_less_strigent.bam"))

counts <- featureCounts(files=c("sequencing_sample.bam","1_less_strigent.bam"), annot.inbuilt="hg19")

View(proMapTab1)
View(counts$counts)
keep = counts$counts[,1] > 0 & counts$counts[,2]
counts$counts[keep,1] == counts$counts[keep,2]
sum(counts$counts[keep,1] == counts$counts[keep,2])
sum(counts$counts[keep,1] == counts$counts[keep,2])/sum(keep)
round(sum(counts$counts[keep,1] == counts$counts[keep,2])/sum(keep))*100
round(sum(counts$counts[keep,1] < counts$counts[keep,2])/sum(keep))*100
