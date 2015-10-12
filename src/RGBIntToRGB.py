#Developed by Pablo Vicente-Munuera

while (True):
	RGBint = input("RGBint: ")
	Blue =  RGBint & 255
	Green = (RGBint >> 8) & 255
	Red =   (RGBint >> 16) & 255

	print (Red)
	print (Green)
	print (Blue)
