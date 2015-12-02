#!/usr/bin/python
#Developed by Pablo Vicente-Munuera

#Purpose:
# Add relevante information: (Essentiality, EBC, communicability angle, distance)

nameFi = '../data/cebcPPIs.csv'
ebcs = open(nameFi, 'r')
#Read th header
ebcs.readline()
#Print the actual number of file
#print i

#Reading the proper information to add to the cluster
essentialPPIs = open('../data/PPIsinfo/PPIsEssentiality.csv', 'r')

#The output file of the cluster with all the information (Essentiality, EBC, communicability angle, distance)
nameOut = '../data/cebcPPIsInfo.csv'
final = open(nameOut, 'w')
final.write('Gene1; Gene2; B; C; D; Essentiality')

#Parsing the information
for ebc in ebcs:
	row = ebc.split(';')
	#print ppi

	
	#Read the f***ing header
	essentialPPIs.seek(0)
	essentialPPIs.readline()
	#print row
	#print (row[0] + ' ' + row[1])

	#We walk the file of the information
	for essentialPPI in essentialPPIs:
		proteins = essentialPPI.split(';')
		#print proteins
		
		#If the both genes of the PPI correspond to the read PPI
		if (str(proteins[0]) == str(row[0]) and str(proteins[1]) == str(row[1])) or (str(proteins[1]) == str(row[0]) and str(proteins[0]) == str(row[1])) :
			#It's added here (to both files)
			final.write(ebc[:-1] + ';' + proteins[2])
			#allFile.write(essentialPPI[:-2] + ";" + row[2])
			break

final.close()