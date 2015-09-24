dataStatistics <- read.csv2(file = "data/Initial-Data.csv")

eDataStatistics <- dataStatistics[dataStatistics$Type.of.link == "E",]
eeDataStatistics <- dataStatistics[dataStatistics$Type.of.link == "EE",]
neDataStatistics <- dataStatistics[dataStatistics$Type.of.link == "NE",]
yLimit <- 8000
par(yaxs = 'r')
plot(y = eDataStatistics$edge.betweenness.centrality, x = eDataStatistics$Communicability.angle, col = 'red', type = 'p', xlab='', ylab='', axes = F, ylim = c(0,yLimit))
par(new = T)
plot(y = eeDataStatistics$edge.betweenness.centrality, x = eeDataStatistics$Communicability.angle, col = 'cyan', type = 'p', xlab='', ylab='', axes = F, ylim = c(0,yLimit))
par(new = T)
plot(y = neDataStatistics$edge.betweenness.centrality, x = neDataStatistics$Communicability.angle, col = 'gray', type = 'p', ylim = c(0,yLimit))
legend('topright', c('E', 'EE', 'NE') , 
       lty=1, col=c('red', 'cyan', 'gray'), bty='n', cex=1)
par(new = F)