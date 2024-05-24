setwd("/Users/leixiaoyu/desktop/Rdata/FFJ GO")
##设置工作环境
getwd()
#相关性热图
#install.packages("vcd")
#install.packages("Rmisc")
#install.packages("ggcorrplot")
library(ggplot2)
library(lattice)
library(plyr)
library(Rmisc)
library(psych)
library(corrplot)
library(ggcorrplot)
library(RColorBrewer)
library(grDevices)
library(permute)
library(vegan)
library(grid)
library(vcd)
library(ggrepel)
data<-file.choose()#choose "EP expression correlate"
data<-read.csv(data,row.names = 1,header = T)
#dim(data)
data<-as.matrix(data)
data=data.frame(scale(data))
head(data)

data<-cor(data,method="pearson")
round(data,2)
tpm.cor<-data
tpm.p<-round(cor_pmat(data,method="pearson"),3)
#tpm.p<-round(cor_pmat(data,method="spearman"),3)
#tpm.p<-round(cor_pmat(data,method="kendall"),3)

p<-corrplot(corr = tpm.cor,p.mat = tpm.p,
            order = "hclust",hclust.method = "ward.D",
            insig = "label_sig",sig.level = c(.05,0.01),
            tl.col = "black",pch.cex = 0.8)
corrRect.hclust(tpm.cor, k = 3,method = 'ward.D')
