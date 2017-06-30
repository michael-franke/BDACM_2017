library(tidyverse)
library(rjags)
library(ggmcmc)

#################################################
## load data
#################################################

load("KruschkeData.Rdata")

#################################################
## prepare data
#################################################

x <- y
y <- rowSums(x) # successful identifications per category
t <- n * nsubj  # number of trials
dataList <- list(y=y, nstim=nstim, t=t, a=a, d1=d1, d2=d2)

#################################################
## define model script
#################################################

modelFile = "GCM_1.txt"

#################################################
## run JAGS & retrieve samples
#################################################

# set up and run model
jagsModel = jags.model(file = modelFile, 
                       data = dataList,
                       n.chains = 2)
update(jagsModel, n.iter = 15000)
codaSamples = coda.samples(jagsModel, 
                           variable.names = c("c", "w", "predy"),
                           n.iter = 50000)
ms = ggs(codaSamples)

#################################################
## extract & plot data
#################################################

c <- filter(ms, Parameter == "c")$value
w <- filter(ms, Parameter == "w")$value
predy <- rbind(codaSamples[[1]][, 2:9], codaSamples[[2]][, 2:9])

#### Figure 17.3 ####
plot(c, w, xlim=c(0, 5), ylim=c(0,1), xlab="Generalization", pch=4, cex=.4,
     ylab="Attention Weight")

#### Figure 17.4 ####
breaks <- seq(0, t, by=2)

windows(10, 5)
par(mgp=c(2, 1, 0), mar=c(4, 4, 2, 2) + .1)
plot(NA, xlim=c(0.5, 8.5), ylim=c(0, 320), xlab="Stimulus", yaxt="n", xaxt="n",
     ylab="Category Decision")
axis(side=1, 1:8)
axis(side=2, c(0, t), c("B", "A"))

for (i in 1:nstim) {
  counts=hist(predy[, i], plot=FALSE, breaks=breaks)$counts
  breaks=hist(predy[, i], plot=FALSE, breaks=breaks)$breaks
  
  segments(i - counts * .00003, breaks, i + counts * .00003, breaks, col="gray",
           lwd=4.5, lend=1)
}
apply(x * 40, 2, lines, lty=3, col="gray")
lines(apply(x * 40, 1, mean), lwd=3)



