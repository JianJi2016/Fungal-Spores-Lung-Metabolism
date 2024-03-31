
library(readr)
library(ggpubr)
library(dplyr)
library(pheatmap)


biomarkers <- read_csv("metabolites.csv")
allmetabolites <- read.csv("metabolites2.csv", check.names = F)

"CAR"
"LPC"
"TG"
"SM"

allmetabolites %>% select("Metabolite name", "Groups", biomarkers %>% 
                            filter(class == c("SM")) %>%
                            select(name) %>%
                            pull()) -> PCheatmap

colinfo <- PCheatmap[,1:2]
matrixs <- PCheatmap[,-(1:2)]
rownames(matrixs) = colinfo[,1]

Pheat <- pheatmap(t(matrixs), 
                  scale = "row",
                  color = colorRampPalette(c("navy", "white", "firebrick3"))(50),
                  border=FALSE,
                  border_color = "black",
                  treeheight_row = 30, 
                  treeheight_col = 30,
                  cellwidth = 15, 
                  cellheight = 12, 
                  fontsize = 8,
                  clustering_method = "ward.D",
                  cluster_cols = F,
                  cluster_rows = T)

ggplotify::as.ggplot(Pheat)
ggsave("SM_Heatmap.pdf", width = 8,height = 6)
