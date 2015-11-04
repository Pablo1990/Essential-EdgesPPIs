#Developed by Pablo Vicente-Munuera

ppis = open('../data/PPIsInfo/ppis.csv', 'r')
ppis.readline()

genesFile = open('../data/genes_function.csv', 'r')

overlapFile = open('../data/PPIsInfo/PPIsFunctionIndex.csv', 'w')
overlapFile.write('gene1;gene2;index\n')

cont = 0

for ppi in ppis:
	cont = cont + 1
	numPPIs = 6609
	print ("Overlapping PPI: " + str(cont) + "/" + str(numPPIs))
	genesFile.seek(0)
	genesFile.readline()
	ppiFields = ppi.split(';')
	functionGene1 = list()
	functionGene2 = list()
	for geneRow in genesFile:
		gene = geneRow.split(';')
		#print ppiFields
		if gene[0] == ppiFields[0]:
			functionGene1.append(gene[1][:-1].strip("[]").split(', '))
		elif gene[0] == ppiFields[1][:-2]:
			functionGene2.append(gene[1][:-1].strip("[]").split(', '))
			#print functionGene2

		if len(functionGene1) > 0 and len(functionGene2) > 0:
			overlap = list(set(functionGene1[0]) & set(functionGene2[0]))
			total = list(set(functionGene1[0]) | set(functionGene2[0]))
			index = float(float(len(overlap)) / float(len(total)))
			overlapFile.write(ppi[:-2] + ';' + str(index) + '\n')
			break

overlapFile.close()