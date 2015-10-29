#Developed by Pablo Vicente-Munuera



> /Users/pablovm1990/Documents/Dropbox/MScBioinformatics/Thesis/Project/Essential-EdgesPPIs/data/EErandom.csv
for file in /Users/pablovm1990/Documents/Dropbox/MScBioinformatics/Thesis/Project/Essential-EdgesPPIs/data/randomLabels/*.csv
do
	sort -t ";" -k "4" $file | head -n 1179 | grep EE | wc -l >> /Users/pablovm1990/Documents/Dropbox/MScBioinformatics/Thesis/Project/Essential-EdgesPPIs/data/EErandom.csv
done