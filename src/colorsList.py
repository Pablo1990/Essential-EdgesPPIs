#!/usr/bin/python
#Developed by Pablo Vicente-Munuera

#Purpose: 

functions = open('../data/colorList.txt', 'r')

coloursOuput = open('../data/colorListOut.txt', 'w')

'''
1 - 16711680 - RED
2 - 16753152 - Orange
10 - 16776960 - Yellow
11 - 9568000 - Green
12 - 65340 - Another green
14 - 65527 - aqua marine
20 - 48383 - blue
30 - 22015 - dark blue
32 - 8978687 - purple
34 - 12845311 - pink-purple
36 - 16711935 - magenta
38 - 16751001 - skin
40 - 2653184 - dark green - 0 124 21
41 - 10046464 - brown
42 - 6684723 - garnet
43 - 15073279 - light blue
47 - 13421823 - mallow
16 - 0 - black
18 - 16777215 - white
'''

for function in functions:
	fun = function[:-1].split(', ')
	colours = ''
	for f in fun:
		if f == '1':
			colours += '16711680,'
		elif f == '2':
			colours += '16753152,'
		elif f == '10':
			colours += '16776960,'
		elif f == '11':
			colours += '9568000,'
		elif f == '12':
			colours += '65340,'
		elif f == '14':
			colours += '65527,'
		elif f == '20':
			colours += '48383,'
		elif f == '30':
			colours += '22015,'
		elif f == '32':
			colours += '8978687,'
		elif f == '34':
			colours += '12845311,'
		elif f == '36':
			colours += '16711935,'
		elif f == '38':
			colours += '16751001,'
		elif f == '40':
			colours += '2653184,'
		elif f == '41':
			colours += '10046464,'
		elif f == '42':
			colours += '6684723,'
		elif f == '43':
			colours += '15073279,'
		elif f == '47':
			colours += '13421823,'
		elif f == '18':
			colours += '16777215,'
		elif f == '16':
			colours += '0,'

	colours = colours[:-1]
	colours += '\n'
	coloursOuput.write(colours)

functions.close()
coloursOuput.close()










