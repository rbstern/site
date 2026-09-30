library(rstan)
library(tidyverse)

# Exemplo com dados simulados
# Dados
mu = 5
sigma = 2
N = 20
Y = rnorm(N, mu, sigma)

# Rodar o Stan
aux = stan(
  "./content/courses/analise_bayesiana/code/stan_normal_normal.stan",
  data = list(N = N, Y = Y)
)

# Exemplo de Inferencia

plot(aux, ci_level = 0.95, outer_level = 0.99, pars = c("mu"))
mu_sim = rstan::extract(aux)$mu
tau_sim = rstan::extract(aux)$tau

# Estimacao
mean(mu_sim)
mean(Y)
mean(tau_sim)

# Intervalo de credibilidade
quantile(mu_sim, probs = c(0.025, 0.975))

# Teste de hipotese
mean(mu_sim < 2.5)

