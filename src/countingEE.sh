#Developed by Pablo Vicente-Munuera

cat "" > /Users/pablovm1990/Documents/Dropbox/MScBioinformatics/Thesis/Project/Essential-EdgesPPIs/data/EBCCutted.csv
> /Users/pablovm1990/Documents/Dropbox/MScBioinformatics/Thesis/Project/Essential-EdgesPPIs/data/EBCsWithEE.txt

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
	cont="$(cat $file | grep 'EE' | wc -l)"
	#echo $cont
	if test $cont -gt 3
	then
		aux2=`echo ${file:119} | cut -d'.' -f 1`
		#echo $aux2
		printf "$aux2 " >> /Users/pablovm1990/Documents/Dropbox/MScBioinformatics/Thesis/Project/Essential-EdgesPPIs/data/EBCsWithEE.txt
	fi
	wc -l < $file
done