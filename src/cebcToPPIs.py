#!/usr/bin/python
#Developed by Pablo Vicente-Munuera

#Purpose: 

edgelist = open('../data/edgelistPython.txt', 'r')
genesNumbers = open('../data/genesNumbers.csv', 'r')
genesNumbers.readline()

cebc = open('../data/cebc.txt', 'r')

cebcPPIs = open('../data/cebcPPIs.txt', 'w')
cebcPPIs.write('source; target; cebc;\n')

for edges in edgelist:
	edge = edges.split(', ')

	genesNumbers.seek(0)
	genesNumbers.readline()

	lineToWrite = ''
	edge1 = False
	edge2 = False
	for geneNumber in genesNumbers:
		auxGeneNumber = geneNumber.split(';')
		#print auxGeneNumber
		#print auxGeneNumber[1][:-2]
		#print edge
		#print edge[1][:-1]
		if auxGeneNumber[1][:-2] == edge[0]:
			#print "culo"
			lineToWrite += auxGeneNumber[0] + ';'
			edge1 = True
		elif auxGeneNumber[1][:-2] == edge[1][:-1]:
			#print "hola"
			lineToWrite += auxGeneNumber[0] + ';'
			edge2 = True

		if edge1 and edge2:
			cebcPPIs.write(lineToWrite + cebc.readline().split(': ')[1])
			break