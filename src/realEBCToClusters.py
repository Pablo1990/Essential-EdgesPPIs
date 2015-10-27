#Developed by Pablo Vicente-Munuera

wholeEBC = open('../data/ppisWithEBCInfoColor.csv', 'r')
wholeEBC.readline()

cluster = open('../data/EBCEssentialPPIs13and18SpinglassWeighted1.csv', 'r')
cluster.readline()

outFile = open('../data/EBCWholeGraphEssentialPPIs13and18SpinglassWeighted1.csv', 'w')
outFile.write('Source;Target;EBC;Type\n')

for ppiCluster in cluster:
	ppiC = ppiCluster.split(';')
	wholeEBC.seek(0)
	wholeEBC.readline()

	for ppiWhole in wholeEBC:
		ppiW = ppiWhole.split(';')
		if (ppiW[0] == ppiC[0] and ppiW[1] == ppiC[1]) or (ppiW[1] == ppiC[0] and ppiW[0] == ppiC[1]) :
			outFile.write(ppiW[0] + ";" + ppiW[1] + ";" + ppiW[2] + ";" + ppiW[3] + "\n")
			break


