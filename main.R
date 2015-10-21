#Developed by Pablo Vicente-Munuera

library('igraph')

#Examples:
#adjacencyM <- matrix( c(0, 1, 0, 1, 1, 0, 0, 0, 0, 0, 0, 1, 1, 0, 1, 0), nrow=4, ncol = 4, byrow = T)

#communicabilityAngle(adjacencyM)

#communicabilityDistance(adjacencyM)

adjacencyData <- read.csv(header = F, file = "data/YeastS-main.txt", sep = "\t")

vertices <- read.csv2(header = F, file = "docs/proteins.csv")

vertices <- vertices$V2

row.names(adjacencyData) <- vertices
colnames(adjacencyData) <- vertices

adjacencyMatrix <- as.matrix(adjacencyData)

diag(adjacencyMatrix) <- 0

graphM <- graph.adjacency(adjacencyMatrix, mode = "undirected")

cluster <- cluster_edge_betweenness(graphM)

cluster$membership

#clusterEdgeBetw <- list()

for (i in 1:length(cluster)){
  clusterGraph <- graph.adjacency(adjacencyMatrix[cluster$membership==i, cluster$membership==i], mode = "undirected")
  #write.csv2(edge_betweenness(clusterGraph), file = paste0("data/cluster/EBC", i, '.csv'))
  write.graph(clusterGraph, file = paste0("data/cluster/cluster", i, '.csv'), format = 'ncol')
  eCluster <- read.csv2(file = paste0("data/cluster/cluster", i, '.csv'), header = F)
  eCluster[, 2] <- edge_betweenness(clusterGraph) 
  write.csv2(eCluster, file = paste0("data/cluster/EBC", i, '.csv'))
}
