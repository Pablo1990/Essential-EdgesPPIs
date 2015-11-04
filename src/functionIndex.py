#!/usr/bin/python
#Developed by Pablo Vicente-Munuera

#Our PPIs order by EBC
ppis = open('../data/PPIsInfo/ppis.csv', 'r')
#Reading the header
ppis.readline()

#The proteins and their functions
genesFile = open('../data/genes_function.csv', 'r')

#The output file
overlapFile = open('../data/PPIsInfo/PPIsFunctionIndex.csv', 'w')
overlapFile.write('gene1;gene2;index;overlap;total\n') #The header

#Counter of PPIs
cont = 0
#Walk through the PPIs
for ppi in ppis:
	#Show progress information
	cont = cont + 1
	numPPIs = 6609
	print ("Overlapping PPI: " + str(cont) + "/" + str(numPPIs))

	#Restart file of functions
	genesFile.seek(0)
	genesFile.readline()

	ppiFields = ppi.split(';')
	functionGene1 = list()
	functionGene2 = list()
	#Looking for the proteins of this concrete PPI
	for geneRow in genesFile:
		gene = geneRow.split(';')
		#print ppiFields
		#If there's the gene/protein we add his functions to the list
		if gene[0] == ppiFields[0]:
			functionGene1.append(gene[1][:-1].strip("[]").split(', '))
		elif gene[0] == ppiFields[1][:-2]:
			functionGene2.append(gene[1][:-1].strip("[]").split(', '))
			#print functionGene2

		#If we found both genes, we'll do the overlap, total and Index
		if len(functionGene1) > 0 and len(functionGene2) > 0:
			overlap = list(set(functionGene1[0]) & set(functionGene2[0]))
			total = list(set(functionGene1[0]) | set(functionGene2[0]))
			index = float(float(len(overlap)) / float(len(total)))
			overlapFile.write(ppi[:-2] + ';' + str(index) + ';' + str(len(overlap)) + ';' + str(len(total)) +'\n')
			break

overlapFile.close()