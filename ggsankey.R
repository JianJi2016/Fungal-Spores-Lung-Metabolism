#相关R包下载与载入：
# devtools::install_github("davidsjoberg/ggsankey")
library(tidyverse)
library(ggsankey)
library(ggplot2)
# install.packages("cols4all")
library(cols4all)
#本地测试数据读入：
dt <- read.csv('sankeydt.csv')
head(dt)


df <- dt %>%
  make_long(metabolites, pathNames)
head(df)


df$node <- factor(df$node,levels = c(dt$pathNames %>% unique()%>% rev(),
                                     dt$metabolites %>% unique() %>% rev()))



#自定义配色：
c4a_gui()
mycol <- c4a('rainbow_wh_rd',52)
mycol2 <- sample(mycol,length(mycol)) #随机打乱配色顺序
#图表美化：
p1 <- ggplot(df, aes(x = x,
                     next_x = next_x,
                     node = node,
                     next_node = next_node,
                     fill = node,
                     label = node)) +
  scale_fill_manual(values = mycol) + #更改配色
  geom_sankey(flow.alpha = 0.5, #条带不透明度
              smooth = 8, #条带弯曲度
              
              width = 0.12) + #节点宽度
  geom_sankey_text(size = 3.2,
                   color = "black") +
  theme_void() +
  theme(legend.position = 'none')
p1





library(tidyverse)
library(ggsankey)
library(ggplot2)
library(cols4all)
library(cowplot)
#本地数据载入：
##富集气泡图数据：
kegg <- read.csv('enrichdt.csv')
head(kegg)

sankey <- read.csv('sankeydt.csv')
head(sankey)


#如果我们按照以往常规的绘制方法：
#指定绘图顺序（转换为因子）：
kegg$pathNames <- factor(kegg$pathNames,levels = rev(kegg$pathNames))
#基础富集气泡图：

kegg2 <- kegg[10:1,] #先调转数据框方向
kegg2 <- kegg2 %>%
  mutate(ymax = cumsum(count)) %>% #ymax为Width列的累加和
  mutate(ymin = ymax -count) %>%
  mutate(label = (ymin + ymax)/2) #取xmin和xmax的中心位置作为标签位置
head(kegg2)


#自定义主题与配色修改：
mytheme <- theme(axis.title = element_text(size = 13),
                 axis.text = element_text(size = 11),
                 axis.text.y = element_blank(),
                 axis.ticks.y = element_blank(),
                 legend.title = element_text(size = 13),
                 legend.text = element_text(size = 11))
p3 <- ggplot() +
  geom_point(data = kegg2,
             aes(x = -log10(Pvalue),
                 y = label,
                 size = count,
                 color = Hit.Ratio)) +
  scale_size_continuous(range=c(2,8)) + #调整气泡大小范围(默认尺寸部分过小)
  scale_y_continuous(expand = c(0,0.1),limits = c(0,42)) +
  scale_x_continuous(limits = c(0.57,9)) +
  scale_colour_distiller(palette = "Reds", direction = 1) + #更改配色
  labs(x = "-log10(Pvalue)",
       y = "") +
  theme_bw() +
  mytheme
p3

#通过调整页边距在桑基图右侧先留出空白：
p5 <- p1 + theme(plot.margin = unit(c(0,5,0,0),units="cm"))
p5

ggdraw() + draw_plot(p5) + draw_plot(p3, scale = 0.5, x = 0.62, y=-0.21, width=0.48, height=1.37)

ggsave("metaboPathway.pdf", width = 10,height = 8)
