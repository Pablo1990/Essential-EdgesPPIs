#Developed by Pablo Vicente-Munuera

cat "" > /Users/pablovm1990/Documents/Dropbox/MScBioinformatics/Thesis/Project/Essential-EdgesPPIs/data/EBCCutted.csv

for file in /Users/pablovm1990/Documents/Dropbox/MScBioinformatics/Thesis/Project/Essential-EdgesPPIs/data/clustersPPIs/EBC/EBCInfo[0-9]*.csv
do
	echo "counting $file"
	for i in $(awk -F ';' '{ total += $8; count++ } END { print total/count }' $file)
		do
			aux="$(wc -l < $file)"
			value="$(echo "$i<$aux" | bc)"
			if [ $value == '1' ]
			then
				echo "Pal saco"
				cat $file >> /Users/pablovm1990/Documents/Dropbox/MScBioinformatics/Thesis/Project/Essential-EdgesPPIs/data/EBCCutted.csv
			fi
		done
	cat $file | grep 'EE' | wc -l
	wc -l < $file
done