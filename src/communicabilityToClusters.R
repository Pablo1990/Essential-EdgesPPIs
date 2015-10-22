#Developed by Pablo Vicente-Munuera

library('igraph')
source('~/Documents/Dropbox/MScBioinformatics/Thesis/Project/Essential-EdgesPPIs/src/lib/translationMatlabCode.R', echo=TRUE)

for (i in 1:126) {
  clusterPPI1 <- read.csv2(header = F, file = paste0("data/cluster/EBCEssentialPPIs", i, ".csv"))
  edges <- clusterPPI1[,1:2]
  
  graphCluster <- graph.edgelist(as.matrix(edges), directed = FALSE)
  
  adjacencyCluster <- as.matrix(get.adjacency(graphCluster))
  
  cACluster <- communicabilityAngle(adjacencyCluster)
  
  cDCluster <- communicabilityDistance(adjacencyCluster)
  
  cECluster <- communicabilityEdges(adjacencyCluster)
  
  clusterPPI1 <- cbind(clusterPPI1, cACluster[as.matrix(edges)], cDCluster[as.matrix(edges)], cECluster[as.matrix(edges)])
  
  write.csv2(clusterPPI1, header = F, file = paste0("data/cluster/EBCEssentialCommPPIs",i, ".csv"))
}
