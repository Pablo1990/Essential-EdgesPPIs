#Developed by Pablo Vicente-Munuera

library('igraph')

ppis <- read.csv2(file = "data/PPIsInfo/PPIsFunctionIndexEssentialityStop.csv")

#ppis$index <- as.numeric(levels(ppis$index)[ppis$index])

i <- 4957

mean(ppis[1:i,][ppis[1:i,]$Type.of.link=="E",]$index)

mean(ppis[1:i,][ppis[1:i,]$Type.of.link=="EE",]$index)

mean(ppis[1:i,][ppis[1:i,]$Type.of.link=="NE",]$index)
