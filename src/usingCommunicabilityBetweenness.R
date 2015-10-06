#Developed by Pablo Vicente-Munuera
source('~/Documents/Dropbox/MScBioinformatics/Thesis/Project/Essential-EdgesPPIs/src/communicabilityBetweenness.R', echo=TRUE)

adjacencyData <- read.csv(header = F, file = "data/YeastS-main.txt", sep = "\t")

vertices <- read.csv2(header = F, file = "docs/proteins.csv")

vertices <- vertices$V2

row.names(adjacencyData) <- vertices
colnames(adjacencyData) <- vertices

adjacencyMatrix <- as.matrix(adjacencyData)

diag(adjacencyMatrix) <- 0

cbc <- communicabilityBetweennessCentrality(adjacencyMatrix)

cebc <- communicabilityEdgeBetweennessCentrality(adjacencyMatrix)
