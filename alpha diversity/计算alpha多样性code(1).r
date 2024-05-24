getwd()#显示当前工作路径
install.packages("vegan")#可以理解为r是一部手机，通过下载并启动安装包来实现各种功能
library(vegan) #加载安装包，第一次使用需要install.packages("vegan")
df <- read.csv("data.csv", row.names = 1)#输入文件
Shannon <- diversity(df, index = "shannon", MARGIN = 2, base = exp(1))
Simpson <- diversity(df, index = "simpson", MARGIN = 2, base =  exp(1))
Richness <- specnumber(df, MARGIN = 2)
index <- as.data.frame(cbind(Shannon, Simpson, Richness))#合并矩阵
tdf <- t(df)#转置表格
tdf<-ceiling(as.data.frame(t(df)))#转置后还要再转成数据框格式，非必要
#计算obs，chao，ace指数
obs_chao_ace <- t(estimateR(tdf))
obs_chao_ace <- obs_chao_ace[rownames(index),]#统一行名
#将obs，chao，ace指数与前面指数计算结果进行合并
index$Chao <- obs_chao_ace[,2]
index$Ace <- obs_chao_ace[,4]
index$obs <- obs_chao_ace[,1]
index$Pielou <- Shannon / log(Richness, 2)#计算pielou
index$Goods_coverage <- 1 - colSums(df ==1) / colSums(df)#计算覆盖度
sample <- c(row.names(index))
write.csv(cbind(sample,index),'diversity.csv')#输出文件
#出图
