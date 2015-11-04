#Developed by Pablo Vicente-Munuera
library(igraph)

#Purpose: Create from an adjacency matrix within a file, various clusters
# (with differents methods) and save them into separte files with the
# proper information

#Reading the adjacency matrix
adjacencyData <- read.csv(header = F, file = "data/YeastS-main.txt", sep = "\t")

#Now we want the names of the proteins
vertices <- read.csv2(header = F, file = "docs/proteins.csv")
#We only want the V2 column
vertices <- vertices$V2
#Put the names into the data as rows and columns names
row.names(adjacencyData) <- vertices
colnames(adjacencyData) <- vertices

#The PPIs with all the information(function)
ppisIndex <- read.csv2(file = "data/PPIsInfo/PPIsFunctionIndex.csv")
#We want it as a matrix
adjacencyMatrix <- as.matrix(adjacencyData)
#And don't want protein interactions with themselves
diag(adjacencyMatrix) <- 0

#Get the graph from the adjacencymatrix
graphM <- graph.adjacency(adjacencyMatrix, mode = "undirected")
#write.graph(graphM, file = "data/graphPPIs.csv", format = 'ncol')

#Information of the ppis
functionIndex <- read.csv2(header = F, file = "data/PPIsInfo/graphPPIsIndex.csv")
#Conversion from factors to numbers
functionIndex[,3] <- as.numeric(levels(functionIndex[,3])[functionIndex[,3]])

#Just in case if you want to use a weights vectors and change it in some way
#functionIndex[,3] <- functionIndex[,3]

#Commented here we found the different methods of clustering available in R (used here)
cluster <- cluster_spinglass(graphM, spins = 25, weights = functionIndex[,3])
#cluster <- cluster_edge_betweenness(graphM)
#cluster <- cluster_walktrap(graphM, steps = 12, weights = functionIndex[,3])
#cluster <- cluster_fast_greedy(graphM, weights = functionIndex[,3])
#cluster <- cluster_walktrap(graphM, steps= 10, weights = functionIndex[,3])
#cluster <- cluster_leading_eigen(graphM, weights = functionIndex[,3])
#cluster <- cluster_infomap(graphM, e.weights = functionIndex[,3])
#cluster <- cluster_louvain(graphM, weights = functionIndex[,3])

#The clusters
#cluster$membership

cont <- 0
lengthsOfEdges <- c()
#Go through every cluster and if it has more than 0 PPIs then it is printed in an csv file
for (i in 1:length(cluster)){
  #Generation of the graph from the cluster information on the adjacency matrix
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
