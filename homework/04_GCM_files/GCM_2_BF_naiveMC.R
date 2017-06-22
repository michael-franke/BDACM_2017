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

modelFile = "GCM_2_BF_naiveMC.txt"

#################################################
## funtion to run JAGS & retrieve samples
## depending on betaParameter for w
#################################################

sample_likelihoods = function(betaParameter){
  # fix betaParameter for prior of w
  dataList$betaParameter = betaParameter
  # set up and run model
  jagsModel = jags.model(file = modelFile, 
                         data = dataList,
                         n.chains = 2)
  update(jagsModel, n.iter = 15000)
  codaSamples = coda.samples(jagsModel, 
                             variable.names = c("lh"),
                             n.iter = 150000)
  # returns the sampled log likelihood values
  filter(ggs(codaSamples), Parameter == "lh")$value
}


#################################################
## compute evidence
#################################################

# your code here ...



