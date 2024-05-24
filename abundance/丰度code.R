setwd("/Users/leixiaoyu/desktop/Rdata/16S rRNA")
getwd()#显示当前工作路径
library(ggplot2)   # 用于绘图

ra <- as.matrix(read.table("丰度p.txt", row.names =1, 
                           header = F, sep = "\t")) # 读入相对丰度数据并转换为矩阵方便后续数据整理
group <- c("CK", "MCFA","NG")
code <- c("CK_1","CK_2","CK_3","CK_4","CK_5","CK_6","MCFA_1","MCFA_2","MCFA_3","MCFA_4","MCFA_5","MCFA_6","NG_1","NG_2","NG_3","NG_4","NG_5","NG_6")#NG is EP
dat <- data.frame(code = rep(code,each = 4),
                  taxa = rep(rownames(ra), 18),
                  cultivar = rep(group, each = 24),
                  abundance = as.vector(ra)) # 按照ggplot绘图所需格式进行数据整理
dat$taxa <- factor(dat$taxa,levels =c("others","Weissella","Lactobacillus","Enterococcus"))
dat$code <- factor(dat$code, levels = c("CK_1","CK_2","CK_3","CK_4","CK_5","CK_6","MCFA_1","MCFA_2","MCFA_3","MCFA_4","MCFA_5","MCFA_6","NG_1","NG_2","NG_3","NG_4","NG_5","NG_6"))
dat$cultivar <- factor(dat$cultivar,levels = c("CK", "MCFA","NG"))
name<-c("CK_1","CK_2","CK_3","CK_4","CK_5","CK_6","MCFA_1","MCFA_2","MCFA_3","MCFA_4","MCFA_5","MCFA_6","NG_1","NG_2","NG_3","NG_4","NG_5","NG_6")
#绘制柱状图
ggplot(dat, aes(x = code, y = abundance, fill = taxa))+
  scale_fill_manual(values = c("#A9B8C6","#fcdaeb","#ffd7ae","#c9b1d5"))+
  geom_bar(stat = "identity", width = 0.9)+
  facet_grid(.~cultivar, scales = "free_x", space = "free_x")+ # 按照cultivar这个变量进行分块
  theme_bw()+
  xlab("")+ # 去掉x轴的标题
  theme(text = element_text(family = "serif"))+
  ylab("Relative abundance")+ # 设置y轴的标签
  theme(panel.grid.major.x = element_blank(),
        axis.text.x = element_text(size = rel(1), angle = (-30)),
        axis.text.y = element_text(size=rel(1)),
        legend.text = element_text(size = rel(1)))
