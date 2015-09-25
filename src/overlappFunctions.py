#Developed by Pablo Vicente-Munuera

ppis = open('../data/ppis.csv', 'r')
ppis.readline()

numPPIs = sum(1 for line in open('../data/ppis.csv', 'r'))

genesFile = open('../data/genes_function.csv', 'r')

overlapFile = open('../data/overlapPPIsFunction.csv', 'w')
overlapFile.write('gene1;gene2;functions of gene1;functions of gene2;overlap;number of overlap\n')

cont = 0

for ppi in ppis:
	cont = cont + 1
	print ("Overlapping PPI: " + str(cont) + "/" + str(numPPIs))
	genesFile.seek(0)
	genesFile.readline()
	gene = ppi.split(';')
	#print (gene[0])
	#print (gene[1][:-2])
	functionsGene1 = None
	functionsGene2 = None
	for geneInfo in genesFile:
		fields = geneInfo.split(';')
		if (fields[0] == gene[0]):
			functionsGene1 = fields[1].strip('[]\n').split(', ')
			if (functionsGene1[0] == ' xxx'):
				functionsGene1 = list()
		elif (fields[0] == gene[1][:-2]):
			functionsGene2 = fields[1].strip('[]\n').split(', ')
			if (functionsGene2[0] == ' xxx'):
				functionsGene2 = list()

	overlapFile.write(gene[0] + ";" + gene[1][:-2] + ";" + str(functionsGene1) + ";" + str(functionsGene2))
	if (functionsGene1 == list() or functionsGene2 == list()):
		overlap = list(set(functionsGene1) & set(functionsGene2))
		overlapFile.write(";" + str(overlap) + ";" + "n/a" + "\n")
	else:	
		overlap = list(set(functionsGene1) & set(functionsGene2))
		overlapFile.write(";" + str(overlap) + ";" + str(len(overlap)) + "\n")

