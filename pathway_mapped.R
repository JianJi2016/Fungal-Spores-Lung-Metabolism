Pathway <- read.csv("pathway cover.csv")
library(ggpubr)
library(dplyr)
library(ggsci)
library(scales)
color3 = pal_npg()(10)
show_col(color3)
ggbarplot(Pathway[1:10,] %>%
           arrange(., mapped) ,
          x = "Pathway",
          y = "mapped",
          fill = "LogP") +
  scale_y_continuous(expand = c(0,0)) +
  coord_flip() +
  labs(x = "",
       y = "Mapped metabolite number",
       fill = "Metabolite coverage") +
  scale_fill_gradient(low = "#4DBBD5FF", high = "#E64B35FF") 

ggsave("pathway_mapped.pdf", width = 5, height = 5)

