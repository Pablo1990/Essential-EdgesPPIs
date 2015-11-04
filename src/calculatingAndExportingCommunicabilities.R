#Developed by Pablo Vicente-Munuera

#Purpose: We calculate the communicability angle and distance from the adjacency matrix of
# the yeast PPIs

#Igraph provides us graph manipulation functions and how to properly get measures of them
library('igraph')
#Explained inside the file
source('~/Documents/Dropbox/MScBioinformatics/Thesis/Project/Essential-EdgesPPIs/lib/translationMatlabCode.R', echo=TRUE)

#We read the adjacency matrix from the file
adjacencyData <- read.csv(header = F, file = "data/YeastS-main.txt", sep = "\t")

#Read the file of the proteins file
vertices <- read.csv2(header = F, file = "docs/proteins.csv")
#We get only the names of the proteins
vertices <- vertices$V2

#And then, we put together the name of the proteins (as column names and row names) and the table
row.names(adjacencyData) <- vertices
colnames(adjacencyData) <- vertices

#Conversion to a matrix
adjacencyMatrix <- as.matrix(adjacencyData)
#There's no relationships between the same proteins
diag(adjacencyMatrix) <- 0

#Calculate the communicability of the edges
communicabilityResults <- communicabilityEdges(adjacencyMatrix)
#Conversion to a dataframe to aglomerate all of them
commResuDataFrame <- as.data.frame(as.table(communicabilityResults))
#We only want the ones with freq distinct of zero
commResuDataFrame <- commResuDataFrame[commResuDataFrame$Freq!=0,]
#Write the results to a csv
write.csv2(commResuDataFrame, file = 'data/communicabilityRes.csv')

#Calculate the edge betweenness centrality
resultsEdgeBetw <- edge.betweenness(graph.adjacency(adjacencyMatrix, mode = "undirected"), directed = F)

#Create the graph from the adjacency matrix generated above
graphM <- graph.adjacency(adjacencyMatrix, mode = "undirected")

#edgesBetw <- get.edgelist(graphM)
#Conversion to a matrix
edgesBetw <- as.matrix(resultsEdgeBetw)
#Combine the both results
edgesBetw <- cbind(edgesBetw, get.edgelist(graphM))

#Calculate both communicabilities, angle and distance.
resultsComAngle <- communicabilityAngle(adjacencyMatrix)
resultsComDist <- communicabilityDistance(adjacencyMatrix)

#both methods returns all the communicabilities, however we only want
#the ones of the existing edges, so, we assigned 0 to the other ones
resultsComAngle[adjacencyMatrix == 0] <- 0
#Assigned the names of the proteins to the rows and columns
row.names(resultsComAngle) <- vertices
colnames(resultsComAngle) <- vertices
#We do the same for both results
resultsComDist[adjacencyMatrix == 0] <- 0
row.names(resultsComDist) <- vertices
colnames(resultsComDist) <- vertices

#We want in a proper order, so we get that order from this file
ppis <- read.csv2(header=T, file="data/ppis.csv")
#Initilalize the vectors
finalResultsEdgeBetwenness <- c()
finalResultsComAngle <- c()
finalResultsComDist <- c()

#And travel through the file and get the results of these PPIs
for (i in 1:length(ppis[,1])){
  #finalResultsEdgeBetwenness <- c(finalResultsEdgeBetwenness, edgesBetw[(edgesBetw[,2] == as.character(ppis[i,1]) & edgesBetw[,3] == as.character(ppis[i,2])) | (edgesBetw[,2] == as.character(ppis[i,2]) & edgesBetw[,3] == as.character(ppis[i,1]))][1])
  finalResultsComAngle <- c(finalResultsComAngle, resultsComAngle[as.character(ppis[i,1]), as.character(ppis[i,2])])
  finalResultsComDist <- c(finalResultsComDist, resultsComDist[as.character(ppis[i,1]), as.character(ppis[i,2])])
}

#Finally, we write the results to a file
write.csv(finalResultsComAngle, file="data/communicabilityAngleGoodOne.txt")
write.csv(finalResultsComDist, file="data/communicabilityDistanceGoodOne.txt")


