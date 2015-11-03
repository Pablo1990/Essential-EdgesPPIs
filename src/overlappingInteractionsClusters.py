#!/usr/bin/python
#Developed by Pablo Vicente-Munuera

import sys

#Purpose: Put together clusters, and see weather or not they share some interactions.
# As output: We'll get a number with the shared interactions and the file of all of the interations.

#Reading all the PPIs information
ppis = open('../data/PPIsInfo/PPIsInfo.csv', 'r')

#We need 3 inputs: Name of the clustering method (same name of the folder), and the two numbers of the clusters.
if len(sys.argv) == 4:
	try:
		#Preparing the output file
		nameClusterUnion = '../data/clustersTogether/' + sys.argv[1] + sys.argv[2] + '_' + sys.argv[3] + '.csv'
		clusterUnion = open(nameClusterUnion, 'w')
		clusterUnion.write(ppis.readline())

		#Preparing the first cluster file to be read
		nameCluster1 = '../data/clustersPPIs/' + sys.argv[1] + '/' + sys.argv[1] + 'Info' + sys.argv[2] + '.csv'
		cluster1 = open(nameCluster1, 'r')
		#cluster1.readline()

		#Preparing the second cluster file to be read
		nameCluster2 = '../data/clustersPPIs/' + sys.argv[1] + '/' + sys.argv[1] + 'Info'  + sys.argv[3] + '.csv'
		cluster2 = open(nameCluster2, 'r')
		#cluster2.readline()

		#The hash of the genes
		genes = {}

		#Counter for the number of PPIs on the cluster
		cluster1Cont = 0
		#Travel through the cluster and add all the unique genes to the hash
		for geneFields in cluster1:
			#Increasing the counter
			cluster1Cont = cluster1Cont + 1
			#Split by semicolon
			gene = geneFields.split(';')
			#adding the genes to the hash
			if not (gene[0] in genes):
				genes[gene[0]] = gene[0]
			if not (gene[1] in genes):
				genes[gene[1]] = gene[1]

		cluster2Cont = 0
		#Travel through the cluster and add all the unique genes to the hash
		for geneFields in cluster2:
			cluster2Cont = cluster2Cont + 1
			gene = geneFields.split(';')
			if not (gene[0] in genes):
				genes[gene[0]] = gene[0]
			if not (gene[1] in genes):
				genes[gene[1]] = gene[1]

		#print genes
		#Now we travel through the PPIs and add the PPIs that were in the clusters
		clusterUnionCont = 0
		for ppiFields in ppis:
			ppi = ppiFields.split(';')
			#print ppi[0]
			#print ppi[1]
			if ppi[0] in genes and ppi[1] in genes:
				clusterUnionCont = clusterUnionCont + 1
				clusterUnion.write(ppiFields)

		#See if there were any edges between the two clusters
		totalAdditions = clusterUnionCont - cluster1Cont - cluster2Cont
		print totalAdditions

	#If the file doesn't exist
	except Exception as e:
		print e
else:
	print "Incorrect arguments number"
