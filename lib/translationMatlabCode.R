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
      comAngl[i,j] <- acos(expAM[i,j]/sqrt(expAM[i,i]*expAM[j,j]));
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

# edge betweenness centrality #
#function [EBC BC]=edge_betweenness_wei(G)
# n=length(G);
# # E=find(G); G(E)=1./G(E);        #invert weights
# BC=zeros(n,1);                  #vertex betweenness
# EBC=zeros(n);                   #edge betweenness
# 
# for u=1:n
# D=inf(1,n); D(u)=0;         #distance from u
# NP=zeros(1,n); NP(u)=1;     #number of paths from u
# S=true(1,n);                #distance permanence (true is temporary)
# P=false(n);                 #predecessors
# Q=zeros(1,n); q=n;          #order of non-increasing distance
# 
# G1=G;
# V=u;
# while 1
# S(V)=0;                 #distance u->V is now permanent
# G1(:,V)=0;              #no in-edges as already shortest
# for v=V
# Q(q)=v; q=q-1;
# W=find(G1(v,:));                #neighbours of v
# for w=W
# Duw=D(v)+G1(v,w);           #path length to be tested
# if Duw<D(w)                 #if new u->w shorter than old
# D(w)=Duw;
# NP(w)=NP(v);            #NP(u->w) = NP of new path
# P(w,:)=0;
# P(w,v)=1;               #v is the only predecessor
# elseif Duw==D(w)            #if new u->w equal to old
# NP(w)=NP(w)+NP(v);      #NP(u->w) sum of old and new
# P(w,v)=1;               #v is also a predecessor
# end
# end
# end
# 
# minD=min(D(S));
# if isempty(minD), break             #all nodes reached, or
# elseif isinf(minD),                 #...some cannot be reached:
# Q(1:q)=find(isinf(D)); break        #...these are first-in-line
# end
# V=find(D==minD);
# end
# 
# DP=zeros(n,1);                          #dependency
# for w=Q(1:n-1)
# BC(w)=BC(w)+DP(w);
# for v=find(P(w,:))
# DPvw=(1+DP(w)).*NP(v)./NP(w);
# DP(v)=DP(v)+DPvw;
# EBC(v,w)=EBC(v,w)+DPvw;
# end
# end
# end
edge_betweenness_wei <- function(G) {
#EDGE_BETWEENNESS_WEI    Edge betweenness centrality
#
#   EBC = edge_betweenness_wei(W);
#   [EBC BC] = edge_betweenness_wei(W);
#
#   Edge betweenness centrality is the fraction of all shortest paths in 
#   the network that contain a given edge. Edges with high values of 
#   betweenness centrality participate in a large number of shortest paths.
#
#   Input:      A,      binary (directed/undirected) connection matrix.
#
#   Output:     EBC,    edge betweenness centrality matrix.
#               BC,     nodal betweenness centrality vector.
#
#   Notes:
#       The input matrix must be a mapping from weight to distance. For 
#   instance, in a weighted correlation network, higher correlations are 
#   more naturally interpreted as shorter distances, and the input matrix 
#   should consequently be some inverse of the connectivity matrix.
#       Betweenness centrality may be normalised to [0,1] via BC/[(N-1)(N-2)]
#
#   Reference: Brandes (2001) J Math Sociol 25:163-177.
#
#
#   Mika Rubinov, UNSW, 2007-2010

  n <- length(G)
  BC <- matrix(0, n, 1)
  EBC <- array(0, n)
  
  for (u in 1:n){
    D <- array(Inf, c(1,n))
    D[u] <- 0
    NP <- array(0, c(1,n))
    NP[u] <- 1
    S <- array(T, c(1,n))
    P <- array(F, c(n))
    Q <- array(0, c(1,n))
    q <- n
    
    G1 <- G
    V <- u
    
    while (1){ #I don't like this
      S[u] <- 0;
      G1[,V] <- 0
      for (v in V) {
        Q[q] <- v
        q <- q - 1
        W <- which(G1[v,] != 0)
        for (w in W){
          Duw <- D[v] +  G1[v,w]
          if (Duw<D[w]){
            D[w] <- Duw
            NP[w] <- NP[v];
            P[w,] <- 0;
            P[w,v] <- 1; 
          }
          else if (Duw==D(w)){
            NP[w] <- NP[w] + NP[v];
            P[w,v] <- 1
          }
        }
      }
      
      minD <- min(D[S])
      if is.empty.model(minD){
        break 
      }
      else if (is.infinite(minD)){
        Q[1:q] <- which(is.infinite(D))
        break
      }
      V <- which(D == minD);
    }
    DP <- array(0, c(n,1));
    for (w in Q[1:n-1]) {
      BC[w] <- BC[w] + DP[w];
      for (v in which(P[w,] != 0)) {
        DPvw <- (1+DP[w]) * NP[v] / NP[w];
        DP[v] <- DP[v] + DPvw;
        EBC[v,w] <- EBC[v,w] + DPvw;
      }
    }
  }
}
#########∫