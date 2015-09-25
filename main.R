#Created by Pablo Vicente-Munuera
source('~/Documents/Dropbox/MScBioinformatics/Thesis/Project/Essential-EdgesPPIs/lib/translationMatlabCode.R', echo=TRUE)

library('igraph')

#Examples:
#adjacencyM <- matrix( c(0, 1, 0, 1, 1, 0, 0, 0, 0, 0, 0, 1, 1, 0, 0, 1), nrow=4, ncol = 4, byrow = T)

#communicabilityAngle(adjacencyM)

#communicabilityDistance(adjacencyM)

# ------- Results

adjacencyData <- read.csv(header = F, file = "data/YeastS-main.txt", sep = "\t")

vertices <- read.csv2(header = F, file = "../docs/proteins.csv")

vertices <- vertices$V2

row.names(adjacencyData) <- vertices
colnames(adjacencyData) <- vertices

adjacencyMatrix <- as.matrix(adjacencyData)

diag(adjacencyMatrix) <- 0

resultsEdgeBetw <- edge.betweenness(graph.adjacency(adjacencyMatrix, mode = "undirected"), directed = F)

graphM <- graph.adjacency(adjacencyMatrix, mode = "undirected")

resultsEdgeBetw[order(resultsEdgeBetw)]

resultsComAngle <- communicabilityAngle(adjacencyMatrix)

resultsComDist <- communicabilityDistance(adjacencyMatrix)

resultsComDistEdges <- resultsComDist[E(graphM)]

resultsComDistEdges[order(resultsEdgeBetw)]

write(E(graphM)[order(resultsEdgeBetw)], file = "data/orderPPIs1.txt")

write.graph(graphM, file = "data/orderPPIs1.txt", format = )

results <- data.frame(row.names = E(graphM), resultsComAngleEdges, resultsComDistEdges, resultsEdgeBetw)

write.csv2(results, file = "data/resultsGeneral.csv")

write.table (resultsComDistEdges[order(resultsEdgeBetw)], file = "data/resultsComDistEdges.txt")

sink(file = "data/orderPPIs1.txt")

E(graphM)

sink(file = NULL)

resultsComAngleEdges <- resultsComAngle[E(graphM)]

resultsComAngleEdges[order(resultsEdgeBetw)]

write.table (resultsComAngleEdges[order(resultsEdgeBetw)], file = "data/resultsComAngleEdges.txt")

#write.table (resultsEdgeBetw, file = "data/resultsEdgeBetweennessPPIsYeast.txt", row.names = F, col.names = F)

# resultsComDist[upper.tri(resultsComDist, diag = FALSE)] <- 0
# resultsComDist[adjacencyMatrix == 0] <- 0
# resultsComDist[resultsComDist > 0]
# resultsComDist[order(resultsEdgeBetw)]


