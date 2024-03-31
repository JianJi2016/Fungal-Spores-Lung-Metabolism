dotplot <- read.csv("dotplot.csv")

library(dplyr)
library(ggpubr)

dotplot %>%
  group_by(class) %>%
  summarize_all(mean, na.rm = TRUE) %>%
  ggscatter(.,
            x = "foldchange",
            y = "pvalue",
            shape = 21,
            
            fill = "foldchange",
            size = "pvalue",
            label = "class") +
  scale_fill_gradient(low = "white",
                       high = "#E64934") +
  scale_size_continuous(range = c(2,10))

ggsave("map.pdf", width = 8, height = 6)



dotplot %>%
  group_by(class) %>%
  summarize_all(mean, na.rm = TRUE) %>%
  print(n = 25)
