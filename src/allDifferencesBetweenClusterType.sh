#!/bin/bash
#Developed by Pablo Vicente-Munuera

#Purpose: this is file is go trought all the clusters number in there
# and see if any of them, can pass the test, if so , it print the number of clusters
#Right now the test is if any othem has an overlap with another cluster of 9 or more.

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