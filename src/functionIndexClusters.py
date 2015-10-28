#Developed by Pablo Vicente-Munuera
import glob, os

genesFile = open('../data/genes_function_Essentials.csv', 'r')


os.chdir("/Users/pablovm1990/Documents/Dropbox/MScBioinformatics/Thesis/Project/Essential-EdgesPPIs/data/clustersPPIs")
for file in glob.glob("EBCEssentialPPIs[0-9]*.csv"):
	ppis = open(file, 'r')
	ppis.readline()

	totalGenes = 0
	totalFunctions = 0
	totalEssentials = 0
	genes = {}
	for ppi in ppis:
		ppiFields = ppi.split(';')
		if ppiFields[0] in genes and ppiFields[1] in genes:
			break

		genesFile.seek(0)
		genesFile.readline()

		for geneRow in genesFile:
			gene = geneRow.split(';')
			#print ppiFields
			if gene[0] == ppiFields[0]:
				totalGenes = totalGenes + 1
				function = len(gene[2][:-1].split(', '))
				genes[ppiFields[0]] = function
				totalFunctions = totalFunctions + function
				totalEssentials = totalEssentials + (1 if gene[1] == '1' else 0)
			elif gene[0] == ppiFields[1]:
				function = len(gene[2][:-1].split(', '))
				genes[ppiFields[1]] = function
				totalFunctions = totalFunctions + function
				totalEssentials = totalEssentials + (1 if gene[1] == '1' else 0)
				totalGenes = totalGenes + 1
				#print functionGene2

			if ppiFields[0] in genes and ppiFields[1] in genes:
				break

	print genes
	print (float(totalFunctions) / float(totalGenes))
