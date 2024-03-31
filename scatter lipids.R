library(readr)
library(ggpubr)
library(dplyr)
library(pheatmap)
lipid <- read_csv("metabolites.csv")


lipid$class %>% as.factor() %>% levels()

lipids = c("TG", "SM",
           "LPC","CAR")


lipid %>% 
  filter(class == lipids) %>%
  mutate(logFC = FC %>% log2()) %>%
  mutate(logP = utest_p %>% log10()) %>%
  mutate(neglogP = logP*-1) %>%
  ggscatter(.,
            x = "class",
            y = "logFC",
            shape = 21,
            fill = "class",
            size = "neglogP",
            palette = "npg",
            label = "name",
            label.select = list(top.up = 3, top.down = 3),
            repel = T) +
  # coord_flip() +
  theme (legend.position = "right") +
  geom_hline(yintercept = c(-1,0,1), linetype = "dashed",
             color = "grey") +
  labs(x = "Lipids Ontology",
       y = "Log2(Fold change)")

ggsave("scatter lipids.pdf", width = 10, height = 6)






metabolites = c("Organoheterocyclic compounds",
                "Organic oxygen compounds",
                "Lipids and lipid-like molecules",
                "Nucleosides, nucleotides, and analogues")

lipid %>% 
  filter(class == metabolites) %>%
  mutate(logFC = FC %>% log2()) %>%
  mutate(logP = utest_p %>% log10()) %>%
  mutate(neglogP = logP*-1) %>%
  ggscatter(.,
            x = "class",
            y = "logFC",
            shape = 21,
            fill = "class",
            size = "neglogP",
            palette = "npg",
            label = "name",
            label.select = list(top.up = 3, top.down = 3),
            repel = T) +
  # coord_flip() +
  theme (legend.position = "right") +
  geom_hline(yintercept = c(-1,0,1), linetype = "dashed",
             color = "grey") +
  labs(x = "Lipids Ontology",
       y = "Log2(Fold change)")

ggsave("scatter metabolites.pdf", width = 10, height = 6)
