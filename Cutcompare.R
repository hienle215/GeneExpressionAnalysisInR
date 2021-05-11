## cutcompare
# using to compare the difference between 2 RNA sequences
#do cuffcompare first and export the file for reading

cufftcompare$ cuffcompare -i pred_path.txt -r ref.gtf # compare 2 genomes
cuffcompare$ ls

setwd("Desktopä/cuffcompare/")
list.files()

d <- read.table("cutcmp.tracking", stringsAsFactors = FALSE)
view(d)

sum(d$V4=="=")/nrow(d)

#out of compare transcript
unique(d$V4)
sum(d$V4=="j")/nro(d)

#How many genes novel
# some results will not have gene names for them. Therefore, we should identify the novel genes or genes without names tagged
s <- regexpr(pattern=".*?! \\",text=d$V3)
len <- attr(s,"match.length")
len <- len-1

unique(s)
d=d[s==1,]
len=len[s==1]
genes <- substr(d$V3, start=rep(1, length(d$V3)), stop=len)

d <- cbind(d,genes)
length(unique(genes[d$V4=="j"]))
