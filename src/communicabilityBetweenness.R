#Developed by Pablo Vicente-Munuera
#Translate to R from:
#http://networkx.github.io/documentation/latest/_modules/networkx/algorithms/centrality/communicability_alg.html#communicability_betweenness_centrality

library("expm", lib.loc="/Library/Frameworks/R.framework/Versions/3.1/Resources/library")

communicabilityBetweennessCentrality <- function(adjacencyM){
  expAM <- expm(adjacencyM)
  vertices <- length(adjacencyM[1,])
  
  cbc <- c()
  
  for (i in 1:vertices){
    print(paste0("Vertex: ", i, "/", vertices))
    row <- adjacencyM[i,]
    col <- adjacencyM[,i]
    
    adjacencyM[i,] <- 0
    adjacencyM[,i] <- 0
    
    auxExp <- (expAM - expm(adjacencyM)) / expAM
    
    auxExp[i,] <- 0
    auxExp[,i] <- 0
    
    auxExp <- auxExp - diag(diag(auxExp))
    
    cbc <- c(cbc, sum(auxExp))
    
    adjacencyM[i,] <- row
    adjacencyM[,i] <- col
  }
  
  return (cbc)
}

#New function developed
communicabilityEdgeBetweennessCentrality <- function(adjacencyM){
  adjacencyM[upper.tri(adjacencyM, diag = FALSE)] <- 0
  expAM <- expm(adjacencyM)
  nrow <- length(adjacencyM[1,])
  ncol <- length(adjacencyM[,1])
  edges <- length(adjacencyM[adjacencyM == 1])
  cbc <- c()
  actualEdge <- 0
  for (i in 1:nrow){
    for (j in 1:ncol){
      if (adjacencyM[i,j] == 1){
        actualEdge <- actualEdge + 1
        print(paste0("Vertex: ", actualEdge, "/", edges))
        
        removedEdge <- adjacencyM[i,j]
        adjacencyM[i,j] <- 0
        
        auxExp <- (expAM - expm(adjacencyM)) / expAM
        
        auxExp[i,j] <- 0
        
        auxExp <- auxExp - diag(diag(auxExp))
        
        cbc <- c(cbc, sum(auxExp))
        
        adjacencyM[i,j] <- removedEdge
      }
    }
  }
  
  return (cbc)
}