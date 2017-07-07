# clears workspace: 
rm(list=ls()) 

library(tidyverse)
library(rstan)
library(shinystan)
library(ggmcmc)

model = "
// Hierarchical Signal Detection Theory
data { 
  int<lower=1> k;
  int<lower=0> h[k];
  int<lower=0> f[k];
  int<lower=0> s;
  int<lower=0> n;
}
parameters {
  vector[k] d;
  vector[k] c;
  real muc;
  real mud;
  real<lower=0> lambdac;
  real<lower=0> lambdad;
} 

transformed parameters {
  real<lower=0,upper=1> thetah[k];
  real<lower=0,upper=1> thetaf[k];
  real<lower=0> sigmac;
  real<lower=0> sigmad;
  
  sigmac = inv_sqrt(lambdac);
  sigmad = inv_sqrt(lambdad);
  
  // Reparameterization Using Equal-Variance Gaussian SDT
  for(i in 1:k) {
    thetah[i] = Phi(d[i] / 2 - c[i]);
    thetaf[i] = Phi(-d[i] / 2 - c[i]);
  }
}
model {
  // Priors 
  muc ~ normal(0, inv_sqrt(.001));
  mud ~ normal(0, inv_sqrt(.001));
  lambdac ~ gamma(.001, .001);
  lambdad ~ gamma(.001, .001);
  
  // Discriminability and Bias
  c ~ normal(muc, sigmac);
  d ~ normal(mud, sigmad);
  // Observed counts
  h ~ binomial(s, thetah);
  f ~ binomial(n, thetaf);
}"

source("heit_rotello.RData") #loads the data

niter   = 10000
nburnin = 5000

for (dataset in 1:2) {  #analyze both conditions

  if (dataset == 1)
    data = std_i # the induction data
  if (dataset == 2)
    data = std_d # the deduction data
  
  h = data[, 1]
  f = data[, 2]
  MI = data[, 3]
  CR = data[, 4]
  s = h + MI
  n = f + CR
  s = s[1]; n = n[1] #Each subject gets same number of signal and noise trials 
  k = nrow(data) 

  data = list(h=h, f=f, s=s, n=n, k=k) # To be passed on to Stan

  myinits = list(
    list(d=rep(0, k), c=rep(0, k), mud=0, muc=0, lambdad=1, lambdac=1)) 

  # Parameters to be monitored
  parameters = c("mud", "muc", "sigmad", "sigmac")
  
  if (dataset == 1) {
    # The following command calls Stan with specific options.
    # For a detailed description type "?rstan".
    isamples = stan(model_code=model,   
                     data=data, 
                     init=myinits,  # If not specified, gives random inits
                     pars=parameters,
                     iter=niter, 
                     chains=1, 
                     thin=1,
                     warmup=nburnin,  # Stands for burn-in; Default = iter/2
                     # seed=123  # Setting seed; Default is random seed
    )
  }
  if (dataset == 2) {
    # The following command calls Stan with specific options.
    # For a detailed description type "?rstan".
    dsamples = stan(fit=isamples,   
                     data=data, 
                     init=myinits,  # If not specified, gives random inits
                     pars=parameters,
                     iter=niter, 
                     chains=1, 
                     thin=1,
                     warmup=nburnin,  # Stands for burn-in; Default = iter/2
                     # seed=123  # Setting seed; Default is random seed
    )
  }
}
# Now the values for the monitored parameters are in the "isamples" and 
# "dsamples "objects, ready for inspection.

########################################
## plotting (MF)
#####Figure 11.5 & 11.6
########################################

ms = rbind(ggs(isamples) %>% mutate(condition = "induction"),
           ggs(dsamples) %>% mutate(condition = "deduction"))

plotData = filter(ms, Parameter %in% c("mud", "muc")) %>% 
  droplevels %>% 
  spread(Parameter, value)

number_of_samples_to_plot = niter/2 %>% round
ggplot(filter(plotData, Iteration %in% sample(niter, number_of_samples_to_plot)), 
       aes(x = mud, y = muc, color = condition)) + geom_point()

ggplot(plotData,
       aes( x= mud, color = condition)) + 
  geom_density() + ggtitle("mean discrimability")

ggplot(plotData,
       aes( x=muc, color = condition)) + 
  geom_density() + ggtitle("mean bias")

stop()

######################################
## added goodies
######################################

# # visually explore the MCMC results
# shinystan::launch_shinystan(isamples)
# shinystan::launch_shinystan(dsamples)
# 
# # inspect potential difference in mean discriminability
# # between induction and deduction conditions
mud_diffs = as.double(rstan::extract(dsamples)$mud) - as.double(rstan::extract(isamples)$mud)
plot(density(mud_diffs))
coda::HPDinterval(coda::as.mcmc(mud_diffs)) # 95% HDI contain 0?
