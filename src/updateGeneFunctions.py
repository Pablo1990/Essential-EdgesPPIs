#Code by Pablo Vicente-Munuera

def extractCategoryFrom(line):
	

data = open('../data/p3_p13838_Sac_cerev.txt', 'r')

numGenes = sum(1 for line in open('../data/genes.csv', 'r'))

genesFile = open('../data/genes.csv', 'r') #Arguments
genesFile.readline() #header

outputFile = open('../data/genes_function.txt', 'w') #The new file
outputFile.write("GENE;gene func.")

count = 0

notFoundGenes = ""
numberOfNotFound = 0

found = False

for gene in genesFile:
	count = count + 1
	print ("Looking for: " + gene[:-2] + ". " + str(count) + "/" + str(numGenes-1))
	data.seek(0) #Rewind
	data.readline() #The header
	for line in data:
		line = line.upper()
		#print (line)
		if line.startswith(gene[:-2]): #Shitty characters like '\n' and things like that
			#print (line)
			newLine = gene[:2] + ";"
			newLine = newLine + extractCategoryFrom(line)
			#outputFile.write(line)
			for xline in data:
				if xline.startswith('X\t'):
					outputFile.write(xline)
				else:
					break
			found = True
			break

	if found == False:
		notFoundGenes = notFoundGenes + gene[:-2]  + ", "
		numberOfNotFound = numberOfNotFound + 1

	found = False

genesFile.close()
data.close()
outputFile.close()

print("Number of genes not found: " + str(numberOfNotFound))

if numberOfNotFound > 0:
	print("Not found genes: " + notFoundGenes)
	print("\n :_( ")
else:
	print("You found all the genes!! Well done!")

