dt <- read.csv('sankeydt.csv')

library(dplyr)
dt %>%
  filter(.,pathNames == c("Galactose metabolism")) %>%
  select(1) %>% pull() -> Galactose


dt %>%
  filter(.,pathNames == c("Aminoacyl-tRNA biosynthesis")) %>%
  select(1) %>% pull() -> Aminoacyl



dt %>%
  filter(.,pathNames == c("Purine metabolism")) %>%
  select(1) %>% pull() -> Purine


dt %>%
   select(1) %>% pull() %>% unique()-> Name


data <- read.csv("GCTOF 30 data.csv", check.names = F)

data %>% select("Metabolite name", "Groups", Name) 



