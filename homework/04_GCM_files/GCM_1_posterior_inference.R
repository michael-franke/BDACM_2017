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
dataList <- list(y=y, nstim=nstim, t=t, a=a, d1=d1, d2=d2)

#################################################
## define model script
#################################################

modelFile = "GCM_1_posterior_inference.txt"

#################################################
## run JAGS & retrieve samples
#################################################

# set up and run model
jagsModel = jags.model(file = modelFile, 
                       data = dataList,
                       n.chains = 2)
update(jagsModel, n.iter = 15000)
codaSamples = coda.samples(jagsModel, 
                           variable.names = c("c", "w"),
                           n.iter = 50000)
ms = ggs(codaSamples)

#################################################
## check convergence using R-hat
#################################################

# your code ...

#################################################
## estimate posterior density at w = 0.5
## using the polspline package
## and compute the Bayes Factor with the
## Savage-Dickey method
#################################################

# look at example from chapter 8.1/8.2 of Lee & Wagenmakers
# for use of polspline

# your code ...

#################################################
## check whether w=0.5 lies in he 95% HDI of
## the posterior
#################################################

# your code ...