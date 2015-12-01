#!/usr/bin/python
#Developed by Pablo Vicente-Munuera

import networkx as nx
import numpy
import scipy
import scipy.linalg

# Purpose: New implementation (faster than the R one) of the communicability
# edge betweenness centrality based on the edge betweenness centrality of
# networkx
def communicability_edge_betweenness_centrality(G, normalized=True):
	fich = open('../data/cebc.csv', 'w')
	edgelist = G.edges() # ordering of nodes in matrix
	n = len(edgelist)
	nodelist = G.nodes()
	nodelist = map(int, nodelist)
	nodelist.sort()
	nodelist = [str(i) for i in nodelist]
	A = nx.to_numpy_matrix(G, nodelist = nodelist) #dtype = numpy.float64
	# convert to 0-1 matrix
	A[A!=0.0] = numpy.float64(1)
	expA = scipy.linalg.expm(A)
	#mapping = dict(zip(edgelist,range(n)))
	sc = {}
	cont = 0
	for v in edgelist:
		print ("Edge: " + str(cont+1) + "/" + str(n))
		# remove row and col of node v
		#print (A)
		i = int(v[0])
		j = int(v[1])
		#print (i)
		#print (j)
		cell1 = A[i,j].copy()
		cell2 = A[j,i].copy()
		#print (A[i,j])
		#print (A[j,i])
		A[i,j] = 0
		A[j,i] = 0
		withoutIJ = scipy.linalg.expm(A)
		#print (withoutIJ)
		B = (expA - withoutIJ) / withoutIJ
		# sum with row/col of node v and diag set to zero
		B[i,j] = 0
		B[j,i] = 0
		B -= scipy.diag(scipy.diag(B))
		#print (B.sum())
		sc[cont] = float(B.sum())
		D = (withoutIJ - expA) / withoutIJ
		D[i,j] = 0
		D[j,i] = 0
		D -= scipy.diag(scipy.diag(D))
		#print (D.sum())
		C = (expA - withoutIJ)
		C[i,j] = 0
		C[j,i] = 0
		C -= scipy.diag(scipy.diag(C))
		#print (C.sum())
		fich.write(v[0] + ';' + v[1] + ';' + str(B.sum()) + ';' + str(C.sum()) + ';' + str(D.sum()) + '\n')
		cont = cont + 1
		# put row and col back
		A[i,j] = cell1
		A[j,i] = cell2
	# rescaling
	#sc = _rescale(sc,normalized=normalized)
	fich.close()
	return sc

#Example of execution
G=nx.read_edgelist("/Users/pablovm1990/Documents/Dropbox/MScBioinformatics/Thesis/Project/Essential-EdgesPPIs/data/PPIsInfo/edgeslistPython.csv")
cebc = communicability_edge_betweenness_centrality(G)


