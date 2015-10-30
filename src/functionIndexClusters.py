#Developed by Pablo Vicente-Munuera
import glob, os

genesFile = open('../data/genes_function_Essentials.csv', 'r')

#EBCEssentialPPIsSpinglassWeighted
#EBCEssentialPPIs
#EBCEssentialPPIsWalktrap

clusterInfo = open('../data/clustersTogether/EBCEssentialPPIsWalktrapFunctionIndex.csv', 'w')
clusterInfo.write('file;Function Index;Essential proteins;Mean EBC;Number of PPIs\n')


os.chdir("/Users/pablovm1990/Documents/Dropbox/MScBioinformatics/Thesis/Project/Essential-EdgesPPIs/data/clustersPPIs")
for file in glob.glob("EBCEssentialPPIsWalktrap[0-9]*.csv"):
	ppis = open(file, 'r')
	print file
	totalGenes = 0
	totalFunctions = 0
	totalEssentials = 0
	totalEBC = 0
	totalPPIs = 0
	genes = {}
	for ppi in ppis:
		totalPPIs = totalPPIs + 1 
		ppiFields = ppi.split(';')
		totalEBC = totalEBC + float(ppiFields[3][:-1].replace(',', '.'))
		if ppiFields[0] in genes and ppiFields[1] in genes:
			continue

		genesFile.seek(0)
		genesFile.readline()

		for geneRow in genesFile:
			gene = geneRow.split(';')
			#print ppiFields
			if gene[0] == ppiFields[0] and not(ppiFields[1] in genes):
				totalGenes = totalGenes + 1
				function = len(gene[2][:-1].split(', '))
				genes[ppiFields[0]] = function
				totalFunctions = totalFunctions + function
				totalEssentials = totalEssentials + (1 if gene[1] == '1' else 0)
				
			elif gene[0] == ppiFields[1] and not(ppiFields[1] in genes):
				function = len(gene[2][:-1].split(', '))
				genes[ppiFields[1]] = function
				totalFunctions = totalFunctions + function
				totalEssentials = totalEssentials + (1 if gene[1] == '1' else 0)
				totalGenes = totalGenes + 1
				#print functionGene2
				

			if ppiFields[0] in genes and ppiFields[1] in genes:
				break

	#print file
	#print "Function Index: " + str((float(totalFunctions) / float(totalGenes)))
	#print "Essential proteins: " + str(totalEssentials)
	clusterInfo.write(file + ";" + str((float(totalFunctions) / float(totalGenes))).replace('.', ',') + ";" + 
		str(float(totalEssentials) / float(totalGenes)).replace('.', ',') + ";" + 
		str(float(totalEBC) / float(totalPPIs)).replace('.', ',') + ";" + str(totalPPIs) + "\n")
