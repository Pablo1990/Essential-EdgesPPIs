#Code by Pablo Vicente-Munuera

ppis = open('../data/ppis.csv', 'r')
ppis.readline()

genesFile = open('../data/genes_function.csv', 'r')

for ppi in ppis:
	genesFile.seek(0)
	genesFile.readline()
	gene = ppi.split(';')
	print (gene[0])
	print (gene[1][:-2])
	functionsGene1 = null
	functionsGene2 = null
	for geneInfo in genesFile:
		fields = geneInfo.split(';')
		if (fields[0] == gene[0]):
			functionsGene1 = fields[1].strip('[]').split(', ')
		else if (fields[0] == gene[1][:-2]):
			functionsGene2 = fields[1].strip('[]').split(', ')

	

