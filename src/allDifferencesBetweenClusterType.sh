#!/bin/bash
#Developed by Pablo Vicente-Munuera

for i in 1 103 14 16 20 21 28 3 30 31 33 39 46 47 5 50 53 6 62 68 7 88 9
do
	for j in 1 103 14 16 20 21 28 3 30 31 33 39 46 47 5 50 53 6 62 68 7 88 9
	do
		num="$(python overlappingInteractionsClusters.py EBC $i $j)"

		#echo $num
		if test $num -gt 8
		then
			echo "$i, $j"
		fi
	done
done