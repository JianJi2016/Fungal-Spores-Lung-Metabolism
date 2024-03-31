
Biomark <- read.csv("unsaturate.csv", check.names = F)
Biomark %>% filter(Ontology == "TG") %>%
  ggscatter(.,
            x = "carbons",
            shape = 21,
            y = "Unsaturations",
            size = "logP",
            fill = "log2FoldChange") +
  scale_fill_gradient2(low = "#4DBBD5",
                         mid = "white",
                         high = "#E64934",
                         midpoint = 0) +
  scale_size(range = c(1, 10)) +
  scale_x_continuous(limits = c(36, 60),breaks = seq(from=36, to=60, by=1)) +
  scale_y_continuous(limits = c(0, 10),breaks = c(0:10)) +
  geom_hline(yintercept = c(0:10), linetype = "dashed",
             color = "grey", size=0.1) +
  geom_vline(xintercept = c(36:60), linetype = "dashed",
             color = "grey", size=0.1) +
  labs(x = "Number of carbons",
       y = "Number of unsaturations",
       size = "-log10P")
ggsave("TG carbon.pdf", width = 9, height = 5)



Biomark %>% filter(Ontology == "LPC") %>%
  ggscatter(.,
            x = "carbons",
            shape = 21,
            y = "Unsaturations",
            size = "logP",
            fill = "log2FoldChange") +
  scale_fill_gradient2(low = "#4DBBD5",
                       mid = "white",
                       high = "#E64934",
                       midpoint = 0) +
  scale_size(range = c(1, 10)) +
  scale_x_continuous(limits = c(13, 28),breaks = seq(from=12, to=28, by=2)) +
  scale_y_continuous(limits = c(0, 7),breaks = c(0:7)) +
  geom_hline(yintercept = c(0:11), linetype = "dashed",
             color = "grey", size=0.1) +
  geom_vline(xintercept = c(13:28), linetype = "dashed",
             color = "grey", size=0.1) +
  labs(x = "Carbons number",
       size = "-log10P")
ggsave("LPC carbon.pdf", width = 5, height = 4)



Biomark %>% filter(Ontology == "CAR") %>%
  ggscatter(.,
            x = "carbons",
            shape = 21,
            y = "Unsaturations",
            size = "logP",
            fill = "log2FoldChange") +
  scale_fill_gradient2(low = "#4DBBD5",
                       mid = "white",
                       high = "#E64934",
                       midpoint = 0) +
  scale_size(range = c(1, 10)) +
  scale_x_continuous(limits = c(6, 25),breaks = seq(from=6, to=25, by=2)) +
  scale_y_continuous(limits = c(0, 7),breaks = c(0:7)) +
  geom_hline(yintercept = c(0:11), linetype = "dashed",
             color = "grey", size=0.1) +
  geom_vline(xintercept = c(6:25), linetype = "dashed",
             color = "grey", size=0.1) +
  labs(x = "Carbons number",
       size = "-log10P")
ggsave("CAR carbon.pdf", width = 5, height = 4)




Biomark %>% filter(Ontology == "SM") %>%
  ggscatter(.,
            x = "carbons",
            shape = 21,
            y = "Unsaturations",
            size = "logP",
            fill = "log2FoldChange") +
  scale_fill_gradient2(low = "#4DBBD5",
                       mid = "white",
                       high = "#E64934",
                       midpoint = 0) +
  scale_size(range = c(1, 10)) +
  scale_x_continuous(limits = c(31,49),breaks = seq(from=31, to=49, by=2)) +
  scale_y_continuous(limits = c(0, 8),breaks = c(0:9)) +
  geom_hline(yintercept = c(0:11), linetype = "dashed",
             color = "grey", size=0.1) +
  geom_vline(xintercept = c(31:49), linetype = "dashed",
             color = "grey", size=0.1) +
  labs(x = "Carbons number",
       size = "-log10P")
ggsave("SM carbon.pdf", width = 5, height = 4)

