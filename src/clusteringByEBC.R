#Developed by Pablo Vicente-Munuera
library(igraph)

adjacencyData <- read.csv(header = F, file = "data/YeastS-main.txt", sep = "\t")

vertices <- read.csv2(header = F, file = "docs/proteins.csv")

vertices <- vertices$V2

row.names(adjacencyData) <- vertices
colnames(adjacencyData) <- vertices

ppisIndex <- read.csv2(file = "data/PPIsInfo/PPIsFunctionIndex.csv")

adjacencyMatrix <- as.matrix(adjacencyData)

diag(adjacencyMatrix) <- 0

graphM <- graph.adjacency(adjacencyMatrix, mode = "undirected")

#write.graph(graphM, file = "data/graphPPIs.csv", format = 'ncol')

functionIndex <- read.csv2(header = F, file = "data/PPIsInfo/graphPPIsIndex.csv")

functionIndex[,3] <- as.numeric(levels(functionIndex[,3])[functionIndex[,3]])

#functionIndex[,3] <- functionIndex[,3]

#cluster <- cluster_edge_betweenness(graphM)

#cluster <- cluster_walktrap(graphM, steps = 12, weights = functionIndex[,3])

cluster <- cluster_spinglass(graphM, spins = 25, weights = functionIndex[,3])

#cluster <- cluster_fast_greedy(graphM, weights = functionIndex[,3])

#cluster <- cluster_walktrap(graphM, steps= 10, weights = functionIndex[,3])

#cluster <- cluster_leading_eigen(graphM, weights = functionIndex[,3])

#cluster <- cluster_infomap(graphM, e.weights = functionIndex[,3])

#cluster <- cluster_louvain(graphM, weights = functionIndex[,3])

#cluster$membership

#clusterEdgeBetw <- list()
cont <- 0
lengthsOfEdges <- c()
for (i in 1:length(cluster)){
  clusterGraph <- graph.adjacency(adjacencyMatrix[cluster$membership==i, cluster$membership==i], mode = "undirected")
  #write.csv2(edge_betweenness(clusterGraph), file = paste0("data/cluster/EBC", i, '.csv'))
  lengthsOfEdges <- c(lengthsOfEdges, (length(E(clusterGraph))))
  if (length(E(clusterGraph)) > 0){
    cont <- cont + 1
    write.graph(clusterGraph, file = paste0("data/clustersPPIs/clusterEBC", cont, '.csv'), format = 'ncol')
    eCluster <- read.csv2(file = paste0("data/clustersPPIs/clusterEBC", cont, '.csv'), header = F)
    eCluster[, 2] <- edge_betweenness(clusterGraph) 
    write.csv2(eCluster, file = paste0("data/clustersPPIs/Spinglass25spinsWeighted", cont, '.csv'))
  }
}
print (max(lengthsOfEdges))
print (min(lengthsOfEdges))

# i <- 1
# newMatrix <- adjacencyMatrix[cluster$membership %in% c(34,64), cluster$membership %in% c(34,64)]
# clusterGraph <- graph.adjacency(newMatrix, mode = "undirected")
# #write.csv2(edge_betweenness(clusterGraph), file = paste0("data/cluster/EBC", i, '.csv'))
# write.graph(clusterGraph, file = paste0("data/cluster/cluster13and18SpinglassWeighted", i, '.csv'), format = 'ncol')
# eCluster <- read.csv2(file = paste0("data/cluster/cluster13and18SpinglassWeighted", i, '.csv'), header = F)
# eCluster[, 2] <- edge_betweenness(clusterGraph) 
# write.csv2(eCluster, file = paste0("data/cluster/EBC13and18SpinglassWeighted", i, '.csv'))
# 
# 
