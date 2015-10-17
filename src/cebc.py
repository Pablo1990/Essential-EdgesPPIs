import networkx as nx
import numpy

def communicability_edge_betweenness_centrality(G, normalized=True):
    import scipy
    import scipy.linalg
    edgelist = G.edges() # ordering of nodes in matrix
    n = len(edgelist)
    nodelist = G.nodes()
    nodelist = map(int, nodelist)
    nodelist.sort()
    nodelist = [str(i) for i in nodelist]
    A = nx.to_numpy_matrix(G, nodelist = nodelist, dtype = numpy.float64)
    # convert to 0-1 matrix
    A[A!=0.0] = numpy.float64(1)
    expA = scipy.linalg.expm(A)
    #mapping = dict(zip(edgelist,range(n)))
    sc = {}
    cont = 0
    for v in edgelist:
        print ("Edge: " + str(cont+1) + "/" + str(n))
        # remove row and col of node v
        i = int(v[0])
        j = int(v[1])
        cell1 = A[i,j].copy()
        cell2 = A[j,i].copy()
        A[i,j] = 0
        A[j,i] = 0
        B = (expA - scipy.linalg.expm(A)) / expA
        # sum with row/col of node v and diag set to zero
        B[i,j] = 0
        B[j,i] = 0
        B -= scipy.diag(scipy.diag(B))
        sc[cont] = (B.sum())
        cont = cont + 1
        # put row and col back
        A[i,j] = cell1
        A[j,i] = cell2
    # rescaling
    #sc = _rescale(sc,normalized=normalized)
    return sc

G=nx.read_edgelist("/Users/pablovm1990/Documents/Dropbox/MScBioinformatics/Thesis/Project/Essential-EdgesPPIs/edgeList.csv")
cebc = communicability_edge_betweenness_centrality(G)