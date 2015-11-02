#Developed by Pablo Vicente-Munuera
#!/usr/bin/python

import sys

ppis = open('../data/PPIsInfo/PPIsInfo.csv', 'r')


if len(sys.argv) == 4:
	try:
		nameClusterUnion = '../data/clustersTogether/' + sys.argv[1] + sys.argv[2] + '_' + sys.argv[3] + '.csv'
		clusterUnion = open(nameClusterUnion, 'w')
		clusterUnion.write(ppis.readline())

		nameCluster1 = '../data/clustersPPIs/' + sys.argv[1] + '/' + sys.argv[1] + 'Info' + sys.argv[2] + '.csv'
		cluster1 = open(nameCluster1, 'r')
		#cluster1.readline()

		nameCluster2 = '../data/clustersPPIs/' + sys.argv[1] + '/' + sys.argv[1] + 'Info'  + sys.argv[3] + '.csv'
		cluster2 = open(nameCluster2, 'r')
		#cluster2.readline()

		genes = {}

		cluster1Cont = 0
		for geneFields in cluster1:
			cluster1Cont = cluster1Cont + 1
			gene = geneFields.split(';')
			if not (gene[0] in genes):
				genes[gene[0]] = gene[0]
			if not (gene[1] in genes):
				genes[gene[1]] = gene[1]

		cluster2Cont = 0
		for geneFields in cluster2:
			cluster2Cont = cluster2Cont + 1
			gene = geneFields.split(';')
			if not (gene[0] in genes):
				genes[gene[0]] = gene[0]
			if not (gene[1] in genes):
				genes[gene[1]] = gene[1]

		#print genes
		clusterUnionCont = 0
		for ppiFields in ppis:
			ppi = ppiFields.split(';')
			#print ppi[0]
			#print ppi[1]
			if ppi[0] in genes and ppi[1] in genes:
				clusterUnionCont = clusterUnionCont + 1
				clusterUnion.write(ppiFields)

		totalAdditions = clusterUnionCont - cluster1Cont - cluster2Cont
		print totalAdditions

	
	except Exception as e:
		print e
else:
	print "Incorrect arguments number"
