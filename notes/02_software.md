## Basic programming language

The main programming language we use is [R](https://www.r-project.org). The slides and notes that accompany the lecture will use it, and whenever homeworks require programming, you will use it too.

It is recommended to use [RStudio](https://www.rstudio.com), because it nicely integrates with [Rmarkdown](http://rmarkdown.rstudio.com), which is what you should use for your homework assignments.

There will be a number of R packages that we will need. Most importantly, we will work in the [tidyverse](http://tidyverse.org). More necessary packages will be mentioned as we go along.

## Bayesian computation

We will use three programming languages specialized for the formulation and computation of probabilistic inference. These are: [JAGS](http://mcmc-jags.sourceforge.net), [Stan](http://mc-stan.org), and WebPPL. All have their respective strengths and weaknesses.

#### JAGS

[JAGS](http://mcmc-jags.sourceforge.net) is a specialized programming language to describe probabilistic models and perform Bayesian inference for these. It efficiently computes samples from the posterior distribution. We will communicate with JAGS from within R, using packages `runjags`, `R2jags` or `rjags`. We will use JAGS as a starting point and explore some simple cognitive models with it.

#### Stan

[Stan](http://mc-stan.org) is, like JAGS, a specialized programming language to describe probabilistic models and perform Bayesian inference for these. It efficiently computes samples from the posterior distribution and performs some additional magic (variational Bayes, MLE, ...). Stan is particularly powerful for the computation of hierarchical models and we will use it to explore Bayesian approaches to regression modeling. We will communicate with Stan from within R, using packages `RStan` and `RStanArm`.

#### WebPPL

[WebPPL](http://webppl.org) is a general purpose probabilistic programming language. We will use it for the exploration of some more complex cognitive models. We will communicate with WebPPL from within R, using package `RWebPPL`. WebPPL also has a browser-based interface, making it easy to explore simple probabilistic models very quickly.

## Bayesian statistics

A slick and accessible tool for Bayesian statistics is [JASP](https://jasp-stats.org/). We will use it early on to adventure into the differences between classical and Bayesian approaches to hypothesis testing and inference.
