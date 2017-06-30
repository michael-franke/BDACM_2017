library(tidyverse)
library(rjags)

#################################################
## load data
#################################################

load("KruschkeData.Rdata")

#################################################
## prepare data
#################################################

dataList <- list(y=y, nstim=nstim, nsubj=nsubj, n=n, a=a, d1=d1, d2=d2) 

#################################################
## define model script
#################################################

modelFile = "GCM_2.txt"

#################################################
## run JAGS & retrieve samples
#################################################

# set up and run model
jagsModel = jags.model(file = modelFile, 
                       data = dataList,
                       n.chains = 2)
update(jagsModel, n.iter = 1500)
codaSamples = coda.samples(jagsModel, 
                           variable.names = c("c", "w"),
                           n.iter = 5000)
#################################################
## extract & plot data
#################################################

#### Figure 17.7 ####
c <- rbind(codaSamples[[1]][, 1:40], codaSamples[[2]][, 1:40])
w <- rbind(codaSamples[[1]][, 41:80], codaSamples[[2]][, 41:80])

cMean <- apply(c, 2, mean)
wMean <- apply(w, 2, mean)
keep=sample(1:length(c[, 1]), size=20)

par(cex.lab=1.2)
plot("", xlim=c(0, 4), ylim=c(0,1), xlab="Generalization", xaxs="i", yaxs="i",
     ylab="Attention Weight")

for (i in 1:nsubj) {
  for (j in 1:length(keep)) {
    segments(cMean[i], wMean[i], c[keep[j], i], w[keep[j], i], col="gray")
  }
}
points(cMean, wMean, pch=16)

for (i in c(3, 31, 33))
  text(cMean[i], wMean[i], pos=4, labels = i, cex=1.3)



