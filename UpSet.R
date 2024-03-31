install.packages("UpSetR")

library(UpSetR)
library(dplyr)


upset <- read.csv("UpSetR.csv")

listInput <- list(
  Con_vs_F = upset %>% select(nameCONF) %>% pull(), 
  Con_vs_AbxF = upset %>% select(nameCONAF) %>% pull(), 
  F_vs_AbxF = upset %>% select(nameFAb) %>% pull())


Pheat <- upset(fromList(listInput), order.by = "freq")


upset %>%
  select(1:2) %>%
  group_by(OntologyCONF) %>%
  summarise(n = n()) %>%
  ggdonutchart(.,"n",
               fill = "OntologyCONF",
               label = "OntologyCONF") +
  theme(legend.position="none") 

upset %>%
  select(3:4) %>%
  group_by(OntologyCONAF) %>%
  summarise(n = n()) %>%
  slice(., -1) %>%
  ggdonutchart(.,"n",
               fill = "OntologyCONAF",
               label = "OntologyCONAF") +
  theme(legend.position="none") 

upset %>%
  select(5:6) %>%
  group_by(OntologyFAb) %>%
  summarise(n = n())%>%
  slice(., -1) %>%
  ggdonutchart(.,"n",
               fill = "OntologyFAb",
               label = "OntologyFAb") +
  theme(legend.position="none") 


?left_join

full_join(
full_join(upset %>%
            select(1:2) %>%
            group_by(OntologyCONF) %>%
            summarise(n = n()) %>%
            rename(Ontology = "OntologyCONF",
                   CONF = "n"),
          upset %>%
            select(3:4) %>%
            group_by(OntologyCONAF) %>%
            summarise(n = n()) %>%
            slice(., -1) %>%
            rename(Ontology = "OntologyCONAF",
                   CONAF = "n")),
upset %>%
  select(5:6) %>%
  group_by(OntologyFAb) %>%
  summarise(n = n())%>%
  slice(., -1) %>%
  rename(Ontology = "OntologyFAb",
         FAb = "n")
) %>%

 gather(., key = "variable", value = "value", CONF:FAb) %>%

 ggbarplot(., "variable", "value",
                fill = "Ontology", 
                label = F, 
                lab.col = "white", lab.pos = "in")




full_join(upset %>%
              select(1:2) %>%
              group_by(OntologyCONF) %>%
              summarise(n = n()) %>%
              rename(Ontology = "OntologyCONF",
                     CONF = "n"),
            upset %>%
              select(3:4) %>%
              group_by(OntologyCONAF) %>%
              summarise(n = n()) %>%
              slice(., -1) %>%
              rename(Ontology = "OntologyCONAF",
                     CONAF = "n")) %>%
  gather(., key = "variable", value = "value", CONF:CONAF) %>%
  ggbarplot(., "variable", "value",
            fill = "Ontology", 
            label = F, 
            lab.col = "white", lab.pos = "in")

