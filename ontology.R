library(readr)
library(ggpubr)
library(dplyr)
library(pheatmap)

ontology <- read.csv("ontology.csv")


ontology %>%
  group_by(Platform, Ontology) %>%
  summarise(n = n()) %>%
  arrange(desc(Platform)) %>%
  write.csv("ontologyProcess.csv")

ontologyP <- read.csv("ontologyProcess.csv")

ggdonutchart(ontologyP %>%
               filter(Platform == "Metabolomics"),
             "n",
             fill = "Ontology",
             label = "Ontology") +
  theme(legend.position="none") 

ggsave("Metabolomics ontology.pdf")


ggdonutchart(ontologyP %>%
             filter(Platform == "Lipidomics"),
             "n",
             fill = "Ontology",
             label = "Ontology") +
  theme(legend.position="none") 


ggsave("Lipidomics ontology.pdf")

