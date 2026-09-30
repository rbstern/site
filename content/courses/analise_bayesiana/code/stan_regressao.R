library(tidyverse)
library(rstan)

# Exemplo de modelo de regressao simulado
beta = 3:5
tau = 49
K = length(beta)
N = 100
X = rnorm(N*K) %>% 
  matrix(nrow = N, ncol = K)
Y = X %*% beta + rnorm(N, 0, 1/tau)
Y = as.numeric(Y)

aux = stan("./content/courses/analise_bayesiana/code/stan_regressao.stan",
           data = list(N = N, K = K, X = X, Y = Y))

plot(aux, pars = c("beta"))

# Exemplo de modelo de ANOVA
K = 2
N = 100
X = rbinom(N*K, 1, 0.5) %>% 
  matrix(nrow = N, ncol = K)
X = cbind(rep(1, N), X)
X = cbind(X, X[,2]*X[,3])
K = 4
beta = c(0, 1, 1, 0.5)
tau = 4
Y = X %*% beta + rnorm(N, 0, 1/tau)
Y = as.numeric(Y)

aux = stan("./content/courses/analise_bayesiana/code/stan_regressao.stan",
           data = list(N = N, K = K, X = X, Y = Y))

plot(aux, pars = c("beta"))
