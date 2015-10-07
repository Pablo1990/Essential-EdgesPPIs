#Developed by Pablo Vicente-Munuera

library('igraph')
source('~/Documents/Dropbox/MScBioinformatics/Thesis/Project/Essential-EdgesPPIs/lib/translationMatlabCode.R', echo=TRUE)



#Examples:
#adjacencyM <- matrix( c(0, 1, 0, 1, 1, 0, 0, 0, 0, 0, 0, 1, 1, 0, 0, 1), nrow=4, ncol = 4, byrow = T)

#communicabilityAngle(adjacencyM)

#communicabilityDistance(adjacencyM)

# ------- Results

adjacencyData <- read.csv(header = F, file = "data/YeastS-main.txt", sep = "\t")

vertices <- read.csv2(header = F, file = "docs/proteins.csv")

vertices <- vertices$V2

row.names(adjacencyData) <- vertices
colnames(adjacencyData) <- vertices

adjacencyMatrix <- as.matrix(adjacencyData)

diag(adjacencyMatrix) <- 0

resultsEdgeBetw <- edge.betweenness(graph.adjacency(adjacencyMatrix, mode = "undirected"), directed = F)

graphM <- graph.adjacency(adjacencyMatrix, mode = "undirected")

edgesBetw <- get.edgelist(graphM)

edgesBetw <- as.matrix(resultsEdgeBetw)

edgesBetw <- cbind(edgesBetw, get.edgelist(graphM))


resultsComAngle <- communicabilityAngle(adjacencyMatrix)

resultsComDist <- communicabilityDistance(adjacencyMatrix)

resultsComAngle[adjacencyMatrix == 0] <- 0

row.names(resultsComAngle) <- vertices
colnames(resultsComAngle) <- vertices

resultsComDist[adjacencyMatrix == 0] <- 0

row.names(resultsComDist) <- vertices
colnames(resultsComDist) <- vertices

ppis <- read.csv2(header=T, file="data/ppis.csv")

finalResultsEdgeBetwenness <- c()
finalResultsComAngle <- c()
finalResultsComDist <- c()

for (i in 1:length(ppis[,1])){
  #finalResultsEdgeBetwenness <- c(finalResultsEdgeBetwenness, edgesBetw[(edgesBetw[,2] == as.character(ppis[i,1]) & edgesBetw[,3] == as.character(ppis[i,2])) | (edgesBetw[,2] == as.character(ppis[i,2]) & edgesBetw[,3] == as.character(ppis[i,1]))][1])
  finalResultsComAngle <- c(finalResultsComAngle, resultsComAngle[as.character(ppis[i,1]), as.character(ppis[i,2])])
  finalResultsComDist <- c(finalResultsComDist, resultsComDist[as.character(ppis[i,1]), as.character(ppis[i,2])])
}

write.csv(finalResultsComAngle, file="data/communicabilityAngleGoodOne.txt")

write.csv(finalResultsComDist, file="data/communicabilityDistanceGoodOne.txt")

#write.csv(finalResultsEdgeBetwenness, file = "data/edgeBetweennessCentrality.txt")

#finalResultsComAngle


#-----------

write(E(graphM)[order(resultsEdgeBetw)], file = "data/orderPPIs1.txt")

#write.graph(graphM, file = "data/orderPPIs1.txt", format = )

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


