#Developed by Pablo Vicente-Munuera

orderPPIs = open('../data/orderPPIsFromBetweennessCentrality.csv', 'r')
cebcPPIs = open('../data/cebcPPIs.csv', 'r')
cebcPPIs.readline()

finalCebc = open('../data/finalCebc.csv', 'w')

for ppi in cebcPPIs:
	protein = ppi.split(';')

	orderPPIs.seek(0)
	for orders in orderPPIs:
		order = orders.split(';')
		#print protein
		if (order[1] == protein[0] and order[2][:-2] == protein[1]) or (order[2][:-2] == protein[0] and order[1] == protein[1]):
			finalCebc.write(order[0] + ';' + ppi)
			break


finalCebc.close()