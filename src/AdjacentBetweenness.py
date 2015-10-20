#Developed by Pablo Vicente-Munuera

orderPPIs = open('../data/orderPPIsFromBetweennessCentrality.csv', 'r')
vertices = open('../data/verticesBetweenness.csv', 'r')
vertices.readline()

finalCebc = open('../data/adjacentBetweennessPPIs.csv', 'w')

for ppi in orderPPIs:
	protein = ppi.split(';')

	vertices.seek(0)
	protein1 = False
	betwProtein1 = 0
	protein2 = False
	betwProtein2 = 0
	for betweenness in vertices:
		betw = betweenness.split(';')
		#print protein
		#print betw
		if protein[1] == betw[0]:
			protein1 = True
			betwProtein1 = float(betw[1][:-1])
		elif protein[2][:-2] == betw[0]:
			protein2 = True
			betwProtein2 = float(betw[1][:-1])

		if protein1 and protein2:
			finalCebc.write(ppi[:-2] + ';' + str(min(betwProtein1, betwProtein2)) + '\n')
			break

	#break


finalCebc.close()