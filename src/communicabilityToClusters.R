#Developed by Pablo Vicente-Munuera

library('igraph')
source('~/Documents/Dropbox/MScBioinformatics/Thesis/Project/Essential-EdgesPPIs/src/lib/translationMatlabCode.R', echo=TRUE)

clusterPPI1 <- read.csv2(header = F, file = "data/cluster/EBCEssentialPPIs1.csv")
edges <- clusterPPI1[,1:2]

graphCluster <- graph.edgelist(as.matrix(edges), directed = FALSE)

adjacencyCluster <- as.matrix(get.adjacency(graphCluster))

cACluster <- communicabilityAngle(adjacencyCluster)

cDCluster <- communicabilityDistance(adjacencyCluster)

cECluster <- communicabilityEdges(adjacencyCluster)