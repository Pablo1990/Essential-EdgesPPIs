#Developed by Pablo Vicente-Munuera

allFile = open('../data/ClusterPPIsNormalized.csv', 'w')


for i in range(1,127) :
	nameFi = '../data/cluster/EBCEssentialPPIs' + str(i) + '.csv'
	ebcs = open(nameFi, 'r')

	nameOut = '../data/cluster/EBCEssentialPPIsNormalized' + str(i) + '.csv'
	final = open(nameOut, 'w')

	listEBC = list()
	for ebc in ebcs:
		fields = ebc.split(';')
		auxNumber = fields[3][:-1]

		listEBC.append(float(auxNumber.replace(',', '.')))

	norm = [float(i)/sum(listEBC) for i in listEBC]
	norm2 = [float(i)/max(listEBC) for i in listEBC]
	#print norm
	

	ebcs.seek(0)
	cont = 0
	for ebc in ebcs:
		final.write(ebc[:-1] + ";" + str(norm[cont]).replace('.', ',') + ";"+ str(norm2[cont]).replace('.', ',') +"\n")
		allFile.write(ebc[:-1] + ";" + str(norm[cont]).replace('.', ',') + ";"+ str(norm2[cont]).replace('.', ',') +"\n")
		cont = cont + 1

	final.close()

allFile.close()