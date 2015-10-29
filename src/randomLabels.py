#Developed by Pablo Vicente-Munuera
import random

#Total: 6609
#EE: 1179
#E: 2590
#NE: 2840

nameFi = '../data/PPIsInfo/PPIsEssentiality.csv'
essentialPPIs = open(nameFi, 'r')

for i in range(1,100):
	nameFiOut = '../data/randomLabels/random' + str(i) + '.csv'
	randomFile = open(nameFiOut, 'w')
	#randomFile.write('gene1;gene2;Type of link;Random\n')

	essentialPPIs.seek(0)
	essentialPPIs.readline()

	for ppi in essentialPPIs:
		#print random.random()
		r = '%f' % random.random()
		randomFile.write(ppi[:-2] + ";" + str(r) + "\n")

	randomFile.close()
