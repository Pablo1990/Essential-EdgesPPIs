#!/usr/bin/python
#Developed by Pablo Vicente-Munuera

#Purpose: 
genesNumbers = open('../data/genesNumbersEssentiality.csv', 'r')
genesNumbers.readline()

cebc = open('../data/cebc.csv', 'r')

cebcPPIs = open('../data/cebcPPIs.csv', 'w')
cebcPPIs.write('source; target; B; C; D\n')

for edges in cebc:
	edge = edges.split(';')

	genesNumbers.seek(0)
	genesNumbers.readline()

	lineToWrite = ''
	edge1 = False
	edge2 = False
	essential1 = False
	essential2 = False
	for geneNumber in genesNumbers:
		auxGeneNumber = geneNumber.split(';')
		#print auxGeneNumber
		#print auxGeneNumber[1][:-2]
		#print edge
		#print edge[1][:-1]
		#print auxGeneNumber
		if auxGeneNumber[1] == edge[0]:
			#print "culo"
			lineToWrite += auxGeneNumber[0] + ';'
			essential1 = int(auxGeneNumber[2][:-2])
			edge1 = True
		elif auxGeneNumber[1] == edge[1][:-1]:
			#print "hola"
			lineToWrite += auxGeneNumber[0] + ';'
			essential2 = int(auxGeneNumber[2][:-2])
			edge2 = True

		if edge1 and edge2:
			essentialText = False
			if essential1 + essential2 == 2:
				essentialText = 'EE'
			elif essential1 + essential2 == 3:
				essentialText = 'E'
			else :
				essentialText = 'NE'
			
			cebcPPIs.write(lineToWrite + essentialText + ';' + edge[2] + ';' + edge[3] + ';' + edge[4][:-1] + '\n')
			break