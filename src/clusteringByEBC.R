#Developed by Pablo Vicente-Munuera
library(igraph)

adjacencyData <- read.csv(header = F, file = "data/YeastS-main.txt", sep = "\t")

vertices <- read.csv2(header = F, file = "docs/proteins.csv")

vertices <- vertices$V2

row.names(adjacencyData) <- vertices
colnames(adjacencyData) <- vertices

ppisIndex <- read.csv2(file = "data/PPIsFunctionIndex.csv")

adjacencyMatrix <- as.matrix(adjacencyData)

diag(adjacencyMatrix) <- 0

graphM <- graph.adjacency(adjacencyMatrix, mode = "undirected")

#write.graph(graphM, file = "data/graphPPIs.csv", format = 'ncol')

functionIndex <- read.csv2(header = F, file = "data/graphPPIsIndex.csv")

functionIndex[,3] <- as.numeric(levels(functionIndex[,3])[functionIndex[,3]])

functionIndex[,3] <- functionIndex[,3]

cluster <- cluster_walktrap(graphM)


#cluster <- cluster_edge_betweenness(graphM)

cluster$membership

#clusterEdgeBetw <- list()

for (i in 1:length(cluster)){
  clusterGraph <- graph.adjacency(adjacencyMatrix[cluster$membership==i, cluster$membership==i], mode = "undirected")
  #write.csv2(edge_betweenness(clusterGraph), file = paste0("data/cluster/EBC", i, '.csv'))
  write.graph(clusterGraph, file = paste0("data/cluster/clusterWalktrap", i, '.csv'), format = 'ncol')
  eCluster <- read.csv2(file = paste0("data/cluster/clusterWalktrap", i, '.csv'), header = F)
  eCluster[, 2] <- edge_betweenness(clusterGraph) 
  write.csv2(eCluster, file = paste0("data/cluster/EBCWalktrap", i, '.csv'))
}