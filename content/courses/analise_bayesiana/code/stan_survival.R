library(rstan)
library(tidyverse)

lambda = 1
N = 100
t = rexp(N, rate = lambda)
t_cens = 1.5
t = lapply(t, function(t) min(t, t_cens)) %>% unlist()
N_cens = sum(t == t_cens)

aux = stan("./content/courses/analise_bayesiana/code/stan_survival.stan",
           data = list(N = N, N_cens = N_cens, t = t, t_cens = t_cens))

plot(aux)
lambda_sim = rstan::extract(aux)$lambda
mean(lambda_sim)
quantile(lambda_sim, c(0.025, 0.975))
hist(lambda_sim)
