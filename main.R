#Created by Pablo Vicente-Munuera
source('~/Documents/Dropbox/MScBioinformatics/Thesis/Project/Essential-EdgesPPIs/lib/translationMatlabCode.R', echo=TRUE)

library('igraph')

#Examples:
#adjacencyM <- matrix( c(0, 1, 0, 1, 1, 0, 0, 0, 0, 0, 0, 1, 1, 0, 0, 1), nrow=4, ncol = 4, byrow = T)

#communicabilityAngle(adjacencyM)

#communicabilityDistance(adjacencyM)

# ------- Results

adjacencyData <- read.csv(header = F, file = "data/YeastS-main.txt", sep = "\t")

adjacencyMatrix <- as.matrix(adjacencyData)

diag(adjacencyMatrix) <- 0

resultsEdgeBetw <- edge.betweenness(graph.adjacency(adjacencyMatrix, mode = "undirected"))

resultsEdgeBetw[order(resultsEdgeBetw)]

resultsComAngle <- communicabilityAngle(adjacencyMatrix)

resultsComDist <- communicabilityDistance(adjacencyMatrix)

#write.table (resultsEdgeBetw, file = "data/resultsEdgeBetweennessPPIsYeast.txt", row.names = F, col.names = F)

resultsComDist[upper.tri(resultsComDist, diag = FALSE)] <- 0
resultsComDist[adjacencyMatrix == 0] <- 0

