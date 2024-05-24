setwd("/Users/leixiaoyu/desktop/Rdata/16S rRNA")
getwd()#显示当前工作路径
install.packages("ggplot2")
install.packages("ggpubr")
library(ggplot2)
library(ggpubr)
df <- read.csv("alpha多样性画图result.csv")#输入整理过后的数据
df$group = factor(df$group,levels=c("CK","EP","MCFAs"))
color=c("#BEBAB7","#76A7CF","#BF7DA1")#颜色变量,按自己喜好修改
#确定排序，也可以自己修改，改后坐标轴就按照这个顺序排列
list = list(c("CK","MCFAs"),c("CK","EP"),c("MCFAs","EP"))
p1 <- ggplot(df, aes(group, value, color=group ,fill=group))+#df是数据框，group是X轴上的分组变量，value是Y轴上的值，color和fill参数都使用了group变量来确定颜色。这将创建一个根据分组变量进行着色的柱状图或其他适当的图形。
  geom_jitter(width=.15)+ # 将散点图的宽度设置为0.15,缩窄一些
  geom_boxplot(width=.4, alpha=.2)+ # 将箱线图的宽度设置为0.4，缩窄了一些，不透明度设置为0.2，填充颜色变得很浅
  scale_colour_manual(values=color)+
  scale_fill_manual(values=color)+
  theme_bw()+
  theme(panel.grid = element_blank())+
  theme(text = element_text(family = "serif"))+#字体为新罗马
  stat_compare_means(comparisons = list, method = "wilcox.test", #像这种非配对的非正态分布的数据，可以用非参数检验方法，这里选的是非参的其中一种，叫秩和检验
                     size=2, # 将p值字体改小一些
                     label = "p.signif")+ 
  facet_wrap(.~index, # 同时做几个图，这几个图分别对应数据转换前的第1列到第4列
             nrow=2, ncol=2, # 图排成两行两列
             scale="free") # 横纵坐标不要统一成一样的，各个图根据自己情况来自动设置横纵坐标的范围
 
 
  #箱线图绘制函数
p1
