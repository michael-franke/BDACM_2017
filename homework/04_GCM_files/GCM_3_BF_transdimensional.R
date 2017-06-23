library(tidyverse)
library(rjags)
library(ggmcmc)
library(polspline)

#################################################
## load data
## gives us:
#### d1 & d2 -> an 8x8 matrix of distances each
#### y -> an 8x40 matrix of responses
#### a -> vector of category membership
#### n -> number of ???? (=8)
#### nstim -> number of stimuli (=8)
#### nsubj -> number of subjects (=8)
#################################################

load("04_KruschkeData.Rdata")

#################################################
## prepare data
#################################################

x <- y
y <- rowSums(x) # successful identifications per category
t <- n * nsubj  # number of trials
dataList <- list(y=y, nstim=nstim, t=t, a=a, d1=d1, d2=d2,
                 betaParameter = 50000)

#################################################
## define model script
#################################################

modelFile = "GCM_3_BF_transdimensional.txt"

#################################################
## funtion to run JAGS & retrieve samples
## depending on betaParameter for w
#################################################


# set up and run model
jagsModel = jags.model(file = modelFile, 
                       data = dataList,
                       n.chains = 2)
update(jagsModel, n.iter = 15000)
codaSamples = coda.samples(jagsModel, 
                           variable.names = c("m"),
                           n.iter = 150000)
# returns the sampled log likelihood values

#################################################
## Bayes Factor
#################################################

# your code here ...


