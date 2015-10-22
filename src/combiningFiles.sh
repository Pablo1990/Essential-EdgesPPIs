
cat "" > /Users/pablovm1990/Documents/Dropbox/MScBioinformatics/Thesis/Project/Essential-EdgesPPIs/data/cluster/allEBCEssentialCommPPIs.csv
for file in /Users/pablovm1990/Documents/Dropbox/MScBioinformatics/Thesis/Project/Essential-EdgesPPIs/data/cluster/EBCEssentialCommPPIs*
do
	echo "Adding $file"
	awk 'NR != 1' $file >> /Users/pablovm1990/Documents/Dropbox/MScBioinformatics/Thesis/Project/Essential-EdgesPPIs/data/cluster/allEBCEssentialCommPPIs.csv
done