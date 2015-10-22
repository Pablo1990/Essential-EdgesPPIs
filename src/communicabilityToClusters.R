#Developed by Pablo Vicente-Munuera

clusterPPI1 <- read.csv2(header = F, file = "data/cluster/EBCEssentialPPIs1.csv")
edges <- clusterPPI1[,1:2]

graphCluster <- graph.edgelist(as.matrix(edges), directed = FALSE)
