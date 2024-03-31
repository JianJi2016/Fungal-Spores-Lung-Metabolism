library(readxl)
ChemRICH_results <- read_excel("ChemRICH_results.xlsx", 
                               sheet = "Compound_ChemRICH")

library(ggpubr)
library(dplyr)
library(ggrepel)

result <- ChemRICH_results %>% 
  group_by(ClusterLabel) %>%
  summarize(mean_value1 = mean(xlogp), 
            mean_value2 = median(logP),
            mean_value3 = mean(foldchange),
            n = n()) %>%
  arrange(desc(n)) %>%
  top_n(n = 30)




ggscatter(result,
          shape = 21,
          x = "mean_value1",
          y = "mean_value2",
          fill = "mean_value3",
          label = "ClusterLabel",
          size = "n") +
  scale_size(range = c(6, 20)) +
  scale_fill_gradient(low = "#4DBBD5FF", high = "#E64B35FF") +
  labs(x = "median XlogP of clusters",
       y = "-log10 (pvalue)") +
  # geom_vline(xintercept = c(log2(1/value), log2(value)), col = "grey", linetype = "longdash") +
  geom_hline(yintercept = -log10(0.05), col = "grey", linetype = "longdash") 

ggsave("chemrich.pdf",width = 10, height = 6)









result2 <- ChemRICH_results %>% 
  group_by(class) %>%
  summarize(mean_value1 = mean(xlogp), 
            mean_value2 = median(logP),
            mean_value3 = mean(foldchange %>% 
                                 log(., base = 2) %>%
                                 abs()),
            n = n()) %>%
  arrange(desc(n)) 

ggplot(data = result2,
       aes(x = mean_value1, 
           y = mean_value2, 
           fill = mean_value3,
           label= class)) + 
  geom_point(aes(size = n),shape = 21) + ggpubr::theme_pubr() +
  geom_text_repel() +
  
  scale_size(range = c(6, 20)) +
  scale_fill_gradient(low = "#4DBBD5FF", high = "#E64B35FF") +
  labs(x = "median XlogP of clusters",
       y = "-log10 (pvalue)") +
  geom_hline(yintercept = -log10(0.05), col = "black", linetype = "longdash") 



ggsave("chemrich2.pdf",width = 10, height = 6)
