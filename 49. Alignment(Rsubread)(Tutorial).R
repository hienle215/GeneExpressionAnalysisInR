#### ####
# Differential gene expression analysis course - RNAseq - alignment
#### ####

#### ####
# Packages
# You should install 'Rsubread' package 
#### ####
#Install Rsubread
BiocManager::install("Rsubread")

library(Rsubread)
#Set work directory
 setwd("C:\\Users\\leh\\Documents\\GeneExpressionAnalysisInR")
#### ####
# Build a genome index for reference chromosome 1 sequence
#### ####
buildindex(basename="chr1",reference="C:\\Users\\leh\\Documents\\GeneExpressionAnalysis_DATA\\hg19_chr1.fa.txt")

#### ####
# Align reads to the indexed genome 
#### ####
align(index="chr1",
      readfile1="C:\\Users\\leh\\Documents\\GeneExpressionAnalysis_DATA\\sequencing_sample.fastq.txt",
      input_format="gzFASTQ",
      output_format="BAM",
      output_file="sequencing_sample.bam",
      unique=TRUE)

#### ####
# Calculate the proportion of mapped reads
#### ####
propmapped("sequencing_sample.bam")

#### ####
# Count numbers of reads mapped to built-in NCBI Refseq genes
#### ####
counts <- featureCounts(files="sequencing_sample.bam",
                        annot.inbuilt="hg19")

### Counts will show the results of 4 lists
 View(counts$counts)
 View(counts$annotation)
 View(counts$stat)
