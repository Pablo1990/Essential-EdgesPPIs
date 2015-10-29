#Developed by Pablo Vicente-Munuera

allFile = open('../data/clustersTogether/ClusterLouvainWeighted.csv', 'w')


for i in range(1,48) :
	nameFi = '../data/clustersPPIs/LouvainWeighted' + str(i) + '.csv'
	ebcs = open(nameFi, 'r')
	ebcs.readline()
	print i

	nameOut = '../data/clustersPPIs/LouvainWeightedInfo' + str(i) + '.csv'
	final = open(nameOut, 'w')

	for ebc in ebcs:
		row = ebc.split(';')
		ppi = row[1]
		ppi = ppi.strip('[]"')
		ppi = ppi.split(' ')
		#print ppi
		essentialPPIs = open('../data/PPIsinfo/PPIsinfo.csv', 'r')
		essentialPPIs.readline()

		for essentialPPI in essentialPPIs:
			proteins = essentialPPI.split(';')

			if (proteins[0] == ppi[0] and proteins[1] == ppi[1]) or (proteins[1] == ppi[0] and proteins[0] == ppi[1]) :
				final.write(essentialPPI[:-2] + ";" + row[2])
				allFile.write(essentialPPI[:-2] + ";" + row[2])
				break


allFile.close()