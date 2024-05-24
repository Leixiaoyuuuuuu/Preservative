BiocManager::install("ComplexHeatmap")
install.packages("ComplexHeatmap")
library(ComplexHeatmap)
setwd("/Users/leixiaoyu/desktop/Rdata/FFJ")
getwd()
dev.new()
mat <- read.csv("data.csv",row.names = 1)
for (i in 1:nrow(mat)) mat[i, ] <- scale(log(unlist(mat[i, ]) + 1, 2))
gene_anno <- read.csv('Go description.csv', row.names = 1)
column_order <- as.matrix(rownames(gene_anno))
mat <- mat[match(column_order, rownames(mat)), ]
mat <- as.matrix(mat)

#读取样本分组和基因分组矩阵
sample_group <- as.matrix(read.csv('Group.csv', row.names = 1))
gene_anno <- as.matrix(read.csv('Go description.csv', row.names = 1))
column_order <- as.matrix(rownames(gene_anno))
mat <- mat[match(column_order, rownames(mat)), ]
#绘制根据基因类型和样本分组对行列进行排序后的聚类热图
Heatmap(
  mat, name = 'gene_express',
  col = colorRampPalette(c('#240EFF', '#B491F9', '#ECEAEF', '#FFA48C', '#FF1A09'))(100),  #基因表达的渐变色设置
  cluster_rows = F, cluster_columns = F,  #行列根据基因表达聚类
  row_names_gp = gpar(fontsize = 4), column_names_gp = gpar(fontsize = 5), 
  row_split = gene_anno, column_split = sample_group, #行（基因名）列（样本名）字体大小
  row_title_gp = gpar(fontsize = 2), column_title_gp = gpar(fontsize = 2), #行（基因类型）列（样本分组）字体大小
  
  #根据基因类型定义行的颜色
  right_annotation = HeatmapAnnotation(
    Class = gene_anno,  which = 'row', show_annotation_name = FALSE
  ),
  
  #根据样本分组定义列的颜色
  top_annotation = HeatmapAnnotation(
    Group = sample_group, which = 'column', show_annotation_name = FALSE, 
    col = list(Group = c('CK' = '#E0E0E0', 'EP' = '#D3D9E0', 'MCFA' = '#E0D7E0'))
  )
)

