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

for (i in 1:length(ppisIndex[,1])){
  adjacencyMatrix[ppisIndex[i,1], ppisIndex[i,2]] <- as.integer(ppisIndex[i,3]) + 1
}

graphM <- graph.adjacency(adjacencyMatrix, mode = "undirected")

write.graph(graphM, file = "data/graphPPIs.csv", format = 'ncol')

cluster <- cluster_label_prop(graphM, weights = functionIndex[,3])

functionIndex <- read.csv2(header = F, file = "data/graphPPIsIndex.csv")

#cluster <- cluster_edge_betweenness(graphM)

cluster$membership

#clusterEdgeBetw <- list()

for (i in 1:length(cluster)){
  clusterGraph <- graph.adjacency(adjacencyMatrix[cluster$membership==i, cluster$membership==i], mode = "undirected")
  #write.csv2(edge_betweenness(clusterGraph), file = paste0("data/cluster/EBC", i, '.csv'))
  write.graph(clusterGraph, file = paste0("data/cluster/clusterLabelPropFunctions", i, '.csv'), format = 'ncol')
  eCluster <- read.csv2(file = paste0("data/cluster/clusterLabelPropFunctions", i, '.csv'), header = F)
  eCluster[, 2] <- edge_betweenness(clusterGraph) 
  write.csv2(eCluster, file = paste0("data/cluster/EBCLabelPropFunctions", i, '.csv'))
}