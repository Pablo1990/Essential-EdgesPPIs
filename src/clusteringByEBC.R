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

functionIndex[,3] <- functionIndex[,3] + 1

cluster <- cluster_edge_betweenness(graphM, functionIndex[,3])


#cluster <- cluster_edge_betweenness(graphM)

cluster$membership

#clusterEdgeBetw <- list()

for (i in 1:length(cluster)){
  clusterGraph <- graph.adjacency(adjacencyMatrix[cluster$membership==i, cluster$membership==i], mode = "undirected")
  #write.csv2(edge_betweenness(clusterGraph), file = paste0("data/cluster/EBC", i, '.csv'))
  write.graph(clusterGraph, file = paste0("data/cluster/clusterEBCWeighted", i, '.csv'), format = 'ncol')
  eCluster <- read.csv2(file = paste0("data/cluster/clusterEBCWeighted", i, '.csv'), header = F)
  eCluster[, 2] <- edge_betweenness(clusterGraph) 
  write.csv2(eCluster, file = paste0("data/cluster/EBCWeighted", i, '.csv'))
}

i <- 1
newMatrix <- adjacencyMatrix[cluster$membership %in% c(34,64), cluster$membership %in% c(34,64)]
clusterGraph <- graph.adjacency(newMatrix, mode = "undirected")
#write.csv2(edge_betweenness(clusterGraph), file = paste0("data/cluster/EBC", i, '.csv'))
write.graph(clusterGraph, file = paste0("data/cluster/cluster13and18SpinglassWeighted", i, '.csv'), format = 'ncol')
eCluster <- read.csv2(file = paste0("data/cluster/cluster13and18SpinglassWeighted", i, '.csv'), header = F)
eCluster[, 2] <- edge_betweenness(clusterGraph) 
write.csv2(eCluster, file = paste0("data/cluster/EBC13and18SpinglassWeighted", i, '.csv'))


