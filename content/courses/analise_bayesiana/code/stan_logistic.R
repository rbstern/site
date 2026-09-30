library(rstan)
library(tidyverse)

alpha = 2
beta = 3
N = 100
x <- rnorm(N)
y <- rbinom(N, 1, plogis(alpha + beta * x))

aux = stan(
  "./content/courses/analise_bayesiana/code/stan_logistic.stan",
  data = list(N = N, x = x, y = y)
)

plot(aux)
