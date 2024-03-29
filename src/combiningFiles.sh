#!/bin/bash
#Developed by Pablo Vicente-Munuera

#Purpose: Combining cluster files without header into only one

cat "" > /Users/pablovm1990/Documents/Dropbox/MScBioinformatics/Thesis/Project/Essential-EdgesPPIs/data/ClusterSpinglassWeightedCommPPIs.csv
for file in /Users/pablovm1990/Documents/Dropbox/MScBioinformatics/Thesis/Project/Essential-EdgesPPIs/data/cluster/EBCSpinglassWeightedCommPPIs*
do
	echo "Adding $file"
	awk 'NR != 1' $file >> /Users/pablovm1990/Documents/Dropbox/MScBioinformatics/Thesis/Project/Essential-EdgesPPIs/data/ClusterSpinglassWeightedCommPPIs.csv
done