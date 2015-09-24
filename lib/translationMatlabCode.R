#Code made by Hiroyasu Ando, translated to R by Pablo Vicente-Munuera

library("expm", lib.loc="/Library/Frameworks/R.framework/Versions/3.1/Resources/library")

#communicability angle for adjacency matrix A
# G=expm(A); #expm(X) = V*diag(exp(diag(D)))/V
# nodes=length(A);
# for i=1:nodes;
# for j=1:nodes;
# ComAng(i,j)=acos(G(i,j)/sqrt(G(i,i)*G(j,j)));
# end
# end
communicabilityAngle <- function(adjacencyM){
  expAM = expm(adjacencyM)
  nNodes = length (adjacencyM[1,])
  
  comAngl <- adjacencyM
  
  for (i in 1:nNodes){
    for (j in 1:nNodes){
      comAngl[i,j] <- 180*acos(expAM[i,j]/sqrt(expAM[i,i]*expAM[j,j]))/pi;
    }
  }
  return (comAngl)
}

# Communicability distance 
# G=expm(A);
# nodes=length(A);
# for i=1:nodes;
# for j=1:nodes;
# DistCom(i,j)=sqrt(G(i,i)+G(j,j)-2*G(i,j));
# end
# end
communicabilityDistance <- function(adjacencyM){
  expAM = expm(adjacencyM)
  nNodes = length (adjacencyM[1,])
  
  comDist <- adjacencyM
  
  for (i in 1:nNodes){
    for (j in 1:nNodes){
      comDist[i,j] <- sqrt(expAM[i,i]+expAM[j,j]- 2*expAM[i,j]);
    }
  }
  return (comDist)
}
#Replacement to the matlab function edge_betweenness_wei
#Based on the same algorithm (Brandes - 2001) - http://igraph.org/r/doc/betweenness.html
edge.betweenness()
#########