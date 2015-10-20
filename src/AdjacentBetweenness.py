#Developed by Pablo Vicente-Munuera

orderPPIs = open('../data/orderPPIsFromBetweennessCentrality.csv', 'r')
vertices = open('../data/verticesBetweenness.csv', 'r')
vertices.readline()

finalCebc = open('../data/adjacentBetweennessPPIs.csv', 'w')

for ppi in orderPPIs:
	protein = ppi.split(';')

	vertices.seek(0)
	totalBetweenness = 0
	protein1 = False
	protein2 = False
	for betweenness in vertices:
		betw = betweenness.split(';')
		#print protein
		#print betw
		if protein[1] == betw[0]:
			protein1 = True
			totalBetweenness = totalBetweenness + float(betw[1][:-1])
		elif protein[2][:-2] == betw[0]:
			protein2 = True
			totalBetweenness = totalBetweenness + float(betw[1][:-1])

		if protein1 and protein2:
			finalCebc.write(ppi[:-2] + ';' + str(totalBetweenness) + '\n')
			break

	#break


finalCebc.close()