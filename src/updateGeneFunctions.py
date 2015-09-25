#Developed by Pablo Vicente-Munuera

def extractCategoryFrom(line):
	fields = line.split('\t')
	categories = fields[3].split('.')
	return categories[0]

data = open('../data/p3_p13838_Sac_cerev.txt', 'r')

numGenes = sum(1 for line in open('../data/genes.csv', 'r'))

genesFile = open('../data/genes.csv', 'r') #Arguments
genesFile.readline() #header

outputFile = open('../data/genes_function.csv', 'w') #The new file
outputFile.write("GENE;gene function\n")

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
		geneLine = line.split('\t')[0]
		if (geneLine == gene[:-2]): #Shitty characters like '\n' and things like that
			#print (line)
			newLine = gene[:-2] + ";"
			#newLine = newLine +  + ", "
			categories = []
			cat = extractCategoryFrom(line)
			if (cat != '-'):
				categories.append(int(cat))
			else:
				break
			#outputFile.write(line)
			for xline in data:
				if xline.startswith('X\t'):
					cat = extractCategoryFrom(xline)
					if (cat.startswith('X') == False):
						#newLine = newLine + cat + ", "
						categories.append(int(cat))
				else:
					break
			found = True
			outputFile.write(newLine + str(list(set(categories))))
			break

	if found == False:
		notFoundGenes = notFoundGenes + gene[:-2]  + ", "
		numberOfNotFound = numberOfNotFound + 1
		outputFile.write(gene[:-2] + "; xxx")

	found = False
	outputFile.write("\n")

genesFile.close()
data.close()
outputFile.close()

print("Number of genes not found: " + str(numberOfNotFound))

if numberOfNotFound > 0:
	print("Not found genes: " + notFoundGenes)
	print("\n :_( ")
else:
	print("You found all the genes!! Well done!")

