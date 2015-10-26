#Developed by Pablo Vicente-Munuera

library('igraph')
source('~/Documents/Dropbox/MScBioinformatics/Thesis/Project/Essential-EdgesPPIs/src/lib/translationMatlabCode.R', echo=TRUE)

name <- "EBCSpinglassWeighted"


for (i in 1:25) {
  clusterPPI1 <- read.csv2(file = paste0("data/cluster/", name, i, ".csv"))
  edges <- as.character(levels(clusterPPI1[,2])[clusterPPI1[,2]])
  edges <- strsplit(edges, ' ')
  edges <- data.frame(matrix(unlist(edges), nrow=length(edges), byrow=T),stringsAsFactors=FALSE)
  
  graphCluster <- graph.edgelist(as.matrix(edges), directed = FALSE)
  
  adjacencyCluster <- as.matrix(get.adjacency(graphCluster))
  
  cACluster <- communicabilityAngle(adjacencyCluster)
  
  cDCluster <- communicabilityDistance(adjacencyCluster)
  
  cECluster <- communicabilityEdges(adjacencyCluster)
  
  clusterPPI1 <- cbind(clusterPPI1, cACluster[as.matrix(edges)], cDCluster[as.matrix(edges)], cECluster[as.matrix(edges)])
  
  write.csv2(clusterPPI1, file = paste0("data/cluster/", name, "CommPPIs",i, ".csv"))
}
